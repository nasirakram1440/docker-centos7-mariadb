# ++++++++++++++++++++++++++++++++++++++++++++++++
# MariaDB Dockerfile				 +
# @author: Muhammad Nasir Akram			 +
# Dated: 21/12/2016				 +
# ++++++++++++++++++++++++++++++++++++++++++++++++

FROM centos:latest
MAINTAINER mnakram1440@gmail.com

# Update the system
RUN yum update -y

# Copy the files from local directory to the container
COPY MariaDB.repo /etc/yum.repos.d/MariaDB.repo

# Clean yum repo
RUN yum clean all && yum repolist

# Install MariaDB server
RUN yum install -y MariaDB-server MariaDB-client

# Copy the script to secure the mysql installation
COPY ./secure_mysql_installation.sh /secure_mysql_installation.sh

# Copy the mysql commands file. This file contains commands that will secure our server
COPY ./mysql_commands /mysql_commands

# Copy the startup script
COPY ./mariadb-entrypoint.sh /mariadb-entrypoint.sh

EXPOSE 3306

VOLUME /var/lib/mysql

#ENTRYPOINT ["/mariadb-entrypoint.sh"]
