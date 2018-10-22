/*
Copyright (c) 2018 HERC SEZC

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
pragma solidity ^0.4.0;

import "./Ownable.sol";
import "./SafeMath.sol";
import "../../herc-erc777-token/contracts/ERC777/ERC20Token.sol";

contract AssetFees is Ownable, ERC20Token {
  using SafeMath for uint256;

    // herc contract ropsten address 0xC443f11CfA23C1b5a098a46ceFb76cc998089a46 
    address public hercContract = 0xC443f11CfA23C1b5a098a46ceFb76cc998089a46; //will be herc Contract Address
    address public user = msg.sender;
    uint newAssetFee = 10000;
    uint viewerFee; 
    uint transactionFee; 
   
    // FOR CHANGES
    function setTo(address _hercContract) public {
        hercContract = _hercContract;
    }
     
     // FOR CHANGES
    function setChainFee(uint _chainFee) public {
        newAssetFee = _chainFee;
    }
    
    // Still Unsure what this is value is
    function setViewerFee(uint _viewerFee) public {
        viewerFee = _viewerFee;
    }

 function transfer(uint _value)
        public
        returns (bool) {
        return transfer(hercContract, _value);
    }
   
    modifier validValue {
        assert(msg.value <= balanceOf(msg.sender));
        _;
    }


    function registerNewAsset()  validValue public {
        transfer(hercContract, 7); 
    }
    
    
    function assetTransactionFee(uint _transCost) isOwner validValue public {
        transfer(hercContract, _transCost);
    }
   
    // function digitalViewer() payable onlyOwner validValue public {
        
    //     transfer(_to, viewerFee);
    // }
    
    // Not sure we'll need to use this
    //
    // function hiprWin() payable onlyOwner validValue public {
    //  transfer(_to, hiprFee);
    // }
 }