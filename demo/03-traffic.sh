#!/usr/bin/env bash

while true; do
    if http --check-status --ignore-stdin --timeout=2.5 HEAD http://primary.sos.agileinfra.io/actuator/health &> /dev/null; then
        http POST http://primary.sos.agileinfra.io/api/events timestamp=`date -u +"%Y-%m-%dT%H:%M:%SZ"` sensorBusinessId='sbid-1' state='off'
        sleep 20
        http POST http://primary.sos.agileinfra.io/api/events timestamp=`date -u +"%Y-%m-%dT%H:%M:%SZ"` sensorBusinessId='sbid-1' state='on'
        sleep 10
        http http://primary.sos.agileinfra.io/api/events
    elif http --check-status --ignore-stdin --timeout=2.5 HEAD http://fallback.sos.agileinfra.io/actuator/health &> /dev/null; then
        http POST http://fallback.sos.agileinfra.io/api/events timestamp=`date -u +"%Y-%m-%dT%H:%M:%SZ"` sensorBusinessId='sbid-1' state='off'
        sleep 20
        http POST http://fallback.sos.agileinfra.io/api/events timestamp=`date -u +"%Y-%m-%dT%H:%M:%SZ"` sensorBusinessId='sbid-1' state='on'
        sleep 10
        http http://fallback.sos.agileinfra.io/api/events
    else
        echo "Neither primary nor fallback datacenter is up"
    fi
done
