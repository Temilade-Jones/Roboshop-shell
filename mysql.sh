if [ -z "$1" ]; then
  echo input argument password is needed
  exit
  fi

ROBOSHOP_MYSQL_PASSWORD=$1

STAT() {
  if [ $? -eq 0 ]; then
    echo SUCCESS
  else
    echo FAILURE
  fi
}

PRINT() {
echo -e "\e[33M$1\e[0m"
}

PRINT "Downloading MySQL Repo file"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
STAT $?

PRINT "disable mysql 8 version repo"
dnf module disable mysql -y
STAT $?

PRINT "install mysql"
yum install mysql-community-server -y
STAT $?

PRINT "enable mysql service"
systemctl enable mysqld
STAT $?

PRINT "start mysql service"
systemctl restart mysqld
STAT $?

echo show databases | mysql -uroot -p${ROBOSHOP_MYSQL_PASSWORD}
if [ $? -ne 0 ]
then
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Roboshop@1';" > /tmp/root-pass-sql
  DEFAULT_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')
  cat /tmp/root-pass-sql | mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}"

fi


}