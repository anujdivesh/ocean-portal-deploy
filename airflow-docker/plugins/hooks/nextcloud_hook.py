from airflow.hooks.base import BaseHook
import owncloud

class NextcloudHook(BaseHook):

    def __init__(self, conn_id):

        super().__init__()
        config = self.get_connection(conn_id)
        self.oc = owncloud.Client(config.host)
        self.oc.login(config.login, config.password)


    def send_file(self, target, source):

        self.oc.put_file(target, source)