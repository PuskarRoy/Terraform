#!/bin/bash
systemctl stop ecs

cat > /etc/ecs/ecs.config << 'EOF'
ECS_CLUSTER=testcluster
EOF

systemctl enable ecs
systemctl start ecs