pragma solidity ^0.4.11;


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

import "./Token.sol";

	contract StandardToken is Token {

		function transfer(address _to, uint _value) returns (bool) {
		 //Default assumes totalSupply can't be over max (2*256 - 1).
		 if (balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
			balances[msg.sender] -= _value;
			balances[_to] += _value;
			Transfer(msg.sender, _to, _value);
			return true;
		  } else { return false; }
		}

		 function transferFrom(address _from, address _to, uint _value) returns (bool) {
			if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {	
				balances[_to] += _value;
				balances[_from] -= _value;
				allowed[_from][msg.sender] -= _value;
				Transfer(_from, _to, _value);
				return true;
			 } else { return false; }
		 }

		  function balanceOf(address _owner) constant returns (uint) {
			return balances[_owner];
		  }
pragma solidity ^0.4.11;


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

import "./Token.sol";

	contract StandardToken is Token {

		function transfer(address _to, uint _value) returns (bool) {
		 //Default assumes totalSupply can't be over max (2*256 - 1).
		 if (balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
			balances[msg.sender] -= _value;
			balances[_to] += _value;
			Transfer(msg.sender, _to, _value);
			return true;
		  } else { return false; }
		}

		 function transferFrom(address _from, address _to, uint _value) returns (bool) {
			if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {	
				balances[_to] += _value;
				balances[_from] -= _value;
				allowed[_from][msg.sender] -= _value;
				Transfer(_from, _to, _value);
				return true;
			 } else { return false; }
		 }

		  function balanceOf(address _owner) constant returns (uint) {
			return balances[_owner];
		  }

		  function approve(address _spender, uint _value) returns (bool) {
			allowed[msg.sender][_spender] = value;
			Approval(msg.sender, _spender, _value);
			return true;
		  }

		  function allowance(address _owner, address _spender) constant returns (uint) {
			return allowed[_owner][_spender];
		  }

		  mapping (address => uint) balances;
		  mapping (address => mapping (address => uint)) allowed;
		  uint public totalSupply;
	}		

		  function approve(address _spender, uint _value) returns (bool) {
			allowed[msg.sender][_spender] = value;
			Approval(msg.sender, _spender, _value);
			return true;
		  }

		  function allowance(address _owner, address _spender) constant returns (uint) {
			return allowed[_owner][_spender];
		  }

		  mapping (address => uint) balances;
		  mapping (address => mapping (address => uint)) allowed;
		  uint public totalSupply;
	}		
