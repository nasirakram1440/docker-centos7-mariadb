# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# MARIADB 10.0 on Centos7                                +
# @ Author Muhammad Nasir Akram                          +
# Dated 25/12/2016                                       +
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

FROM centos:latest
MAINTAINER mnakram1440@gmail.com

# Create the environment variables
ENV MYSQL_ROOT_PASSWORD null
ENV MYSQL_SECURE_DB no
ENV MYSQL_START_DB no

# Update the system
RUN yum update -y

# Copy the mariadb yum repository
COPY MariaDB.repo /etc/yum.repos.d/MariaDB.repo

# Copy entrypoint file
COPY entry-point.sh /entry-point.sh

# Install mariadb and initscripts
RUN yum install -y mariadb-server mariadb-client initscripts

# Indicate mysql_install_db was run
RUN /usr/bin/touch /var/lib/mysql/mysql/mysql_install.txt

# Copy the mysql_commands file
COPY mysql_commands /mysql_commands

EXPOSE 3306

ENTRYPOINT ["/entry-point.sh"]
