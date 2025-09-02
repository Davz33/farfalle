#!/bin/bash

# Create a dynamic Docker Compose file with environment variable port mapping
# This script creates a temporary compose file that can be used for dynamic ports

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
BASE_COMPOSE="$PROJECT_DIR/docker-compose.dev.yaml"
DYNAMIC_COMPOSE="$PROJECT_DIR/docker-compose.dynamic.yaml"

log_info() {
    echo "[INFO] $1"
}

create_dynamic_compose() {
    local backend_port=$1
    
    log_info "Creating dynamic Docker Compose file with port $backend_port..."
    
    # Create a copy of the base compose file with port substitution
    sed "s/\"8000:8000\"/\"${backend_port}:8000\"/g" "$BASE_COMPOSE" > "$DYNAMIC_COMPOSE"
    
    log_info "Created $DYNAMIC_COMPOSE with port $backend_port"
}

# Main execution
main() {
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <port>"
        exit 1
    fi
    
    local port=$1
    create_dynamic_compose $port
    
    log_info "Dynamic compose file created successfully!"
    log_info "Use: docker compose -f $DYNAMIC_COMPOSE up"
}

# Run main function
main "$@"
