# Use an official Node.js image
FROM node:14
RUN apt-get update && apt-get upgrade -y && apt-get install  supervisor -y
# Set the working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the code
COPY . .

# Create the logs directory
RUN mkdir -p /app/logs
COPY --chown=www-data:www-data /app/log /app/log
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Expose the port
EXPOSE 3000
# filebeat
COPY filebeat.yml  /etc/filebeat/filebeat.yml
COPY entrypoint.sh /docker-entrypoint.d/
RUN chmod +x  /docker-entrypoint.d/entrypoint.sh
RUN chmod go-w /etc/filebeat/filebeat.yml


ENTRYPOINT ["/docker-entrypoint.d/entrypoint.sh"]
# Start the app
#CMD ["npm", "start"]
