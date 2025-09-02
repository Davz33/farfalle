#!/bin/bash

# Find an available port starting from 8000
# Usage: ./find-available-port.sh [start_port]

START_PORT=${1:-8000}
MAX_ATTEMPTS=100

find_available_port() {
    local port=$START_PORT
    local attempts=0
    
    while [ $attempts -lt $MAX_ATTEMPTS ]; do
        if ! lsof -i :$port > /dev/null 2>&1; then
            echo $port
            return 0
        fi
        port=$((port + 1))
        attempts=$((attempts + 1))
    done
    
    echo "No available ports found after $MAX_ATTEMPTS attempts" >&2
    return 1
}

find_available_port
