import os
import requests
from requests.utils import DEFAULT_CA_BUNDLE_PATH

# https://github.com/dbt-labs/dbt-core/issues/8554#issuecomment-1715874918
# Try the followings of following the above advices
# `pip install --no-cache --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org certifi
# `pip install --no-cache --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org pip-system-certs`

url = "https://hub.getdbt.com"

try:
    response = requests.get(url, timeout=10)
    print("It worked")
except Exception as e:
    print("It didn't work\n")

    print(f"HTTPS_PROXY: {os.environ.get('HTTPS_PROXY')}")
    print(f"REQUESTS_CA_BUNDLE: {os.environ.get('REQUESTS_CA_BUNDLE')}")
    print(f"CURL_CA_BUNDLE: {os.environ.get('CURL_CA_BUNDLE')}")
    print(f"DEFAULT_CA_BUNDLE_PATH: {DEFAULT_CA_BUNDLE_PATH}")