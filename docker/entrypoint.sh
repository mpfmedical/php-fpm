#!/bin/bash

# replace ssmtp conf with environment variables
perl -p -e 's/\$\{([^}:]+)(:([^}:]+))?\}/defined $ENV{$1} ? $ENV{$1} : $3/eg' /etc/ssmtp/ssmtp.conf.template > /etc/ssmtp/ssmtp.conf

# exec command
exec "$@"
