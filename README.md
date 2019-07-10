# gridcoinresearch-client-daemon
[![](https://images.microbadger.com/badges/version/hdavid0510/gridcoinresearch-client-daemon:latest.svg)](https://microbadger.com/images/hdavid0510/gridcoinresearch-client-daemon:latest)
[![](https://images.microbadger.com/badges/image/hdavid0510/gridcoinresearch-client-daemon:latest.svg)](https://microbadger.com/images/hdavid0510/gridcoinresearch-client-daemon:latest)  
GridcoinResearch Daemon server on top of ubuntu docker

## Prerequisites
1. Bind Gridcoin Client data folder(`.GridcoinResearch`) in HOST to `/root/.GridcoinResearch` in container.
2. Make sure port `32749(tcp)` is opened for Gridcoin Client. Open port `32750` instead if using TestNet.
3. Open port `31416` to use BOINC RPC.
4. Open port `22` to enable SSH outbound. _not recommended for insecure environment!_
5. Open port `32748` to use Gridcoin RPC
6. Bind html file in host to `/blocks.html` in container to serve realtime-updated gridcoin status webpage.

## Environment variables
| variable name |  |value 	|
|--------------	|------- | ----	|
| `GRC_USERNAME`    | Required | Username for GridcoinResearch daemon RPC 	|
| `GRC_PASSWD` 	| Required | Password for GridcoinResearch daemon RPC 	|
| `BOINC_PASSWD` 	| Required | Password for BOINC client RPC GUI |
| `GRC_DATADIR` | Optional | Full path where .GridcoinResearch located |
| `BOINC_DATADIR`  | Optional | Full path where .GridcoinResearch located |
|   |   |
