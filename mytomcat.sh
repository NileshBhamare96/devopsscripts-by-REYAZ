#!/bin/bash

# Step 1: Install Java
sudo amazon-linux-extras install java-openjdk11 -y

# Step 2: Download Tomcat
cd /home/ec2-user
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.109/bin/apache-tomcat-9.0.109.tar.gz

# Step 3: Extract
tar -zxvf apache-tomcat-9.0.109.tar.gz

# Step 4: Configure tomcat-users.xml
cd apache-tomcat-9.0.109/conf
sudo sed -i '/<\/tomcat-users>/i\<role rolename="manager-gui"/>\n<role rolename="manager-script"/>\n<user username="tomcat" password="root123" roles="manager-gui,manager-script"/>' tomcat-users.xml

# Step 5: Remove access restrictions from manager context.xml
cd ../webapps/manager/META-INF
sudo sed -i '21,22d' context.xml

# Step 6: Start Tomcat
cd /home/ec2-user/apache-tomcat-9.0.109/bin
sh startup.sh
