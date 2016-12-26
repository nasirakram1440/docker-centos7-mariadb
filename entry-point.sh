#!/bin/bash

MYSQL_STARTED=no

function start_db {

        /usr/sbin/service mysql start &> /dev/null
	MYSQL_STARTED=yes

}

function stop_db {

	/usr/sbin/service mysql stop &> /dev/null
	MYSQL_STARTED=no
}

function secure_db {
	
	if [ "$MYSQL_SECURE_DB" = 'yes' ]
	then

		if [ $MYSQL_STARTED = 'no' ]
        	then
                	start_db
        	fi

		# SECURE MYSQL DATABASE
		/usr/bin/mysql -v < /mysql_commands &> /dev/null
	fi

}

function mysql_install {

	if [ ! -f /var/lib/mysql/mysql/mysql_install.txt ]
	then
		/usr/bin/mysql_install_db --datadir=/var/lib/mysql --user=mysql &> /dev/null
		echo "Reinstalled!" > /var/lib/mysql/mysql/mysql_install.txt
	fi
	
}


function set_passwd_db {

	if [ ! "$MYSQL_ROOT_PASSWORD" = 'null' ] && [ ! -f /var/lib/mysql/mysql/root_password_set.txt ]
	then
		if [ $MYSQL_STARTED = 'no' ]
		then
			start_db
		fi
		
		secure_db
		
		# SET ROOT PASSWORD
		/usr/bin/touch /root_passwd
		echo "UPDATE mysql.user set Password=PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE User='root'; FLUSH PRIVILEGES; EXIT" > /root_passwd
		/usr/bin/mysql -v < /root_passwd &> /dev/null
		# REMOVE THE SQL THAT HAS PASSWD
		/usr/bin/rm -rf /root_passwd
		# Indicated root password has been set
		/usr/bin/touch /var/lib/mysql/mysql/root_password_set.txt

		
	fi

}

function startup {

	if [ "$MYSQL_START_DB" = 'yes' ] && [ $MYSQL_STARTED = 'no' ]
	then
		start_db
	fi

	if [ "$MYSQL_START_DB" = 'no' ] && [ $MYSQL_STARTED = 'yes' ]
	then
		stop_db
	fi
	/usr/bin/bash
}

# Function run order is important
mysql_install
secure_db
set_passwd_db
startup
