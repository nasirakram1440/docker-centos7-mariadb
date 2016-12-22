#!/bin/bash

if [ -z mysql_commands ]
then
	echo "The file does not exist"
else
	/usr/bin/mysql -v < /mysql_commands &> /dev/mull
	echo "MYSQL Installation Secured!" > /installation_done.txt
fi
