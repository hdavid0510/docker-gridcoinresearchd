FROM hdavid0510/ubuntu-sshd:latest
RUN apt-get update -q
RUN apt-get install --no-install-recommends -y -q software-properties-common \
	&& add-apt-repository -y ppa:gridcoin/gridcoin-stable \
	&& apt-get update -q \
	&& apt-get install --no-install-recommends -y -q gridcoinresearchd
WORKDIR /root
RUN wget -O /usr/bin/gridcoinresearchd.sh https://github.com/elspru/docker-gridcoinresearchd/blob/master/gridcoinresearchd.sh \
	&& chmod +x /usr/bin/gridcoinresearchd.sh
RUN mkdir /root/.GridcoinResearch
CMD /usr/bin/gridcoinresearchd.sh
