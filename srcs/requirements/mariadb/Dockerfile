FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install -y mariadb-server

COPY tools/init_mariadb.sh .
RUN chmod +x ./init_mariadb.sh

EXPOSE 3306 

ENTRYPOINT ["./init_mariadb.sh"]