FROM mysql:8.0

COPY ./mysql1.sql /tmp

CMD [ "mysqld", "--init-file=/tmp/mysql1.sql" ]
