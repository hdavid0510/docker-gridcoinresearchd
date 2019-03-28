# gridcoinresearch-client-daemon
[![](https://images.microbadger.com/badges/version/hdavid0510/gridcoinresearch-client-daemon:latest.svg)](https://microbadger.com/images/hdavid0510/gridcoinresearch-client-daemon:latest)
[![](https://images.microbadger.com/badges/image/hdavid0510/gridcoinresearch-client-daemon:latest.svg)](https://microbadger.com/images/hdavid0510/gridcoinresearch-client-daemon:latest)  
GridcoinResearch Daemon server on top of ubuntu docker

## Prerequisites
1. Bind Gridcoin Client data folder(`.GridcoinResearch`) stored in host device to `/root/.GridcoinResearch` inside container.
2. Make sure if port for Gridcoin Client, `32749(tcp)` is opened.
3. If you want to use BOINC client remote GUI, make sure if port `31416` is opened.
4. To enable SSH outside, make sure port `22` is publically opened. _(not recommended for insecure environment)_

## Environment variables
| variable name | value 	|
|--------------	|-------	|
| GRC_USERNAME 	| Username for GridcoinResearch daemon RPC 	|
| GRC_PASSWD 	| Password for GridcoinResearch daemon RPC 	|
| BOINC_PASSWD 	| Password for BOINC client RPC GUI |
|   |   |
