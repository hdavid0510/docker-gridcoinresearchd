FROM --platform=$TARGETPLATFORM ubuntu:22.04
LABEL mainainer="gdavid0510@gmail.com"

# Copy basic scripts and configs
WORKDIR /
COPY files /
ENV DEBIAN_FRONTEND=noninteractive
ENV RUNLEVEL=3

# Install system packages 
RUN		apt-get -qq  -o=Dpkg::Use-Pty=0 update \
	&&	apt-get -qqy -o=Dpkg::Use-Pty=0 upgrade \
	&&	apt-get -qqy -o=Dpkg::Use-Pty=0 --no-install-recommends install \
			apt-utils bash-completion software-properties-common sudo gpg-agent

# Install essential packages
RUN		apt-get -qqy -o=Dpkg::Use-Pty=0 --no-install-recommends install \
			openssh-server nano wget curl byobu dialog \
	&&	byobu-enable

# Install supervisor
RUN		apt-get -qqy -o=Dpkg::Use-Pty=0 -o=Dpkg::Options::=--force-confdef --no-install-recommends install \
			supervisor

# Install Gridcoin
RUN		add-apt-repository -y ppa:gridcoin/gridcoin-stable \
	&&	apt-get -qq  -o=Dpkg::Use-Pty=0 update \
	&&	apt-get -qqy -o=Dpkg::Use-Pty=0 --no-install-recommends install \
			gridcoinresearchd boinc boinc-client boinctui

# Cleanup
RUN		apt-get -qq  -o=Dpkg::Use-Pty=0 clean \
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
