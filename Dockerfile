FROM --platform=$TARGETPLATFORM ubuntu:22.04
LABEL mainainer="gdavid0510@gmail.com"

# Copy basic scripts and configs
WORKDIR /
COPY files /

# Install system packages 
RUN		apt-get update -qq -o=Dpkg::Use-Pty=0 \
	&&	apt-get upgrade -qq -o=Dpkg::Use-Pty=0 -y \
	&&	DEBIAN_FRONTEND=noninteractive apt-get -qq install --no-install-recommends -y \
			apt-utils bash-completion software-properties-common sudo gpg-agent

# Install essential packages
RUN		apt-get install -qq -o=Dpkg::Use-Pty=0 --no-install-recommends -y \
		openssh-server nano wget curl byobu dialog supervisor \
	&&	byobu-enable

# Install Gridcoin
RUN		add-apt-repository -y ppa:gridcoin/gridcoin-stable \
	&&	apt-get update -qq -o=Dpkg::Use-Pty=0 \
	&&	apt-get install -qq -o=Dpkg::Use-Pty=0 --no-install-recommends -y \
			gridcoinresearchd boinc boinc-client boinctui

# Cleanup
RUN		apt-get clean -qq \
	&&	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Adjust permissions on copied files
WORKDIR /root
RUN		chmod 755 /usr/bin/b /usr/bin/grc /grcupdate.sh /entrypoint.sh \
	&&	ln -s /etc/supervisor/supervisord.conf /etc/supervisord.conf \
	&&	mkdir -p /root/.GridcoinResearch \
	&&	mkdir -p /var/run/sshd \
	&&	sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config \
	&&	sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
	&&	mkdir -p /root/.ssh \
	&&	chmod 700 /root/.ssh \
	&&	touch /root/.ssh/authorized_keys \
	&&	chmod 600 /root/.ssh/authorized_keys

# Port expose
EXPOSE 22/tcp
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
RUN sed -i '8isource \/etc\/environment_creds' /root/.profile

# RUN
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
