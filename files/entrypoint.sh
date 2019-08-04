#!/bin/bash

set -e

# Verify Gridcoin Daemon configuration valid
echo "[INIT] Gridcoin Daemon configuration check"
if [[ -z $GRC_USERNAME ]] ; then
	# Generate random HEX 32-char's long string as password
	export GRC_USERNAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 )
fi
echo "[INIT]   GRC_USERNAME=$GRC_USERNAME"

if [[ -z $GRC_PASSWD ]] ; then
	# Generate random HEX 32-char's long string as password
	export GRC_PASSWD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 )
fi
echo "[INIT]   GRC_PASSWD=$GRC_PASSWD"

if [[ -z $(grep "rpcuser" $GRC_DATADIR/gridcoinresearch.conf) ]] ; then
	echo "[INIT]   SET:rpcuser=$GRC_USERNAME"
	echo "rpcuser=$GRC_USERNAME" | tee -a $GRC_DATADIR/gridcoinresearch.conf
fi
if [[ -z $(grep "rpcpassword" $GRC_DATADIR/gridcoinresearch.conf) ]] ; then
	echo "[INIT]   SET:rpcpassword=$GRC_PASSWD"
	echo "rpcpassword=$GRC_PASSWD" | tee -a $GRC_DATADIR/gridcoinresearch.conf
fi
if [[ -z $(grep "rpcport" $GRC_DATADIR/gridcoinresearch.conf) ]] ; then
	echo "[INIT]   SET:rpcport=32748"
	echo "rpcport=32748" | tee -a $GRC_DATADIR/gridcoinresearch.conf
fi
if [[ -z $(grep "rpcallowip" $GRC_DATADIR/gridcoinresearch.conf) ]] ; then
	echo "[INIT]   SET:rpcallowip=127.0.0.1"
	echo "rpcallowip=127.0.0.1" | tee -a $GRC_DATADIR/gridcoinresearch.conf
fi


# Update BOINC RPC passwd; generate one if not provided
echo "[INIT] Update BOINC RPC password"
if [[ -z $BOINC_PASSWD ]] ; then
	# Generate random HEX 32-char's long string as password
	unset BOINC_PASSWD
	export BOINC_PASSWD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 )
	echo "[INIT]   BOINC_PASSWD reset"
fi
echo $BOINC_PASSWD > $BOINC_DATADIR/gui_prc_auth.cfg
echo "[INIT]   BOINC_PASSWD=$BOINC_PASSWD"

echo "[INIT] Init completed"
if [ -z "$@" ]; then
	# If parameter is not given, init supervisord as default
	exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
else
	# Otherwise, execute parameter given.
	exec $@
fi
