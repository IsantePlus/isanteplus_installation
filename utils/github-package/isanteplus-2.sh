
sudo sh
echo "Installing curl"
apt-get install -y curl


echo "Downloading the OpenMRS Platform v2.0.4.1 .war file"
curl -O -L -J "https://sourceforge.net/projects/openmrs/files/releases/OpenMRS_Platform_2.0.5/openmrs.war/download"
cp openmrs.war /var/lib/tomcat7/webapps/openmrs.war
 
echo "Starting installation of github"
apt-get install git-all

git clone https://github.com/IsantePlus/isantePlus-module.git
cd isantePlus-module

echo "Adding iSantePlus github repository to Maven settings.xml"
sed -e "s/\${your-github-username}/$GITHUB_USERNAME/" -e "s/\${your-github-token}/$GITHUB_TOKEN/" ./utils/github-package/settings.xml.template | tee ~/.m2/settings.xml

echo "Creating OpenMRS directory in /usr/share/tomcat7/.OpenMRS and setting tomcat7 permissions to all tomcat directories"
mkdir /usr/share/tomcat7/.OpenMRS
mkdir /usr/share/tomcat7/.OpenMRS/modules

echo "Downloading iSantePlus distro (.war file and modules) from iSantePlus Maven Repo"
mvn dependency:get -Dartifact=org.openmrs.distro:isanteplus:$ISANTEPLUS_VERSION:zip
mvn dependency:get -Dartifact=org.openmrs.distro:isanteplus:$ISANTEPLUS_VERSION:war
mvn dependency:copy -Dartifact=org.openmrs.distro:isanteplus:$ISANTEPLUS_VERSION:zip -DoutputDirectory=/openmrs/downloaded
mvn dependency:copy -Dartifact=org.openmrs.distro:isanteplus:$ISANTEPLUS_VERSION:war -DoutputDirectory=/openmrs/distribution/openmrs_webapps


mv *.omod /usr/share/tomcat7/.OpenMRS/modules/

chown -R tomcat7:tomcat7 /usr/share/tomcat7
chown -R tomcat7:tomcat7 /var/lib/tomcat7

mysql -uroot -pwahbahphoeth openmrs < concepts/isantePlus_concept.sql

echo "Starting Tomcat"
service tomcat7 start
echo "Navigate to http://localhost:8080/openmrs to continue the OpenMRS setup process"