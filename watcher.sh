#!/bin/bash
set -e

# maximum allowed restarts before down scale event
maxRestartCount=5 
# wait time between two checks
waitTime=60
# Kubernetes namespace
namespace=sre
# Swype deployment name
deployment=swype-app
# Kubernetes application label
appLabel=$(kubectl get deployments $deployment -n $namespace -o=jsonpath={'.spec.template.metadata.labels.app'})

if [ -z "$appLabel" ]; then   
    echo -e "An issue occurred while accessing the deployment information. \nCheck your configuration.\nEXITING."
    exit 130
else   
    # Find entities with identified 'app' label
    labelQuery="?(@.metadata.labels.app==\"$appLabel\")"

    while :
    do
        # get restart count for the selected POD
        restartCount=$(kubectl -n $namespace get pods -o=jsonpath={.items[$labelQuery].status.containerStatuses[0].restartCount})
        
        if [ -z "$restartCount" ]; then echo -e "Can't find a running POD!\nEXITING."; exit 130; fi
        echo "Restart count for app=$appLabel: $restartCount"

        # If too many restarts happened, deployment will be scaled to zero
        if (( $restartCount >= $maxRestartCount )); then
            echo -e "Error: Too many restarts.\nScaling deployment down."
            kubectl scale deployment -n $namespace $deployment --replicas=0
            exit 1
        else
            # Wait till the next check
            sleep $waitTime
        fi
    done
fi