FROM hdavid0510/ubuntu-sshd:latest

WORKDIR /root
COPY files /

RUN apt-get update -qq \
	&& add-apt-repository -y ppa:gridcoin/gridcoin-stable \
	&& apt-get update -qq \
	&& apt-get install --no-install-recommends -y -q \
		gridcoinresearchd boinc boinc-client boinctui 
RUN mkdir /root/.GridcoinResearch

EXPOSE 31416/tcp
EXPOSE 32749/tcp
EXPOSE 32750/tcp
EXPOSE 32749/udp
EXPOSE 32750/udp

ENTRYPOINT [ "/startup.sh" ]