#!/bin/bash

while true; do
    output=$(kubectl top pod -n default --no-headers | grep happy-web-app-deployment-6558f48bdf-lbj9 | awk '{print $2}')

    echo "CPU Usage: $output"

    sleep 15
done