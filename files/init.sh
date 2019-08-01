#!/bin/bash

# Verify Gridcoin Daemon configuration valid
echo "Gridcoin Daemon configuration check"
if [[ -z $GRC_USERNAME ]] ; then
	# Generate random HEX 32-char's long string as password
	export GRC_USERNAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 )
fi
if [[ -z $GRC_PASSWD ]] ; then
	# Generate random HEX 32-char's long string as password
	export GRC_PASSWD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 )
fi
if [[ -z $(grep "rpcuser" $GRC_DATADIR/gridcoinresearch.conf) ]] ; then
	echo "rpcuser=$GRC_USERNAME" | tee -a $GRC_DATADIR/gridcoinresearch.conf
fi
if [[ -z $(grep "rpcpassword" $GRC_DATADIR/gridcoinresearch.conf) ]] ; then
	echo "rpcpassword=$GRC_PASSWD" | tee -a $GRC_DATADIR/gridcoinresearch.conf
fi
if [[ -z $(grep "rpcport" $GRC_DATADIR/gridcoinresearch.conf) ]] ; then
	echo "rpcport=32748" | tee -a $GRC_DATADIR/gridcoinresearch.conf
fi
if [[ -z $(grep "rpcallowip" $GRC_DATADIR/gridcoinresearch.conf) ]] ; then
	echo "rpcallowip=127.0.0.1" | tee -a $GRC_DATADIR/gridcoinresearch.conf
fi

# Update BOINC RPC passwd; generate one if not provided
echo "Update BOINC RPC password"
if [[ -z $BOINC_PASSWD ]] ; then
	# Generate random HEX 32-char's long string as password
	export BOINC_PASSWD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 )
fi
echo $BOINC_PASSWD > $BOINC_DATADIR/gui_prc_auth.cfg
echo "BOINC_PASSWD=$BOINC_PASSWD"