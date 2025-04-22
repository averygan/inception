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

    wp core install --url="www.test.com" --title="inception test" --admin_user="$WORDPRESS_ADMIN_USER" --admin_password="$WORDPRESS_ADMIN_PASSWORD" --admin_email="$WORDPRESS_ADMIN_EMAIL" --path="/var/www/html" --allow-root

    wp user create "$WORDPRESS_USER1" "$WORDPRESS_USER1_EMAIL" --role=editor --user_pass="$WORDPRESS_USER1_PASSWORD" --path="/var/www/html" --allow-root
fi

exec "$@"