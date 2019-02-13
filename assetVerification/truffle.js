require('dotenv').config();
const HDWalletProvider = require('truffle-hdwallet-provider');

const web3 = require('web3');

//const mainnetUrl = `https://mainnet.infura.io/${process.env.INFURA}`;
//const ropstenUrl = `https://ropsten.infura.io/${process.env.INFURA}`;
const mainnetUrl = 'https://eth-mainnet.alchemyapi.io/jsonrpc/DCuuSowPM6WbBCkzVfyl8VRYEIjNh9L8'
//const mainnetUrl = 'https://eth-mainnet.alchemyapi.io/jsonrpc/9JkIkMa6aBj4U0vdffA-bXTfl6rS6TMz'
const ropstenUrl = 'https://eth-ropsten.alchemyapi.io/jsonrpc/9JkIkMa6aBj4U0vdffA-bXTfl6rS6TMz'

console.log('process.env.MNEMONIC', process.env.MNEMONIC)
console.log('mainnetUrl', mainnetUrl)
console.log('ropstenUrl', ropstenUrl)

var _providerLogged

module.exports = {
  networks: {
    development: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*',
      gas: 7000000,
      gasPrice: web3.utils.toWei('2', 'gwei'),
    },
    ganache: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*",
    },
    ropsten: {
      provider() {
        var provider = new HDWalletProvider(process.env.MNEMONIC, ropstenUrl, 0);
        if (!_providerLogged) {
          _providerLogged = true
          console.log('deploy_account:', provider.addresses[0])
        }
        return provider
      },
      network_id: 3,
      gasPrice: web3.utils.toWei('50', 'gwei'),
      gas: 8000000,
    },
    live: {
      provider() {
        return new HDWalletProvider(process.env.MNEMONIC, mainnetUrl, 0);
      },
      network_id: 1,
      gasPrice: web3.utils.toWei('2', 'gwei'),
      gas: 7992222,
    },
  },
  mocha: {
    useColors: true,
  },
  solc: {
      version: "0.4.25",  
//        docker: true,
      optimizer: {
      enabled: true,
      runs: 200,
    },
  },
};

/*module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    }
  }
};
*/