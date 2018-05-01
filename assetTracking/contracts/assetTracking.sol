pragma solidity ^0.4.18;	

   
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

import "./SafeMath.sol";

contract AssetTracking {
	string id;

	function setId(string serial) public {
		id = serial;
	}

	function getId() public constant returns (string) {
		return id;
	}
struct Asset {
	string name;
	string firstMetric;
	string secondMetric;
	string thirdMetric;
	string fourthMetric;
	string fifthMetric;
	string sixthMetric;
	string seventhMetric;
	string eigthMetric;
	string manufacturer;
	bool initialized;
}
}
