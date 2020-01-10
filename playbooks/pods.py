#!/bin/python

import subprocess
import sys
import time

def install_mod(package):
    try:
        __import__(package)
    except:
        subprocess.check_call([sys.executable, "-m", "pip", "install", package, "--user"])
    finally:
        sys.path.append("/home/vagrant/.local/lib/python3.6/site-packages/")

install_mod("kubernetes")
# Script obtained from https://github.com/kubernetes-client/python

from kubernetes import client, config

# Configs can be set in Configuration class directly or using helper utility
config.load_kube_config()

print("Listing pods with their IPs:")

for i in range(0,15):
    try:
        v1 = client.CoreV1Api()
        ret = v1.list_pod_for_all_namespaces(watch=False)
        for i in ret.items:
            print("%s\t%s\t%s" % (i.status.pod_ip, i.metadata.namespace, i.metadata.name))

        break
    except:
        time.sleep(30)
        pass
