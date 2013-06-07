#!/bin/sh
#
# =================================================
# Name:			intsll-tomcat.sh
# Author:			Gabe Villa <extofer@gmail.com>
# =================================================

JAVA_HOME=/usr/java/jre1.7.0_21
export JAVA_HOME
PATH=$JAVA_HOME/bin:$PATH
export PATH 


echo "begin tomcat installation"
# downloads packages
wget http://www.us.apache.org/dist/tomcat/tomcat-7/v7.0.40/bin/apache-tomcat-7.0.40.tar.gz

#moves to /usr/share/  /var/lib/
mv apache-tomcat-7.0.40.tar.gz  /usr/share/

# these files are needed to configure
#mv dependencies/ /usr/share/

cd /usr/share/
tar -xzf /usr/share/apache-tomcat-7.0.40.tar.gz
mv /usr/share/apache-tomcat-7.0.40/ tomcat7/
#mv dependencies/ /usr/share/tomcat7/

# stop here and create the soft links
cd /usr/share/tomcat7/

rm LICENSE  NOTICE RELEASE-NOTES RUNNING.txt

echo "creating /etc/tomcat7/ softlinks"
#softlinks conf
mkdir /etc/tomcat7/
mv conf/* /etc/tomcat7/
rm -rf conf/
ln -s /etc/tomcat7/
mv tomcat7 conf
chgrp tomcat /etc/tomcat7/
chgrp -h tomcat conf

#softlinks lib
echo "creating java lib softlinks"
mkdir /usr/share/java/tomcat7/
mv lib/* /usr/share/java/tomcat7/
rm -rf lib/
ln -s /usr/share/java/tomcat7/
mv tomcat7 lib

# softlinks logs
echo "creating /var/log/tomcat7/ softlinks"
mkdir /var/log/tomcat7/
# mv logs/* /var/log/tomcat7/
rm -rf logs/
ln -s /var/log/tomcat7/
mv tomcat7 logs
chown tomcat /logs/*
chgrp tomcat /logs/*

# soflinks webapps
echo "creating /var/lib/tomcat7/ softlinks"
mkdir /var/lib/tomcat7/
mkdir /var/lib/tomcat7/webapps/
mv webapps/* /var/lib/tomcat7/webapps/
rm -rf webapps/
ln -s /var/lib/tomcat7/webapps/

# soflinks temp
echo "creating /var/cache/tomcat7/temp/ softlinks"
mkdir /var/cache/tomcat7/
mkdir /var/cache/tomcat7/temp/
mv temp/* /var/cache/tomcat7/temp/
rm -rf temp/
ln -s /var/cache/tomcat7/temp/


# soflinks work
echo "creating /var/cache/tomcat7/work/ softlinks"
mkdir /var/cache/tomcat7/work/
#mv work/* /var/cache/tomcat7/work/
rm -rf work/
ln -s /var/cache/tomcat7/work/

bash /usr/share/tomcat7/bin/shutdown.sh

mv tomcat7 /etc/rc.d/init.d/

chmod 755 /etc/rc.d/init.d/tomcat7

chkconfig --add /etc/rc.d/init.d/tomcat7

chkconfig --level 234 /etc/rc.d/init.d/tomcat7 on 


bash /usr/share/tomcat7/bin/startup.sh


echo "connecting to server... please chill for 30 secs!"
sleep 30
wget http://localhost:8080

echo  "upgrade installed. Done!"



