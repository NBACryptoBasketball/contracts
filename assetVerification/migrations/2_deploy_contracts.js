var PlayerScore = artifacts.require("./PlayerScore.sol");
var PuzzleManager = artifacts.require("./PuzzleManager.sol");

module.exports = function(deployer) {
    deployer.deploy(PlayerScore);
    deployer.deploy(PuzzleManager);
};
