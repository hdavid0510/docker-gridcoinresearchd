# gridcoinresearch-client-daemon
[![](https://img.shields.io/docker/pulls/hdavid0510/gridcoinresearch-client-daemon?style=flat-square)](https://hub.docker.com/r/hdavid0510/gridcoinresearch-client-daemon) [![](https://img.shields.io/docker/cloud/build/hdavid0510/gridcoinresearch-client-daemon?style=flat-square)]() [![](https://img.shields.io/github/issues/hdavid0510/docker-gridcoinresearchd?style=flat-square)](https://github.com/hdavid0510/gridcoinresearch-client-daemon/issues)  
[![](https://img.shields.io/docker/v/hdavid0510/gridcoinresearch-client-daemon/latest?style=flat-square)]() [![](https://img.shields.io/docker/image-size/hdavid0510/gridcoinresearch-client-daemon/latest?style=flat-square)]()  
[![](https://img.shields.io/docker/v/hdavid0510/gridcoinresearch-client-daemon/dev?style=flat-square)]() [![](https://img.shields.io/docker/image-size/hdavid0510/gridcoinresearch-client-daemon/dev?style=flat-square)]()  
Dockerized GridcoinResearch headless client on Ubuntu.


## Port Bindings
| Option | Port# | Type | Service |
| ------ | ----- | ---- | ------- |
|__Required__|32749|tcp| Gridcoin Client|
|_Optional_|22|tcp|SSH __Not recommended in insecure environment!__|
|_Optional_|31416|tcp| BOINC RPC|
|_Optional_|32750|tcp| Gridcoin TestNet|


## Volume Bindings
| Option | in Container | to Host | Note |
| ------ | ------------ | ------- | ---- |
|Recommended| `/root/.GridcoinResearch` | Directory to contain Gridcoin wallet data. | New default volume will be created if not specified. |
|_Optional_| `/grcupdate.sh` | Gridcoin status `.html` page to serve publically, in real-time. | |
|_Optional_| `/blocks.html` | File updated by default `/grcupdate.sh` script; not needed if customized `/grcupdate.sh` don't use this file. | |


## Environment variables
| Option | Name | default | value |
| ------ | ---- | ------- | ----- |
|__*Required__|`GRC_USERNAME`	|_N/A_	|Username for GridcoinResearch daemon RPC	|
|__*Required__|`GRC_PASSWD`	|_N/A_	|Password for GridcoinResearch daemon RPC	|
|__*Required__|`BOINC_PASSWD`	|_Random_ [1]	|Password for BOINC client RPC GUI	|
|_Optional_|`GRC_DATADIR`	|`/root/.GridcoinResearch`	|Full path of `.GridcoinResearch` __inside container__	|
|_Optional_|`BOINC_DATADIR`|`/var/lib/boinc`	|Full path of BOINC data directory __inside container__	|

[1] Random string with 32 HEX characters will be generated each time the container started.