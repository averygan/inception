if [ -f /var/www/html/wp-config.php ]
then
    echo "wordpress already configured"
else
    # Import env variables in the config file
    cd /var/www/html

    sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
    sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
    sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
    sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
    mv wp-config-sample.php wp-config.php

    echo "wp-config.php created successfully."

    MAX_RETRIES=10
    RETRY_COUNT=0

    until mysql -h"$MYSQL_HOSTNAME" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1;" "$MYSQL_DATABASE" > /dev/null 2>&1
    do
        RETRY_COUNT=$((RETRY_COUNT+1))
        if [ "$RETRY_COUNT" -ge "$MAX_RETRIES" ]; then
            echo "Database is still not available after $MAX_RETRIES attempts, exiting."
            exit 1
        fi
        echo "Waiting for database... ($RETRY_COUNT/$MAX_RETRIES)"
        sleep 3
    done

    wp core install --url="avery.com" --title="inception test" --admin_user="$WORDPRESS_ADMIN_USER" --admin_password="$WORDPRESS_ADMIN_PASSWORD" --admin_email="$WORDPRESS_ADMIN_EMAIL" --path="/var/www/html" --allow-root --skip-email

    wp user create "$WORDPRESS_USER1" "$WORDPRESS_USER1_EMAIL" --role=editor --user_pass="$WORDPRESS_USER1_PASSWORD" --path="/var/www/html" --allow-root
fi

exec "$@"