#!/bin/bash

# Switch to home directory
cd /home/ec2-user

# Step 0: Clean previous Tomcat (if exists)
rm -rf apache-tomcat-9.* *.tar.gz

# Step 1: Install Java 17 (Corretto)
yum install java-17-amazon-corretto -y

# Step 2: Download latest Tomcat 9 release
TOMCAT_VERSION="9.0.111"
wget https://dlcdn.apache.org/tomcat/tomcat-9/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz

# Step 3: Extract
tar -zxvf apache-tomcat-$TOMCAT_VERSION.tar.gz

# Step 4: Configure tomcat-users.xml safely
cd apache-tomcat-$TOMCAT_VERSION/conf
sed -i '/<\/tomcat-users>/d' tomcat-users.xml
tee -a tomcat-users.xml > /dev/null <<EOL
<role rolename="manager-gui"/>
<role rolename="manager-script"/>
<user username="tomcat" password="root123" roles="manager-gui,manager-script"/>
</tomcat-users>
EOL

# Step 5: Remove IP restrictions from Manager app
cd ../webapps/manager/META-INF
sed -i '/RemoteAddrValve/d' context.xml

# Step 6: Start Tomcat
cd /home/ec2-user/apache-tomcat-$TOMCAT_VERSION/bin
sh startup.sh

