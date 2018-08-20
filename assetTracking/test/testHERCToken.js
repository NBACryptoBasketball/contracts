var HERCToken = artifacts.require('HERCToken')

contract('HERCToken', async functio(accounts) {
    let account0 = accounts[0]
    let account1 = accounts[1]

    before('init', async function() {
        let token = await HERCToken.deployed()
        let createAsset = await CreateAsset.deployed()
    })

    it('token', async function() {
        let token = await HERCToken.deployed()

        await token.totalSupply()
        await token.balanceOf(account0)
        await token.transfer(account0, account1, "")
        await token.transferFrom(account0, account1, "")
        await token.approve(accoun0, 100)
        await token.allowance(account0)
    })
})
