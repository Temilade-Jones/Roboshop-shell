source common.sh

PRINT "Install Nodejs Repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>LOG
STAT $?

PRINT "Install Nodejes"
yum install nodejs -y &>>LOG
STAT $?

PRINT "Adding application user"
useradd roboshop &>>LOG
STAT $?

PRINT "Download App content"
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>LOG
STAT $?

PRINT "Remove previous version of App"
cd /home/roboshop &>>LOG
rm -rf cart
STAT $?

PRINT "Extracting App content"
unzip -o /tmp/cart.zip &>>LOG
STAT $?

mv cart-main cart &>>LOG
cd cart

PRINT "Install Nodejs dependencies for App"
npm install &>>LOG
STAT $?

PRINT "Configure endpoints for systemD configuration"
sed -i -e 's/REDIS_ENDPOINT/redis.devopb69.online/' -e 's/CATALOGUE_ENPOINT/catalogue.devopsb69.online/' &>>LOG
STAT $?

PRINT "Reload SystemD"
systemctl daemon-reload &>>LOG
STAT $?

PRINT "Restart cart"
systemctl restart cart &>>LOG
STAT $?

PRINT "Enable cart service"
systemctl enable cart &>>LOG
STAT $?