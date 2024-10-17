#!/bin/bash

# Run npm start in the background
npm start &

# Start supervisord
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf

# Keep the container running by tailing the logs
tail -f /app/logs/app.log
