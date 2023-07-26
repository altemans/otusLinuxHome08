cat >> /etc/sysconfig/watchlog << EOF
# Configuration file for my watchlog service
# Place it to /etc/sysconfig

# File and word in that file that we will be monit
WORD="ALERT"
LOG=/var/log/watchlog.log
EOF

cat >> /var/log/watchlog.log << EOF
ALERT test
tetete
tetetet
te ALERT
ALERT test2
EOF

cat >> /opt/watchlog.sh << EOF
#!/bin/bash

WORD=\$1
LOG=\$2
DATE=\`date\`

if grep \$WORD \$LOG &> /dev/null
then
    logger "\$DATE: I found word, Master"
else
    exit 0
fi
EOF

chmod +x /opt/watchlog.sh

cat >> /etc/systemd/system/watchlog.service << EOF
[Unit]
Description=My watchlog service

[Service]
Type=oneshot
EnvironmentFile=/etc/sysconfig/watchlog
ExecStart=/opt/watchlog.sh \$WORD \$LOG
EOF

cat >> /etc/systemd/system/watchlog.timer << EOF
[Unit]
Description=Run watchlog script every 30 second

[Timer]
# Run every 30 second
OnCalendar=*:*:0,30
Unit=watchlog.service

[Install]
WantedBy=multi-user.target
EOF

chmod 664 /etc/systemd/system/watchlog.service
chmod 664 /etc/systemd/system/watchlog.timer

systemctl start watchlog.timer

sleep 30
tail -n 10 /var/log/messages

yum install epel-release -y && yum install spawn-fcgi php php-climod_fcgid httpd -y

cp -f /tmp/spawn-fcgi /etc/sysconfig/spawn-fcgi
cp -f /tmp/spawn-fcgi.service /etc/systemd/system/spawn-fcgi.service

systemctl start spawn-fcgi
systemctl status spawn-fcgi


cp -f /tmp/httpd.service /usr/lib/systemd/system/httpd@.service
cp -f /tmp/httpd-first /etc/sysconfig/httpd-first
cp -f /tmp/httpd-second /etc/sysconfig/httpd-second
cp -f /tmp/first.conf /etc/httpd/conf/first.conf
cp -f /tmp/second.conf /etc/httpd/conf/second.conf

systemctl start httpd@first
systemctl start httpd@second
ss -tnulp | grep httpd