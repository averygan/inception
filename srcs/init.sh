# create directories for volumes to be mounted
mkdir -p ~/data/mariadb_data ~/data/wordpress_files
sudo chown -R $USER:staff ~/data/wordpress_files ~/data/mariadb_data
sudo chmod -R 777 ~/data/wordpress_files ~/data/mariadb_data