# Home 08 Systemd

<details>
  <summary>Создаем свой сервис</summary>

Все затолкал в скрипт script.sh по итогу видим результат. Изменен кусок из методички, в оригинале не работало
OnCalendar=*:*:0,30

```
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
```

### результат созданного сервиса

    systemd: Jul 26 18:11:32 localhost nm-dispatcher: req:15 'connectivity-change': start running ordered scripts...
    systemd: Jul 26 18:11:32 localhost nm-dispatcher: req:16 'up' [eth0]: start running ordered scripts...
    systemd: Jul 26 18:11:32 localhost nm-dispatcher: req:17 'connectivity-change': start running ordered scripts...
    systemd: Jul 26 18:11:36 localhost systemd-logind: New session 3 of user vagrant.
    systemd: Jul 26 18:11:36 localhost systemd: Started Session 3 of user vagrant.
    systemd: Jul 26 18:11:36 localhost systemd-logind: Removed session 3.
    systemd: Jul 26 18:11:50 localhost systemd: Started Run watchlog script every 30 second.
    systemd: Jul 26 18:12:02 localhost systemd: Starting My watchlog service...
    systemd: Jul 26 18:12:02 localhost root: Wed Jul 26 18:12:02 UTC 2023: I found word, Master
    systemd: Jul 26 18:12:02 localhost systemd: Started My watchlog service.

</details>

<details>
  <summary>spawn-fcgi</summary>

в том же скрипте, но конфиги скопированы заранее внутрь тачки вагранта
### Результат 

```
    systemd: ● spawn-fcgi.service - Spawn-fcgi startup service by Otus
    systemd:    Loaded: loaded (/etc/systemd/system/spawn-fcgi.service; disabled; vendor preset: disabled)
    systemd:    Active: active (running) since Wed 2023-07-26 18:14:18 UTC; 15ms ago
    systemd:  Main PID: 4651 (spawn-fcgi)
    systemd:    CGroup: /system.slice/spawn-fcgi.service
    systemd:            └─4651 /usr/bin/spawn-fcgi -n -u apache -g apache -s $SOCKET -S -M 0600 -C 32 -F 1 -P /var/run/spawn-fcgi.pid -- /usr/bin/php-cgi
    systemd: 
    systemd: Jul 26 18:14:18 systemd systemd[1]: Started Spawn-fcgi startup service by Otus.
```
</details>


<details>
  <summary>мульти запуск httpd</summary>

аналогино, все в скрипте с копированием конфигов

### Результат 

```
systemd: tcp    LISTEN     0      128    [::]:8080               [::]:*                   users:(("httpd",pid=4703,fd=4),("httpd",pid=4702,fd=4),("httpd",pid=4701,fd=4),("httpd",pid=4700,fd=4),("httpd",pid=4699,fd=4),("httpd",pid=4698,fd=4))
    systemd: tcp    LISTEN     0      128    [::]:80                 [::]:*                   users:(("httpd",pid=4696,fd=4),("httpd",pid=4695,fd=4),("httpd",pid=4694,fd=4),("httpd",pid=4693,fd=4),("httpd",pid=4692,fd=4),("httpd",pid=4659,fd=4))
```

</details>
