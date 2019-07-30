FROM hdavid0510/ubuntu-sshd:latest

# Copy basic scripts and configs
WORKDIR /root
COPY files /

# Activate copied files
RUN		chmod 755 /usr/bin/bt /usr/bin/grc /usr/bin/grcupdate /usr/bin/start \
	&&	mkdir /root/.GridcoinResearch \
	&&	echo -e "\n\n# Daemon startup script\n/usr/bin/start" >> /startup.sh

# Install required packages 
RUN		apt-get update -qq \
	&&	add-apt-repository -y ppa:gridcoin/gridcoin-stable \
	&&	apt-get update -qq \
	&&	DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -q \
	&&	apt-get install --no-install-recommends -y -q \
		gridcoinresearchd boinc boinc-client boinctui

# Port expose
EXPOSE 31416/tcp
#EXPOSE 32748/tcp
#EXPOSE 32748/udp
EXPOSE 32749/tcp
#EXPOSE 32749/udp
EXPOSE 32750/tcp
#EXPOSE 32750/udp

# Default environent variable values
ENV GRC_DATADIR /root/.GridcoinResearch
ENV BOINC_DATADIR /var/lib/boinc

ENTRYPOINT [ "/startup.sh" ]