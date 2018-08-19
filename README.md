# Helping Eradicate Racketeering & Collusion

HERC Protocol Software Access Tokens are utlized as a throughput for Interopertable Blockchain Usage. A full description of the protocol may be found in our whitepaper. This repository contains the system of Executable Distributed Code Contracts built with Solidity comprising HERC protocol's native token (HERC), decentralized governance structure, and throughput exchange. 
Truffle is used for deployment. Mocha is used for unit tests. 

Join the [![Discord](https://img.shields.io/discord/102860784329052160.svg)](https://discord.gg/ntWZ53W)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

![HERC](herc.png)

## Useful HERC Documentation

 * [HERC.ONE](https://herc.one)
 * [Whitepaper](https://github.com/hercone/whitepaper)
 
## Getting Started:

### Installing Dependancies: 

```
sudo apt-get update
sudo apt-get install -y curl
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs node-gyp git build-essential
```
Confirm Node is available
```
nodejs --version
v8.9.4
node --version
v8.9.4
```
```
sudo npm install -g truffle@4.0.7
```
Confirm Truffle Version
```
truffle version
Truffle v4.0.7(core: 4.0.7)
Solidity v0.4.19 (solc-js)
```
```
truffle
Truffle v4.0.7 - a development framework for Ethereum
...
```
```
mkdir DAPPS
cd ~/DAPPS
mkdir HERC
cd HERC
truffle init
```
Clone this repo into the $PATH

#### Running Tests

Start Testrpc
```
npm run testrpc
```
Compile contracts
```
npm run compile
```
Run Tests
```
npm run test
```

### Contributing	

HERC protocol is an open source and community based project to which the core development team highly encourages fellow developers to build improvements and scale the future of the platform.  
To report bugs within the HERC smart contracts or unit tests, please create an issue in this repository. 

## HIPS
Parlimentary or Significant changes to HERC protocol's smart contracts, architecture, message format or functionality should be proposed in the 
[HERC Improvement Proposals (HIPS)](https://github.com/hercone/hips) repository. Follow the contribution guidelines provided therein :) 

### Coding Conventions
As we have found from other projects such as 0x and other Ethereum based platforms we use a custom set of [TSLint](https://palantir.github.io/tslint/) rules to enforce our coding conventions. 

In order to see style violation erros, install a tsliner for your text editor. e.g Atom's [atom-typescript](https://atom.io/packages/atom-typescript)
