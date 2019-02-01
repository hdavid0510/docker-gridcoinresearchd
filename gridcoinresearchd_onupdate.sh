#!/bin/bash
printf '<html style="font-family:consolas;color:white">KST%s<br/>H %s<br/>B %s</html>' \
	$(date +"%Y%m%d.%H:%M:%S") \
	"$(gridcoinresearchd -rpcuser=$GRC_USERNAME -rpcpassword=$GRC_PASSWD getblockcount 2>&1)" \
	"$(gridcoinresearchd -rpcuser=$GRC_USERNAME -rpcpassword=$GRC_PASSWD getbalance 2>&1)" > /blocks.html
