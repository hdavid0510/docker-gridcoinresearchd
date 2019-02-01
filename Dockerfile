FROM hdavid0510/ubuntu-sshd:latest

WORKDIR /root
RUN apt-get update -q
RUN apt-get install --no-install-recommends -y -q software-properties-common \
	&& add-apt-repository -y ppa:gridcoin/gridcoin-stable \
	&& apt-get update -q \
	&& apt-get install --no-install-recommends -y -q gridcoinresearchd git
	
RUN wget -O /usr/bin/gridcoinresearchd.sh https://github.com/elspru/docker-gridcoinresearchd/blob/master/gridcoinresearchd.sh \
	&& chmod +x /usr/bin/gridcoinresearchd.sh \
	&& git clone https://github.com/Deybacsi/grctui
	&& mkdir -p grctui/tmp
	
RUN mkdir /root/.GridcoinResearch
CMD /usr/bin/gridcoinresearchd.sh
