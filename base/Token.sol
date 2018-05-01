pragma soidity 0.4.11;

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

contract Token {
	
	function totalSupply() constant returns (uint supply) {}

	function balanceOf(address _owner) constant returns (uint balance) {}
	
	function transfer(address _to, uint _value) returns (bool success) {}
	
	function transferFrom(address _from, address _to, uint _value) returns (bool success) {}

	function approve(address _spender, uint _value) returns (bool success) {}

	function allowance(address _owner, address _spender) constant returns (uint remaining) {}

	event Transfer(address indexed _from, address indexed _to, uint _value);
	event Approval(address indexed _owner, address indexed _spender, uint _value);

}
