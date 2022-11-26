STAT() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
  fi
}

PRINT() {
echo -e "\e[33M$1\e[0m"
echo check error in $LOG file
}

LOG=/tmp/$component.log
rm -f $log

NODEJES () { PRINT "Install Nodejs Repos"
          curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>LOG
          STAT $?

          PRINT "Install Nodejes"
          yum install nodejs -y &>>LOG
          STAT $?

          PRINT "Adding application user"
          id roboshop &>>$LOG
          if [ $? -ne 0 ]; then
            useradd roboshop &>>LOG
            fi
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
}