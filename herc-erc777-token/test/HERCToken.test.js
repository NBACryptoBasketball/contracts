/* This Source Code Form is subject to the terms of the Mozilla Public
* License, v. 2.0. If a copy of the MPL was not distributed with this
* file, You can obtain one at http://mozilla.org/MPL/2.0/. */
const chai = require('chai');
const assert = chai.assert;
chai.use(require('chai-as-promised')).should();
const { URL } = require('url');
const Web3 = require('web3');
const EIP820Registry = require('eip820');
const OldHERCToken = artifacts.require('HERCToken');
const utils = require('./utils');

contract('HERCToken', function(accounts) {
  const provider = new URL(this.web3.currentProvider.host);
  provider.protocol = 'ws';
  const web3 = new Web3(provider.toString());
  const HERCToken = new web3.eth.Contract(
    OldHERCToken.abi,
    { data: OldHERCToken.bytecode }
  );

  let token = {
    name: 'Hercules',
    symbol: 'HERC',
    granularity: '1',
    defaultOperators: [accounts[6], accounts[7]],
    burnOperator: accounts[8],
    totalSupply: '234259085',
    defaultBalance: '0',
  };

  const deployContract = HERCToken
    .deploy({ arguments: [
      token.defaultOperators,
      token.burnOperator,
    ] });

  after(async function() { await web3.currentProvider.connection.close(); });

  beforeEach(async function() {
    let erc820Registry = await EIP820Registry.deploy(web3, accounts[0]);
    assert.ok(erc820Registry.$address);

    // Use Web3.js 1.0
    const estimateGas = await deployContract.estimateGas();
    token.contract = await deployContract
      .send({ from: accounts[0], gasLimit: estimateGas });
    assert.ok(token.contract.options.address);

    token.disableERC20 = async function() {
      await token.contract.methods
        .disableERC20()
        .send({ gas: 300000, from: accounts[0] });
    };

    token.genMintTxForAccount = function(account, amount, operator, gas) {
      return token.contract.methods
        .mint(account, web3.utils.toWei(amount), '0xcafe')
        .send.request({ gas: gas, from: operator });
    };
  });

  describe('Creation', function() {
    it('should deploy', async function() {
      const estimateGas = await deployContract.estimateGas();
      await HERCToken
        .deploy({ arguments: [
          token.defaultOperators,
          token.burnOperator,
        ] })
        .send({ from: accounts[0], gasLimit: estimateGas })
    });
  });

  require('./utils/attributes').test(web3, accounts, token);
/*  require('./utils/mint').test(web3, accounts, token);
  require('./utils/burn').test(web3, accounts, token);
  require('./utils/send').test(web3, accounts, token);
  require('./utils/operator').test(web3, accounts, token);
  require('./utils/operatorBurn').test(web3, accounts, token);
  require('./utils/operatorSend').test(web3, accounts, token);
  require('./utils/tokensSender').test(web3, accounts, token);
  require('./utils/tokensRecipient').test(web3, accounts, token);
  require('./utils/erc20Compatibility').test(web3, accounts, token);
*/
/*
  describe('ERC20 Disable', function() {
    it('should disable ERC20 compatibility', async function() {
      let erc820Registry = utils.getERC820Registry(web3);
      let erc20Hash = web3.utils.keccak256('ERC20Token');
      let erc20Addr = await erc820Registry.methods
        .getInterfaceImplementer(token.contract.options.address, erc20Hash)
        .call();

      assert.strictEqual(erc20Addr, token.contract.options.address);

      await token.disableERC20();

      await utils.getBlock(web3);
      erc20Addr = await erc820Registry.methods
        .getInterfaceImplementer(token.contract.options.address, erc20Hash)
        .call();

      assert.strictEqual(
        erc20Addr, '0x0000000000000000000000000000000000000000');
    });
  });
*/

//  require('./utils/erc20Disabled').test(web3, accounts, token);

  describe('summary', function() {
    it('basic testing done', async function() {});
    it('todo extend tests', async function() {});
  });
});
