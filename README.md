# isanteplus_installation
this repository contain all the process to install isanteplus

isanteplus is set to work on a linux enviroment 
 

#1- Install github 
echo "Starting installation of github"
apt-get install git-all 

# 1-1 you will need to clone this repository
git clone https://github.com/IsantePlus/isanteplus_installation.git
cd isanteplus_installation

#2 install tomcat 7 and mysql 5.6
sh isanteplus-1.sh 

# this command will reboot the system when finish

#3 execute the following command to verify the status of the mysql
sudo /etc/init.d/mysql.server start
sudo /etc/init.d/mysql.server status
sudo update-rc.d -f mysql.server defaults
#4 reboot the system 
sudo reboot
#5 install openmrs war and isante plus modules
sh isanteplus-2.sh 

#6 Navigate to http://localhost:8080/openmrs to continue the installation

