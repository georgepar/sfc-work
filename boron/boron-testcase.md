# Boron Testcase

1. The `server_presetup_CI.bash` throws the following but it completes and the testcase can be run:
   ```
W: GPG error: http://mirror.fuel-infra.org mos9.0-holdback Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY BCE5CC461FA22B08
W: GPG error: http://mirror.fuel-infra.org mos9.0-security Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY BCE5CC461FA22B08
W: GPG error: http://mirror.fuel-infra.org mos9.0-updates Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY BCE5CC461FA22B08   

...  

...  
Populating settings to 10.20.0.6
Warning: Identity file /root/.ssh/id_rsa not accessible: No such file or directory.
ssh: connect to host 10.20.0.6 port 22: No route to host
Populating settings to 10.20.0.3
lost connection
Warning: Identity file /root/.ssh/id_rsa not accessible: No such file or directory.
Permission denied (publickey).
lost connection
...  
   ```
2. The `sfc.py` testcase seems to have some trouble creating the SFs as shown in the log below
   ```
checking if SFs are up:  | 3724f84b-09f4-4890-a962-458f59ce9dba | testVNF1 | firewall1-example |          | PENDING_CREATE |    

| 9b24b5ae-ac52-4900-856e-6f6657ebbe11 | testVNF2 | firewall2-example |          | PENDING_CREATE |    

checking if SFs are up:  | 9b24b5ae-ac52-4900-856e-6f6657ebbe11 | testVNF2 | firewall2-example |          | PENDING_CREATE |   
checking if SFs are up:  
Request Failed: internal server error while processing your request.
Request Failed: internal server error while processing your request.
   ```
3. I try to get the flows using the `dump_flows.sh` script.
   The flows seem to be created only in the compute node as show in the following printscreen
![dump_flows output](https://raw.githubusercontent.com/georgepar/sfc-work/master/boron/flows.png)
4. The `sfc.py` testcase errors out in line 918, so I tried to create a fix. (Still testing)
