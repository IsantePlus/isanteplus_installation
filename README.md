# iSantePlus Installation

## Setup

**Install Git**

```sh
apt-get install git-all
git clone https://github.com/IsantePlus/isanteplus_installation.git
cd isanteplus_installation

sudo chmod 777 utils/legacy/isanteplus-1.sh
sudo chmod 777 utils/legacy/isanteplus-2.sh
sudo chmod 777 utils/legacy/isanteplus-3.sh

```

## Option 1: Legacy Approach
this repository contain all the process to install isanteplus

isanteplus is set to work on a linux enviroment 
 
### Step 1: Install tomcat 7 and mysql 5.6

```
sh utils/legacy/isanteplus-1.sh
```

This command will reboot the system when finished

Execute the following command to verify the status of the mysql

```sh
sudo /etc/init.d/mysql.server start
sudo /etc/init.d/mysql.server status
sudo update-rc.d -f mysql.server defaults
sudo reboot
```

### Step 2: Install openmrs war 
`sh utils/legacy/isanteplus-2.sh`

Navigate to http://localhost:8080/openmrs to continue the installation


### Step 3: Install openmrs concept and isanteplus modules
`sh utils/legacy/isanteplus-3.sh`

## Option 2: Github Repo Distro Approach

1. Create a new [Github Personal Access Token](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token) if you do not have one already.

2. Run the first setup script, which will cause a **reboot**.
   ```sh
   export MYSQL_ROOT_PASSWORD=<your-desired-root-password>
   sh ./utils/github-package/isanteplus-1.sh
   ```

3. Verify `mysql` installation.
    ```
    sudo /etc/init.d/mysql.server start
    sudo /etc/init.d/mysql.server status
    sudo update-rc.d -f mysql.server defaults
    sudo reboot
    ```

4. Set a couple necessary temporary env variables to hold the Personal Access Token from step 1 and the desired iSantePlus distro version. You can see the available versions [here](https://github.com/IsantePlus/isanteplus-packages/packages/541438/versions).
    ```sh
    export GITHUB_USERNAME=<your-github-username>
    export GITHUB_TOKEN=<your-token-from-step-1>
    export ISANTEPLUS_VERSION=2.6.0
    ```

5. Run the second setup script.
   ```
   sh ./utils/github-package/isanteplus-2.sh
   ```

6. Navigate to http://localhost:8080/openmrs to continue the installation.