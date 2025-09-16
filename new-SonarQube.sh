#!/bin/bash
set -e   # exit if any command fails

# Go to /opt
cd /opt/

# Download SonarQube
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.6.50800.zip
unzip sonarqube-8.9.6.50800.zip

# Install Java 17 (Amazon Corretto)
sudo rpm --import https://yum.corretto.aws/corretto.key
sudo curl -Lo /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
sudo yum install -y java-17-amazon-corretto

# Create sonar user (no login shell, no password)
id -u sonar &>/dev/null || sudo useradd --system --create-home --shell /bin/bash sonar

# Change ownership of SonarQube directory
sudo chown -R sonar:sonar /opt/sonarqube-8.9.6.50800

# Optional: restrict permissions for security (avoid 777)
sudo chmod -R 755 /opt/sonarqube-8.9.6.50800

echo "Installation done. Switch to sonar user and start SonarQube:"
echo "su - sonar"
echo "/opt/sonarqube-8.9.6.50800/bin/linux-x86-64/sonar.sh start"
