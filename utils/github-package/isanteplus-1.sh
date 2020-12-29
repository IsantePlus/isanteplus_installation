#!/bin/bash
sudo sh
sudo apt-get update

echo "Installing OpenJDK8"
sudo apt-get install -y openjdk-8-jdk

echo "Installing Maven"
sudo apt-get install -y maven

echo "deb http://security.ubuntu.com/ubuntu xenial-security main universe" >> /etc/apt/sources.list

sudo apt-get update
echo "Installing Tomcat7, stopping the service and setting the catalina environment variable to max 1GB RAM"
sudo apt-get install -y tomcat7
sudo service tomcat7 stop
echo 'JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"' | sudo tee --append /etc/default/tomcat7
echo 'CATALINA_OPTS="-Xms512m -Xmx1024m"' | sudo tee --append /usr/share/tomcat7/bin/setenv.sh

echo "Installing MySQL Server. You will be prompted for a password."

sudo rm /var/lib/mysql/ -R
sudo rm /etc/mysql/ -R
sudo apt-get autoremove mysql* --purge
sudo apt-get remove apparmor
wget https://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.48-linux-glibc2.12-x86_64.tar.gz

sudo groupadd mysql
sudo useradd -g mysql mysql
sudo tar -xvf mysql-5.6.48-linux-glibc2.12-x86_64.tar.gz 
sudo mv mysql-5.6.48-linux-glibc2.12-x86_64 /usr/local/

cd /usr/local
sudo mv mysql-5.6.48-linux-glibc2.12-x86_64 mysql

cd mysql
sudo chown -R mysql:mysql *

sudo apt-get install libaio1
sudo scripts/mysql_install_db --user=mysql

sudo chown -R root .
sudo chown -R mysql data

sudo cp support-files/my-default.cnf /etc/my.cnf 

sudo bin/mysqld_safe --user=mysql &
sudo cp support-files/mysql.server /etc/init.d/mysql.server

sudo bin/mysqladmin -u root password $MYSQL_ROOT_PASSWORD

sudo ln -s /usr/local/mysql/bin/mysql /usr/local/bin/mysql
sudo ln -s /usr/local/mysql/bin/mysqldump /usr/local/bin/mysqldump

sudo add-apt-repository universe
sudo apt-get install libncurses5

sudo reboot