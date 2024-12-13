FROM debian:bullseye

# client too because the client of the serv is ass
RUN apt update && apt install -y mariadb-client mariadb-server zsh

#default name for the server "50-server.cnf"
COPY server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY init.sql /etc/mysql/

RUN mkdir /run/mysqld

#default port
EXPOSE 3306

CMD ["mysqld"]
