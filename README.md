# isanteplus_installation
this repository contain all the process to install isanteplus

isanteplus is set to work on a linux enviroment 
 

# Install github 
apt-get install git-all 

git clone https://github.com/IsantePlus/isanteplus_installation.git

cd isanteplus_installation

# install tomcat 7 and mysql 5.6

sh isanteplus-1.sh 

this command will reboot the system when finish

execute the following command to verify the status of the mysql

sudo /etc/init.d/mysql.server start

sudo /etc/init.d/mysql.server status

sudo update-rc.d -f mysql.server defaults

sudo reboot

# install openmrs war and isante plus modules
sh isanteplus-2.sh 

Navigate to http://localhost:8080/openmrs to continue the installation

