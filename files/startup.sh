#!/bin/bash
# Script runs on docker initialization

# Verify Gridcoin Daemon configuration valid
echo "Gridcoin Daemon configuration check"
if [ -z $GRC_USERNAME ] ; then
	# Generate random HEX 32-char's long string as password
	export GRC_USERNAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 )
fi
if [ -z $GRC_PASSWD ] ; then
	# Generate random HEX 32-char's long string as password
	export GRC_PASSWD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 )
fi
if ! grep -q "rpcuser" $GRC_DATADIR/gridcoinresearch.conf ; then
	echo "rpcuser=$GRC_USERNAME" >> $GRC_DATADIR/gridcoinresearch.conf
fi
if ! grep -q "rpcpassword" $GRC_DATADIR/gridcoinresearch.conf ; then
	echo "rpcpassword=$GRC_PASSWD" >> $GRC_DATADIR/gridcoinresearch.conf
fi
if ! grep -q "rpcport" $GRC_DATADIR/gridcoinresearch.conf ; then
	echo "rpcport=32748" >> $GRC_DATADIR/gridcoinresearch.conf
fi
if ! grep -q "rpcallowip" $GRC_DATADIR/gridcoinresearch.conf ; then
	echo "rpcallowip=127.0.0.1" >> $GRC_DATADIR/gridcoinresearch.conf
fi

# Update BOINC RPC passwd; generate one if not provided
echo "Update BOINC RPC password"
if [ -z $BOINC_PASSWD ] ; then
	# Generate random HEX 32-char's long string as password
	export BOINC_PASSWD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 )
fi
echo $BOINC_PASSWD > $BOINC_DATADIR/gui_prc_auth.cfg

# Daemon start
echo "Start daemons"
exec /usr/bin/start

# SSH server run
echo "SSHD start"
exec /usr/sbin/sshd -D