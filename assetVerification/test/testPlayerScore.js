let PlayerScore = artifacts.require('PlayerScore')

contract('PlayerScore', async function(accounts) {
    let account0 = accounts[0]
    let account1 = accounts[1]

    before('init', async function() {
        let playerScore = await PlayerScore.deployed()
    })

    it('all-logic', async function() {
        let playerScore = await PlayerScore.deployed()

        await PlayerScore.SetScore(1)
        await PlayerScore.SetScore(5)
        await PlayerScore.SetScore(4)
        await PlayerScore.SetScore(3)
        await PlayerScore.SetScore(2)
        await PlayerScore.SetScore(6)

        let topScoresCount = await PlayerScore.GetTopScoresCount()
        let score = await PlayerScore.Scores(account0)

        assert.equal(topScores, 6, 'account0 score != 6')
        assert.equal(topScoresCount, 5, 'topScoresCount != 5')

        let topScore0 = await PlayerScore.TopScores(0)
        let topScore5 = await PlayerScore.TopScores(5)
        assert.equal(topScore0, 2, 'account0 score[0] != 2')
        assert.equal(topScore5, 6, 'account0 score[5] != 6')
    })
})
