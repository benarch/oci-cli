#!/bin/bash

## Author: Ben Dali -- https://bdali.com
##### this script do the flllowing:
## 1. list instance on a compartment and send it to file
## 2. turn on the instances listed with a specific "display-name".
## 3. send the outputs to a file.

# for profile based oci cli:        $ oci --profile [profile-name] compute instance list --compartment-id
# gor default profile oci cli:      $ oci compute instance list --compartment-id [compartment-ocid]
# for starting an instance:          $ oci compute instance action --instance-id  [instance-OCID] --action START

# displaying message to connected users
echo $(wall "Starting Servers on Oracle Cloud - please go to the server list to check which servers are affected")

oci compute instance list --compartment-id [Your-compartment-OCID] --output table --query "data [*].{server:\"display-name\", OCID:id}" | grep ben  |sed 's/|/ /g'> /tmp/servers
while read server
do
serverid=$(echo $server | awk '{print $1}')
servername=$(echo $name | awk '{print $2}')
echo $name
echo $serverid
oci compute instance action --instance-id $serverid --action START
done< /tmp/servers
