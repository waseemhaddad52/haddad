FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get install vim nginx supervisor php8.1-fpm php-mysql -y

# Install MySQL client (for executing commands during build)
RUN apt-get install mysql-client -y

# Set up a non-root user for MySQL (you can customize the username and password)
ENV MYSQL_USER example_user
ENV MYSQL_PASSWORD password
ENV MYSQL_DATABASE example_database

# Install MySQL server from official image
RUN apt-get install mysql-server -y

# Start MySQL server
RUN service mysql start && mysql -u root -e "CREATE DATABASE $MYSQL_DATABASE;" \
    && mysql -u root -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" \
    && mysql -u root -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';" \
    && mysql -u root -e "CREATE TABLE example_database.todo_list (item_id INT AUTO_INCREMENT, content VARCHAR(255), PRIMARY KEY(item_id) );" \
    && mysql -u root -e "insert into example_database.todo_list (content) values ('go to be amazing');"

RUN service mysql stop

WORKDIR /var/www/html

COPY nginx.conf /etc/nginx/sites-enabled/default
COPY . .
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
