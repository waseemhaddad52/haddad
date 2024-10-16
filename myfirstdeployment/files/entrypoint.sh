#!/bin/bash

#chown -R www-data:www-data /app/logs
npm start
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf

tail -f /app/logs/app.log
