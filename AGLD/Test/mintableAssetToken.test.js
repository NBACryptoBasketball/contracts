const { shouldBehaveLikemintableAssetToken } = require('./mintableAssetToken.behavior');
const mintableAssetToken = artifacts.require('mintableAssetToken');

contract('mintableAssetToken', function ([_, owner, ...otherAccounts]) {
  beforeEach(async function () {
    this.token = await mintableAssetToken.new({ from: owner });
  });

  shouldBehaveLikemintableAssetToken(owner, owner, otherAccounts);
});
