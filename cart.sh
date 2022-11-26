source common.sh

PRINT "Install Nodejs Repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
STAT $?

PRINT "Install Nodejes"
yum install nodejs -y
STAT $?

PRINT "Adding application user"
useradd roboshop
STAT $?

PRINT "Download App content"
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"
STAT $?

PRINT "Remove previous version of App"
cd /home/roboshop
rm -rf cart
STAT $?

PRINT "Extracting App content"
unzip -o /tmp/cart.zip
STAT $?

mv cart-main cart
cd cart

PRINT "Install Nodejs dependencies for App"
npm install
STAT $?

PRINT "Configure endpoints for systemD configuration"
sed -i -e 's/REDIS_ENDPOINT/redis.devopb69.online/' -e 's/CATALOGUE_ENPOINT/catalogue.devopsb69.online/'
STAT $?

PRINT "Reload SystemD"
systemctl daemon-reload
STAT $?

PRINT "Restart cart"
systemctl restart cart
STAT $?

PRINT "Enable cart service"
systemctl enable cart
STAT $?