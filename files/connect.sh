#!/bin/bash

# Load environment variables from .env_connect
source .env_connect

while true; do
    # Get LAN IP
    lan_ip=$(hostname -I | awk '{print $1}')
    #echo "LAN IP: $lan_ip"

    # Resolve the hostname
    hostname=$(hostname)
    resolved_ip=$(dig +short $hostname)
    #echo "Hostname: $hostname"
    #echo "Resolved IP: $resolved_ip"

    # Check connectivity with the router
    router_ip=$(ip route | grep default | awk '{print $3}')
    #echo "Resolve router IP: $router_ip"

    # Set value based on connectivity with the router
    if ping -c 1 $router_ip > /dev/null 2>&1; then
        logger -t connect_info "Connectivity with the router is good."
        # Insert data into InfluxDB
        curl -i -XPOST  'http://admin:ABBpassword@localhost:8086/api/v2/write?org=ABB&bucket=bucket1&precision=s' \
        --header 'Authorization: Token pygVYfiCTMYlLKWR0Hip' \
        --data-raw "status value=1"
    else
        logger -t connect_info "No connectivity with the router."
        # Insert data into InfluxDB with a different value for failure
        curl -i -XPOST 'http://admin:ABBpassword@localhost:8086/api/v2/write?org=ABB&bucket=bucket1&precision=s' \
        --header 'Authorization: Token pygVYfiCTMYlLKWR0Hip' \
        --data-raw "status value=0"
    fi

    sleep 10
done

