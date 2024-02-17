#!/bin/bash

# exec service mysql start
mysqld_safe &
MYSQL_PID=$!

# Initilalization flag
INITIALIZED_FLAG="/var/lib/mysql/initialized.flag"

# Wait for MySQL to be ready
until mysql -u root --password="${MYSQL_ROOT_PASSWORD}" -e "SELECT 1"; do
   echo "Waiting for MySQL to be up..."
   sleep 1
done

# Check for flag
if [ ! -f "$INITIALIZED_FLAG" ]; then

    # Configures MySQL
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}';"

    # Create a MySQL database and user for WordPress
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

    sed -i 's/localhost/0.0.0.0/g' /etc/mysql/debian.cnf 
    sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf
     

    touch "$INITIALIZED_FLAG"
fi

wait $MYSQL_PID


# exec $@