STAT() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
  fi
}

PRINT() {
echo -e "\e[33M$1\e[0m"
}

LOG=/tmp/$component.log
rf -f$log
