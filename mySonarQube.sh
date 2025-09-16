#!/bin/bash
set -e   # exit if any command fails

# Go to /opt
cd /opt/

# Download SonarQube
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.6.50800.zip
unzip sonarqube-8.9.6.50800.zip

# rename
mv sonarqube-8.9.6.50800 sonarqube 

# Install Java 17 (Amazon Corretto)
sudo rpm --import https://yum.corretto.aws/corretto.key
sudo curl -Lo /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
sudo yum install -y java-17-amazon-corretto

# Create sonar user
useradd sonar || true   # skip if already exists

# Change ownership of SonarQube directory
sudo chown -R sonar:sonar /opt/sonarqube

# Optional: restrict permissions for security (avoid 777)
sudo chmod -R 755 /opt/sonarqube

# use the below command manually after installation
#sh /opt/sonarqube-8.9.6.50800/bin/linux-x86-64/sonar.sh start
#<browser -Ip : Port nUmber :9000
#echo "user=admin & password=admin"
