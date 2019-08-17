#!/bin/bash

DEFAULT_GRC_USERNAME=''
DEFAULT_GRC_PASSWD=''

#Credentials validity check
# 1) environment variable
# 2) parameter
# 3) default credendials given above 
if [ -z $GRC_USERNAME ] || [ -z $GRC_PASSWD ] ; then
	if [ -z $1 ] || [ -z $2 ] ; then
		GRC_USERNAME=$DEFAULT_GRC_USERNAME ;
		GRC_PASSWD=$DEFAULT_GRC_PASSWD ;
	else
		GRC_USERNAME=$1 ;
		GRC_PASSWD=$2 ;
	fi
fi
GRC="gridcoinresearchd -rpcuser=$GRC_USERNAME -rpcpassword=$GRC_PASSWD"

echo \<html style="font-family:consolas;color:white"\> $(date +'%Y%m%d %T %Z(%:z)')\<br \/\>H "$($GRC getblockcount 2>&1)"\<br \/\>B "$($GRC getbalance 2>&1)"\<\/html\> | tee /blocks.html