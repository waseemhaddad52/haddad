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
#COPY --chown=www-data:www-data ./app/logs /app/logs
# filebeat
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-8.x.list
RUN apt update -y && apt install -y filebeat=8.15.2COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
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
