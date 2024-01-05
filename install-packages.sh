#!/bin/bash
sudo apt update
sudo apt install fontconfig openjdk-17-jre -y
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
http://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list> /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins


## ADDING DOCKER AND REFRESH JENKINS
# Update the system
sudo apt-get update
# Install Docker dependencies
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
# Add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Add Docker repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# Update the system again
sudo apt-get update
# Install Docker
sudo apt-get install -y docker-ce
# Enable Jenkins service to start on boot
sudo systemctl enable jenkins
# Add the current user to the docker group
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu
# Re-Start Jenkins service
sudo systemctl restart jenkins


## INSTALL MAVEN AND NPM
# Add Maven
sudo apt update
sudo apt install maven -y
# Add Node
sudo apt update
sudo apt install nodejs npm -y
sudo apt update
sudo npm install

## BRINGING BASIC WEBAPP AND ADDING POM, CONFIG, DOCKERFILE AND DOCKER-COMPOSE.YML
sudo git clone -b main https://github.com/spkane/docker-node-hello
cd docker-node-hello
url='http://'
ip=$(curl http://checkip.amazonaws.com)
jar=':8080/jnlpJars/jenkins-cli.jar'
full_url="$url$ip$jar"
sudo curl -LJO "$full_url"
sudo curl -O https://raw.githubusercontent.com/FariusGitHub/CICD/main/Dockerfile
sudo docker image build -t test . # FOR TESTING ONLY, when succeed an image called Test will be created
sudo curl -O https://raw.githubusercontent.com/FariusGitHub/CICD/main/pom.xml
sudo curl -O https://raw.githubusercontent.com/FariusGitHub/CICD/main/config
export passjenkins=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
java -jar jenkins-cli.jar -auth admin:$passjenkins -s http://localhost:8080 create-job project6 < config
cd /var/lib/jenkins/workspace/project6
sudo curl -O https://raw.githubusercontent.com/FariusGitHub/CICD/main/docker-compose.yml
#BELOW LINE WILL INITIALLY FAIL UNTIL USERNAME AND PASSWORD WERE CHANGED INSIDE JENKINS WEB UI
java -jar jenkins-cli.jar -auth admin:$passjenkins -s http://localhost:8080 build project6
