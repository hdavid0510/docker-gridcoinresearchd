#!/bin/bash

# Server initiators #########
start_boinc_daemon(){
	echo "Starting BOINC daemon..."
	boinc -daemon --allow_remote_gui_rpc --dir /var/lib/boinc-client
}

start_grc_server(){
	echo "Starting GRC client daemon..."
	/bin/sh -c '/usr/bin/grcstart'
}

# Docker image init #########
echo $BOINC_PASSWD > /var/lib/boinc-client/gui_prc_auth.cfg

# Instance Init #############
case $1 in
"")
	start_boinc_daemon
	start_grc_server
	;;
b|boinc)
	start_boinc_daemon
	;;
g|grc|grcd|gridcoin)
	start_grc_server
	;;
*)
	echo usage: $(basename "$0") [(blank)|b|g]
	echo (blank)	Run All
	echo b	Run BOINC only
	echo g	Run GridcoinResearch daemon only
	echo ""
esac
