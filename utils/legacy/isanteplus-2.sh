#!/bin/bash
sudo sh
echo "Installing curl"
apt-get install -y curl

cd isanteplus_installation
echo "Downloading the OpenMRS Platform v2.0.4.1 .war file"
curl -O -L -J "https://sourceforge.net/projects/openmrs/files/releases/OpenMRS_Platform_2.0.5/openmrs.war/download"
cp openmrs.war /var/lib/tomcat7/webapps/openmrs.war
 
mkdir /usr/share/tomcat7/.OpenMRS
mkdir /usr/share/tomcat7/.OpenMRS/modules

cd /usr/share/tomcat7/
chown -R tomcat7:tomcat7 /usr/share/tomcat7
chown -R tomcat7:tomcat7 /var/lib/tomcat7


echo "Starting Tomcat"
service tomcat7 start
echo "Navigate to http://localhost:8080/openmrs to continue the OpenMRS setup process and continue with the script after the installation"

