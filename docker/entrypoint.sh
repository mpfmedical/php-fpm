#!/bin/bash

# wait for mysql
while ! mysqladmin ping -h ${MYSQL_PORT_3306_TCP_ADDR} -P ${MYSQL_PORT_3306_TCP_PORT} --silent; do
	echo "Stalling for MySQL"
    sleep 1
done

# replace ssmtp conf with environment variables
perl -p -e 's/\$\{([^}:]+)(:([^}:]+))?\}/defined $ENV{$1} ? $ENV{$1} : $3/eg' /etc/ssmtp/ssmtp.conf.template > /etc/ssmtp/ssmtp.conf

# exec command
exec "$@"