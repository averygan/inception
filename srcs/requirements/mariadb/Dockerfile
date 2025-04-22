FROM debian:bullseye

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y mariadb-server && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN chown -R mysql:mysql /var/lib/mysql/

COPY tools/init_mariadb.sh /usr/local/bin/init_mariadb.sh
RUN mkdir /run/mysqld && RUN chmod +x /usr/local/bin/init_mariadb.sh

EXPOSE 3306 

ENTRYPOINT ["/usr/local/bin/init_mariadb.sh"]
