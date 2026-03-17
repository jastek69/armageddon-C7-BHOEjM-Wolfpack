#!/bin/bash
set -euxo pipefail

cat >/etc/systemd/system/rdsapp.service <<'EOF'
[Unit]
Description=EC2 to RDS Notes App
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/rdsapp
Environment=SECRET_ID=lab1c/secret12
Environment=AWS_REGION=us-east-2
ExecStart=/usr/bin/python3 /opt/rdsapp/app.py
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable rdsapp
systemctl restart rdsapp