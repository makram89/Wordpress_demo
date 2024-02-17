#!/bin/bash

# Check if wp-config.php exists
if [ ! -f /var/www/html/wp-config.php ]; then

    # Initialize wp-config.php with environment variables
    sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/" /var/www/html/wp-config-sample.php
    sed -i "s/username_here/${WORDPRESS_DB_USER}/" /var/www/html/wp-config-sample.php
    sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/" /var/www/html/wp-config-sample.php
    sed -i "s/localhost/${WORDPRESS_DB_HOST}/" /var/www/html/wp-config-sample.php

    # Copy wp-config-sample.php to wp-config.php
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    rm -f /var/www/html/wp-config-sample.php
    rm -f /var/www/html/index.html
fi

exec $@
