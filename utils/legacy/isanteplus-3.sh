#!/bin/bash
echo " add all the isanteplus concepts"
cd isanteplus_installation
mysql -uroot -pwahbahphoeth openmrs < concepts/isantePlus_concept_20210917.sql


echo "Creating OpenMRS directory in /usr/share/tomcat7/.OpenMRS and setting tomcat7 permissions to all tomcat directories"
echo " add all the isanteplus modules"
service tomcat7 stop
cp modules/*.omod /usr/share/tomcat7/.OpenMRS/modules/

service tomcat7 start

