#!/bin/bash
apt-get update

echo "Installing OpenJDK8"
apt-get install -y openjdk-8-jdk

echo "deb http://security.ubuntu.com/ubuntu xenial-security main universe" >> /etc/apt/sources.list

apt-get update
echo "Installing Tomcat7, stopping the service and setting the catalina environment variable to max 1GB RAM"
apt-get install -y tomcat7
service tomcat7 stop
echo 'JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"' | sudo tee --append /etc/default/tomcat7
echo 'CATALINA_OPTS="-Xms512m -Xmx1024m"' | sudo tee --append /usr/share/tomcat7/bin/setenv.sh

echo "Installing MySQL Server. You will be prompted for a password."

rm /var/lib/mysql/ -R
rm /etc/mysql/ -R
apt-get autoremove mysql* --purge
apt-get remove apparmor
wget https://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.48-linux-glibc2.12-x86_64.tar.gz

groupadd mysql
useradd -g mysql mysql
tar -xvf mysql-5.6.48-linux-glibc2.12-x86_64.tar.gz 
mv mysql-5.6.48-linux-glibc2.12-x86_64 /usr/local/

cd /usr/local
mv mysql-5.6.48-linux-glibc2.12-x86_64 mysql

cd mysql
chown -R mysql:mysql *

apt-get install libaio1
scripts/mysql_install_db --user=mysql

chown -R root .
chown -R mysql data

cp support-files/my-default.cnf /etc/my.cnf 

bin/mysqld_safe --user=mysql &
cp support-files/mysql.server /etc/init.d/mysql.server

bin/mysqladmin -u root password 'wahbahphoeth'

ln -s /usr/local/mysql/bin/mysql /usr/local/bin/mysql
ln -s /usr/local/mysql/bin/mysqldump /usr/local/bin/mysqldump

add-apt-repository universe
apt-get install libncurses5

reboot