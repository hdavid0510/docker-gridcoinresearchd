FROM hdavid0510/ubuntu-sshd:latest

WORKDIR /root

RUN apt-get update -qq \
	&& add-apt-repository -y ppa:gridcoin/gridcoin-stable \
	&& apt-get update -qq \
	&& apt-get install --no-install-recommends -y -q gridcoinresearchd boinc boinc-client boinctui
RUN echo -e '#!/bin/bash \n\
if [! $(pgrep gridcoinresearchd) ]; then \n\
	if [ -f /root/.GridcoinResearch/gridcoinresearch.conf ]; then ; /usr/bin/gridcoinresearchd && echo "gridcoinresearchd started!"\n\
	else ; echo "please mount your $HOME/.GridcoinResearch to /root/.GridcoinResearch" \n\
	fi \n\
else ; /usr/bin/gridcoinresearchd $@ \n\
fi' > /usr/bin/gridcoinresearchd.sh \
	&& chmod +x /usr/bin/gridcoinresearchd.sh \
	&& mkdir /root/.GridcoinResearch

EXPOSE 31416
EXPOSE 32749
EXPOSE 32750

CMD /usr/bin/gridcoinresearchd.sh
