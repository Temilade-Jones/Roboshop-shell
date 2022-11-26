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