
class PathManager:
    # Hardcoded URL paths
    base_dir = "/opt/airflow/dags/code"
    #base_dir = "/home/pop/Desktop/airflow/oceanobs/airflow_deploy/dags/code"
    #datasets = "/opt/airflow/ocean_portal/datasets"
    datasets = "/data"
    #datasets = "/home/pop/ocean_portal/datasets"
    URLS = {
        'ocean-api': 'https://dev-oceanportal.spc.int/middleware/api',
        'tmp': base_dir+'/tmp',
        'odbaac': base_dir,
        'copernicus-credentials': base_dir+'/.copernicusmarine/.copernicusmarine-credentials',
        'root-dir': datasets
    }

    @classmethod
    def get_url(cls, key, *args):
        """Constructs a URL by joining the specified base URL with the provided arguments."""
        if key not in cls.URLS:
            raise ValueError(f"Invalid key '{key}'. Available keys: {list(cls.URLS.keys())}")
        return "/".join([cls.URLS[key]] + list(args))