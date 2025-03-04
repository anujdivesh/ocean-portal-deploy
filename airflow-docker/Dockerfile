FROM apache/airflow:latest

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential gcc python3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/airflow/ocean_portal

USER airflow
COPY ./requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
