FROM hdavid0510/ubuntu-sshd:latest

WORKDIR /root

RUN apt-get update -qq \
	&& add-apt-repository -y ppa:gridcoin/gridcoin-stable \
	&& apt-get update -qq \
	&& apt-get install --no-install-recommends -y -q gridcoinresearchd boinc boinc-client boinctui
RUN wget -O /usr/bin/gridcoinresearchd.sh https://github.com/elspru/docker-gridcoinresearchd/blob/master/gridcoinresearchd.sh \
	&& chmod +x /usr/bin/gridcoinresearchd.sh \
	&& mkdir /root/.GridcoinResearch

EXPOSE 31416
EXPOSE 32749
EXPOSE 32750

CMD /usr/bin/gridcoinresearchd.sh
