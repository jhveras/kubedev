#!/bin/bash

OUTPUT=/tmp/pod_status

python -c "import kubernetes" > /dev/null

if [[ $? -gt 0 ]]; then
  pip install kubernetes --user
fi

# k8s_status=$(python /vagrant/pods.py)
python /vagrant/pods.py > ${OUTPUT} 2>&1

COUNTER=0
while [[ $(cat ${OUTPUT} | grep "Connection refused") ]] && [[ $COUNTER -lt 15 ]]; do
  # echo "Waiting for kubernetes to be ready - attempt # ${COUNTER}"
  echo "Waiting for kubernetes to be ready - attempt # $((COUNTER+1))"
  sleep 30
  # k8s_status=$(python /vagrant/pods.py)
  python /vagrant/pods.py > ${OUTPUT} 2>&1
  let COUNTER=COUNTER+1
done

python /vagrant/pods.py

