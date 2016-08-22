#!/bin/bash

set -xe

BASEDIR=`dirname $0`

#import VNF descriptor
tacker vnfd-create --vnfd-file ${BASEDIR}/test-vnfd1.yaml
tacker vnfd-create --vnfd-file ${BASEDIR}/test-vnfd2.yaml

#create instances of the imported VNF
tacker vnf-create --name testVNF1 --vnfd-name test-vnfd1
tacker vnf-create --name testVNF2 --vnfd-name test-vnfd2

retries=0
key=true
while $key;do
        sleep 3
        vnf_list=`tacker vnf-list`
        active=`echo $vnf_list | grep 'ACTIVE'` || true
        not_active=`echo $vnf_list | grep -E 'PENDING|ERROR'` || true
        echo -e "checking if SFs are up:  $not_active"
        if [ ! -z "$active" ]; then
                echo -e "CREATED"
                retries=0
                key=false
        fi
        if [ "$retries" -eq "200"]; then
                echo -e "Couldn't create VNFs"
                exit 1
        fi
        retries=$((retries+1))
done


#create service chain
tacker sfc-create --name red --chain testVNF1
tacker sfc-create --name blue --chain testVNF2

#create classifier
tacker sfc-classifier-create --name red_http --chain red --match source_port=0,dest_port=80,protocol=6
tacker sfc-classifier-create --name red_ssh --chain red --match source_port=0,dest_port=22,protocol=6

tacker sfc-list
tacker sfc-classifier-list
