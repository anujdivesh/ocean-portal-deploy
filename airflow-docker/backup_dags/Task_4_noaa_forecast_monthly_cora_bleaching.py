from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta
from airflow.operators.python_operator import PythonOperator
from airflow.models import XCom
import os, sys
import warnings
import logging
sys.path.append('/opt/airflow/dags/code')
from controller_task import initialize_taskController
from datetime import datetime
from utility_functions import Utility
from controller_server_path import PathManager
from update_thredds import thredds


def task_2(**kwargs):
    #warnings.warn("This is a warning message!", category=UserWarning)
    #raise Exception("This task has failed intentionally!")
    #logging.info("Data download in progress")
    url= PathManager.get_url('ocean-api','task_download')
    tasks = initialize_taskController(url)
    download_succeed, is_error = False, False

    for task in tasks:
        if task.class_id == "download":
            execute = Utility.time_diff(datetime.now(),datetime.strptime(task.next_run_time,"%Y-%m-%dT%H:%M:%SZ"))
            #REMOVE THIS IN PROD
            #execute = True
            if task.id == 6 and execute:
                print('Executing Task No.%s - %s' % (task.id, task.task_name))
                download_succeed, is_error = task.dataDownload()
            else:
                print('nothing to do.')
    #kwargs['ti'].xcom_push(key='download_succeed', value=download_succeed)
    #kwargs['ti'].xcom_push(key='is_error', value=is_error)
    print(f"Pushing to XCom: download_succeed={download_succeed}, is_error={is_error}")
    kwargs['ti'].xcom_push(key='download_succeed', value=download_succeed)
    kwargs['ti'].xcom_push(key='is_error', value=is_error)

    return download_succeed, is_error


def task_3(**kwargs):
    # Pull the results from XComs
    ti = kwargs['ti']
    download_succeed = ti.xcom_pull(task_ids='download_dataset', key='download_succeed')
    is_error = ti.xcom_pull(task_ids='download_dataset', key='is_error')

    print(f"Download Succeeded: {download_succeed}")
    print(f"Is Error: {is_error}")
    print('----------------------------------------------------------------------------------------------')
    print('----------------------------------------------------------------------------------------------')
    print(download_succeed)

    if download_succeed:
        print("Merging results...")
        fpath = "/data/model/regional/noaa/forecast/monthly/coral_bleaching/latest.nc"
        fout = "/data/model/regional/noaa/forecast/monthly/coral_bleaching/latest_merged.nc"
        task.merge_weekly_coral_bleaching_forecast(fpath,fout)
    else:
        print("Skipping merging due to errors or failed download.")

default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    'start_date': datetime(2025, 1, 12),
    "email": ["divesha@spc.int"],
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=10),
}

dag = DAG("Task_4_noaa_forecast_monthly_coral_bleaching", default_args=default_args, schedule_interval='@hourly', catchup=False,)

# t1, t2 and t3 are examples of tasks created by instantiating operators
t1 = BashOperator(task_id="initialize_download", bash_command="date", dag=dag)

t2 = PythonOperator(
    task_id='download_dataset',
    python_callable=task_2,
    provide_context=True,
    dag=dag,
)

t3 = BashOperator(
    task_id="init_thredds",
    bash_command="sleep 180",  # sleep for 5 minutes (300 seconds)
    dag=dag,
)


t4 = PythonOperator(
    task_id="merge_results",
    python_callable=task_3,
    provide_context=True,  # Ensure context is passed to the function
    dag=dag,
)





t1 >> t2 >> t4

