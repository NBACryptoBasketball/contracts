let PuzzleManager = artifacts.require('PuzzleManager')

contract('PuzzleManager', async function(accounts) {
    before('init', async function() {
        let puzzleManager = await PuzzleManager.deployed()
    })

    it('all-logic', async function() {
        let puzzleManager = await PuzzleManager.deployed()

        let createPuzzleResult = await puzzleManager.CreatePuzzle('metrics0')
        let puzzleId = 0
        let pushMetrixResult = await puzzleManager.PushMetrics(puzzleId, 'metrics1')
        let compareMetricsResult = await puzzleManager.CompareMetrics(puzzleId)
        let getPuzzleOriginalMetricsResult = await puzzleManager.GetPuzzleOriginalMetrics(puzzleId)
        let getPuzzleMetricsResult = await puzzleManager.GetPuzzleMetrics(puzzleId)
    })
})
