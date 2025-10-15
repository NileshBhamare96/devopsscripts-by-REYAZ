#!/bin/bash

# Step 1: Install Java 17 (Amazon Corretto)
sudo yum install java-17-amazon-corretto -y


# Step 2: Download Tomcat 11
cd /home/ec2-user
wget https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.10/bin/apache-tomcat-11.0.10.tar.gz

# Step 3: Extract Tomcat
tar -zxvf apache-tomcat-11.0.10.tar.gz

# Step 4: Configure tomcat-users.xml
cd apache-tomcat-11.0.10/conf

# Remove old closing tag and insert roles/users cleanly
sudo sed -i '/<\/tomcat-users>/d' tomcat-users.xml
sudo tee -a tomcat-users.xml > /dev/null <<EOL
<role rolename="manager-gui"/>
<role rolename="manager-script"/>
<user username="tomcat" password="root123" roles="manager-gui,manager-script"/>
</tomcat-users>
EOL

# Step 5: Remove access restrictions from Manager app
sudo sed -i '/Valve className="org.apache.catalina.valves.RemoteAddrValve"/d' ../webapps/manager/META-INF/context.xml

# Step 6: Start Tomcat
cd /home/ec2-user/apache-tomcat-11.0.10/bin
sh startup.sh
