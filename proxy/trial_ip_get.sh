ifconfig | egrep wlp5 -A 1 | egrep inet | awk '{print $2}'
