/*Copyright (c) 2018 HERC SEZC

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

pragma solidity ^0.4.19;
    
import "./Ownable.sol";
import "./SafeMath.sol";
import "./HERCToken.sol";

contract AssetCoreFunctions is Ownable, HERCToken {
   
    using SafeMath for uint256;
// When a new asset is registered records a mapping of 
// msg.sender to new Asset 

    event NewAssetRegisterd(); //thinking should be hercID, assetId, 
    // event NewTransactionCreated(uint, string, string);
    
    struct Asset {
        string _assetName;
        string _organizationName;
        uint _fctHash;
        uint _hercId;
    }
    
    address user = msg.sender;  // this will be the user id
        
    mapping (address => Asset) userAssets; // assets mapped to user addresses
    mapping (uint => address) assetOwners; // links herc ID to address

   
//    function  registerNewAsset(
//         string assetName,
//         string organizationName,
//         uint fctHash,
//         uint hercId
//         ) public 
//         onlyOwner
//         {
       
//         uint _assetId = ownerAssetCount[msg.sender]++;
        
//         assets[user] = (Asset(assetName, organizationName, fctHash, hercId));
        
//         assetOwners[hercId] = msg.sender;
      
//     }

    address public hercContract = 0xC443f11CfA23C1b5a098a46ceFb76cc998089a46; //will be herc Contract Address
    address public user = msg.sender;
    uint newAssetFee = 10000;
    uint viewerFee; 
    uint transactionFee; 
   
    modifier validValue {
        assert(msg.value <= balanceOf(msg.sender));
        _;
    }
   
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

    function transfer (uint _value) onlyOwner validValue
        public
        returns (bool) {
        return transfer(hercContract, _value);
    }
   
    function registerNewAsset() onlyOwner validValue public {
        transfer(hercContract, newAssetFee); 
    }
    
    function assetTransactionFee(uint _transCost) onlyOwner validValue public {
        transfer(hercContract, _transCost);
    }




    // function _getAsset(uint id) public constant returns(uint, string, string) {
    //     return (assets[id].id, assets[id].name, assets[id].manufacturer);
    // }

    //  struct Transaction {
    //     // perhaps implement lat and long in addition or instead of strings
    //     uint transactionId;    
    //     address to;    
    //     string origin;
    //     string destination;
    //     uint startDate;
    //     bool error;

    // }
    
    // function _startTransaction(
       
    //     address _to,
    //     string _origin,
    //     string _destination,
    //     uint _startDate,
    //     bool _error
    //     )
    // public
    // isRecipient(_to) {   
    //     uint _transId = ownerTransactionCount[msg.sender]++;
    //     transactions[_transId] = (Transaction(_transId, _to, _origin, _destination, _startDate, _error));
    //     transactionOwners[_transId] = msg.sender;
        
        
    //     emit NewTransactionCreated(_transId, _origin, _destination);
    // }

    // function _getTransaction(uint id) public constant  returns(uint, string, string, uint){
    //     return (transactions[id].transactionId, transactions[id].origin, transactions[id].destination, transactions[id].startDate);
    // }



}
