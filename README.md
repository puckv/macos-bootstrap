# macos-bootstrap

Set of scripts which I use to bootstrap a new mac. Settings are tailored for my needs and it installs lot of software (proprietary scripts and 3rd party), so it won't suit most people out of the box.

## Usage and post-bootstrap instructions

#### Download and run bootstrap script: 

```bash
curl -sSLo macos-bootstrap-master.tar.gz https://github.com/puckv/macos-bootstrap/archive/master.tar.gz && \
tar zxf macos-bootstrap-master.tar.gz && \
macos-bootstrap-master/bootstrap.sh
```

#### Reboot

#### Perform manual configuration
 
Configure [System Preferences](manual/macos-preferences.md) which could not be configured via script

#### Install and configure essentials
  
1. Firewall: [Little Snitch](manual/little-snitch.md)
2. Synced folders:
    * [Dropbox](https://www.dropbox.com/)
    * [Cryptomator](https://cryptomator.org/downloads/#macDownload), mount ~/Dropbox/Encrypted as DropboxEncrypted
3. [Google Chrome](manual/chrome.md) 
* [Other software](manual/other.md)

#### Optional cleanup

```bash
rm -r macos-bootstrap-master macos-bootstrap-master.tar.gz
```
