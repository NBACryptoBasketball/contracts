var herc20 = artifacts.require("HERCToken");

module.exports = function(deployer) {
    deployer.deploy(herc20);
};
