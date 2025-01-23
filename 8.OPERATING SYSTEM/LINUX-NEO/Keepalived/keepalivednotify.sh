#!/bin/bash

TYPE=$1
NAME=$2
STATE=$3

echo TYPE=$TYPE 
echo name=$NAME
echo state=$STATE
ASERVER_HOME=/app/fusion/admin_config/domains/vdi_domain/bin
START_WEBLOGIC=/app/fusion/admin_config/domains/vdi_domain/bin/startWebLogic.sh
case $STATE in
        "MASTER") mount /dev/sdb1 /app/fusion/admin_config
                  echo MASTER
		  systemctl start haproxy
                  exit 0
                  ;;
        "BACKUP") systemctl stop haproxy
		  echo BACKUP
                  umount /dev/sdb1
                  exit 0
                  ;;
        "FAULT")  systemctl stop haproxy
		  umount /dev/sdb1
		  echo  FAULT
                  exit 0
                  ;;
        *)        echo "unknown state"
                  exit 1
                  ;;
		 start() {
			echo -n "Starting weblogic: "
		 cd $ASERVER_HOME
		 ${START_WEBLOGIC}
		 echo "done."
		}

esac

