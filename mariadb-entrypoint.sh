#!/bin/bash

if [ -z 'installation_done.txt' ]
then
        `/usr/bin/mysqld_safe &` && `/usr/bin/bash`
else
        /usr/bin/mysqld_safe &
        /usr/bin/mysql_install_db --datadir=/var/lib/mysql &> /dev/null
        /secure_mysql_installation.sh && /usr/bin/bash
fi
