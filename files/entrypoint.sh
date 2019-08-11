#!/bin/bash

# Verify Gridcoin Daemon configuration valid
echo "[INIT] Gridcoin Daemon configuration check"

if [[ -z $GRC_USERNAME ]] ; then
	# Generate random HEX 32-char's long string as password
	echo "[INIT]   GRC_USERNAME unspecified; generating.."
	unset GRC_USERNAME
	export GRC_USERNAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 )
fi
echo "[INIT]   GRC_USERNAME=$GRC_USERNAME"

if [[ -z $GRC_PASSWD ]] ; then
	# Generate random HEX 32-char's long string as password
	echo "[INIT]   GRC_PASSWD unspecified; generating.."
	unset GRC_PASSWD
	export GRC_PASSWD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 )
fi
echo "[INIT]   GRC_PASSWD=$GRC_PASSWD"

if [[ -z $GRC_DATADIR ]] ; then
	echo "[INIT]   GRC_DATADIR unspecified; using default"
	unset GRC_DATADIR
	export GRC_DATADIR=/root/.GridcoinResearch
fi
echo "[INIT]   GRC_DATADIR=$GRC_DATADIR"

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


# Verify BOINC client configuration valid
echo "[INIT] BOINC configuration check"

# Generate random HEX 32-char's long string as password
echo "[INIT]   BOINC /dev/input/mice error workaround"
mkdir -p /dev/input/mice

if [[ -z $BOINC_DATADIR ]] ; then
	echo "[INIT]   BOINC_DATADIR unspecified; using default"
	unset BOINC_DATADIR
	export BOINC_DATADIR=/var/lib/boinc
fi
echo "[INIT]   BOINC_DATADIR=$BOINC_DATADIR"

if [[ -z $BOINC_PASSWD ]] ; then
	# Generate random HEX 32-char's long string as password
	echo "[INIT]   BOINC_PASSWD unspecified; generating.."
	unset BOINC_PASSWD
	export BOINC_PASSWD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 )
fi
echo $BOINC_PASSWD > $BOINC_DATADIR/gui_rpc_auth.cfg
echo "[INIT]   BOINC_PASSWD=$BOINC_PASSWD"

echo "[INIT] Init completed"
if [ -z "$@" ]; then
	# If parameter is not given, init supervisord as default
	echo "[INIT] Start supervisord"
	exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
else
	# Otherwise, execute parameter given.
	echo "[INIT] Start commands passed by parameter: $@"
	exec $@
fi
