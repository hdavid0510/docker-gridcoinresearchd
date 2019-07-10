FROM hdavid0510/ubuntu-sshd:latest

WORKDIR /root
COPY files /
RUN cd /usr/bin \
	&& chmod 755 bt grc grcstart grcupdate start \
	&& echo $BOINC_PASSWD > $BOINC_DATADIR/gui_rpc_auth.cfg \
	&& if ! grep -q "rpcuser" $GRC_DATADIR/gridcoinresearch.conf ; then \
		echo "rpcuser=$GRC_USERNAME" >> $GRC_DATADIR/gridcoinresearch.conf \
		fi \
	&& if ! grep -q "rpcpassword" $GRC_DATADIR/gridcoinresearch.conf ; then \
		echo "rpcpassword=$GRC_PASSWD" >> $GRC_DATADIR/gridcoinresearch.conf \
		fi \
	&& if ! grep -q "rpcport" $GRC_DATADIR/gridcoinresearch.conf ; then \
		echo "rpcport=32748" >> $GRC_DATADIR/gridcoinresearch.conf \
		fi \
	&& if ! grep -q "rpcallowip" $GRC_DATADIR/gridcoinresearch.conf ; then \
		echo "rpcallowip=127.0.0.1" >> $GRC_DATADIR/gridcoinresearch.conf \
		fi

RUN apt-get update -qq \
	&& add-apt-repository -y ppa:gridcoin/gridcoin-stable \
	&& apt-get update -qq \
	&& DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q \
	&& apt-get install --no-install-recommends -y -q \
		gridcoinresearchd boinc boinc-client boinctui 
RUN mkdir /root/.GridcoinResearch

EXPOSE 31416/tcp
EXPOSE 32748/tcp
EXPOSE 32749/tcp
EXPOSE 32750/tcp
EXPOSE 32748/udp
EXPOSE 32749/udp
EXPOSE 32750/udp

ENTRYPOINT [ "/startup.sh" ]