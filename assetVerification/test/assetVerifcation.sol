pragma solidity ^0.4.19;

/*

  Copyright 2017 HERC SEZC

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

*/

import "../SafeMath.sol";
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";


contract assetVerification {

	uint[] public originArr;
	uint[] public expectedArr;

        function get() originArr public constant returns (uint[]) {
         return originArr;
        }

	function assetVerification(uint[] _initArr) public {
	 for (uint i=0; i < _initArr.length; i++) {
	    originArr.push(_initArr[i]);
	}

	uint a = 1;
	uint b = 2;
	Assert.equal(a, b, "pass");

	Assert.equal(expectedArr[0], assetVerification.originArr[0], "pass");
	Assert.equal(expectedArr[1], assetVerification.originArr[1], "pass");
	Assert.equal(expectedArr[2], assetVerification.originArr[2], "pass");
	Assert.equal(expectedArr[3], assetVerification.originArr[3], "pass");
	Assert.equal(expectedArr[4], assetVerification.originArr[4], "pass");
	Assert.equal(expectedArr[5], assetVerification.originArr[5], "pass");
	Assert.equal(expectedArr[6], assetVerification.originArr[6], "pass");
	Assert.equal(expectedArr[7], assetVerification.originArr[7], "pass");
	}
}
