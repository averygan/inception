FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install -y mariadb-server

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

RUN chown -R mysql:mysql /var/lib/mysql && chmod -R 755 /var/lib/mysql

COPY tools/init_mariadb.sh .
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x ./init_mariadb.sh 

EXPOSE 3306 

ENTRYPOINT ["./init_mariadb.sh"]