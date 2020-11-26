
sudo sh
echo "Installing curl"
apt-get install -y curl

#Download the .war file
echo "Downloading the OpenMRS Platform v2.0.4.1 .war file"
curl -O -L -J "https://sourceforge.net/projects/openmrs/files/releases/OpenMRS_Platform_2.0.5/openmrs.war/download"
cp openmrs.war /var/lib/tomcat7/webapps/openmrs.war

#Install unzip to unzip the modules
#echo "Installing unzip"
#sudo apt-get install -y unzip

# Install github 
echo "Starting installation of github"
apt-get install git-all

#Download the OpenMRS 2.5 modules
#echo "Downloading the isanteplus modules"
git clone https://github.com/IsantePlus/isantePlus-module.git
cd isantePlus-module

#Make a .OpenMRS home directory in /usr/share/tomcat7/ and copy modules to that folder
echo "Creating OpenMRS directory in /usr/share/tomcat7/.OpenMRS and setting tomcat7 permissions to all tomcat directories"
mkdir /usr/share/tomcat7/.OpenMRS
mkdir /usr/share/tomcat7/.OpenMRS/modules
mv *.omod /usr/share/tomcat7/.OpenMRS/modules/
chown -R tomcat7:tomcat7 /usr/share/tomcat7
chown -R tomcat7:tomcat7 /var/lib/tomcat7

mysql -uroot -pwahbahphoeth openmrs < concepts/isantePlus_concept.sql

#Start tomcat and navigate to http://localhost:8080/openmrs to complete setup
echo "Starting Tomcat"
service tomcat7 start
echo "Navigate to http://localhost:8080/openmrs to continue the OpenMRS setup process"