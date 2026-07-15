#!/bin/bash

cat > /etc/ecs/ecs.config << 'EOF'
ECS_CLUSTER=testcluster
EOF
systemctl restart ecs