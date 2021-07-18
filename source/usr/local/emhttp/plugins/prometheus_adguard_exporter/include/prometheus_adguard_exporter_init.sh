#!/bin/bash
((count = 150))
while [[ $count -ne 0 ]] ; do
    ping -c 1 $1
    rc=$?
    if [[ $rc -eq 0 ]] ; then
        ((count = 1))
    fi
    ((count = count - 1))
done

if [[ $rc -eq 0 ]] ; then
    echo "prometheus_adguard_exporter -adguard_hostname $1 -adguard_port $5 -adguard_protocol $4 -adguard_username $2 -adguard_password $3 -server_port $6 -interval $7s" | at now
    echo running
else
    echo stopped
fi