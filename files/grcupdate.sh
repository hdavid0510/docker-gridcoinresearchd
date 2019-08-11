#!/bin/bash

if [ -z $1 ] || [ -z $2 ] ; then
	echo -e "\e[93m[GRCUPDATE] \e[92mInvalid parameter. (rpcuser=$1 rpcpassword=$2)\e[0m"
	exit 1;
fi

printf '<html style="font-family:consolas;color:white">UTC%s<br/>H %s<br/>B %s</html>' \
	$(date +"%Y%m%d.%H:%M:%S") \
	"$(gridcoinresearchd -rpcuser=$1 -rpcpassword=$2 getblockcount 2>&1)" \
	"$(gridcoinresearchd -rpcuser=$1 -rpcpassword=$2 getbalance 2>&1)" > /blocks.html
exit 0;
