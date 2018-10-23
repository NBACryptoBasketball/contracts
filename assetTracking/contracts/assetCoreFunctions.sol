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


// I had difficulty importing the Herc777 contract(s), I believe the functionality I need can be found in Token.sol

pragma solidity ^0.4.19;
    import "./Ownable.sol";
    import "./SafeMath.sol";
    import "./HERCToken.sol";
  
contract AssetCoreFunction is Ownable, HERCToken {

    using SafeMath for uint256;
    
    address public hercContract = 0xC443f11CfA23C1b5a098a46ceFb76cc998089a46; //will be herc Contract Address
   
    address public user = msg.sender;
   
    uint newAssetFee = 10000;
    uint viewerFee = 0x20; 
    // uint transactionFee; 
    
    event NewAssetRegistered(string _organizationName, uint _hercId, uint _fctHash); 
   
    event OriginatorTransactionCreated(string _organizationName, uint hercId, uint _fctHash);
   
    event ReceivingTransactionCreated(string _organizationName, uint hercId, uint _fctHash);
    
    
// When a new asset is registered a mapping of 
// the newAsset to msg.sender occurs 
    
    // Asset mappings
    mapping (address => NewAsset) assetAddresses; // assets mapped to user addresses
    address[] public assetAccounts; // Array of address with assets
 
    struct NewAsset {
        uint fctHash;
        uint hercId;
    }
    
    function registerNewAsset(address _address, uint _hercId, uint _fctHash) onlyOwner public payable {
        NewAsset storage asset = assetAddresses[_address];
        
        asset.hercId =_hercId;
        asset.fctHash =_fctHash;
        
         assetAccounts.push(_address) -1;
         transfer(hercContract, newAssetFee);
    }
    
    function getAssets() view public returns(address[]){
        return assetAccounts;
    }
    
    function getAsset(address _address) view public returns(uint) {
         return assetAddresses[_address].hercId;
    }
    
    function countAssets() view public returns (uint) {
        return assetAccounts.length;
    }

   // Transaction mappings
    mapping (address => OrigTrans) origTransAdresses;
    address[] public origTransAccounts;

  // originator transaction
   struct OrigTrans { 
       string orgName;
       uint hercId;
       uint fctHash;
    }

    function newOrigTrans(address _address, uint _transCost, uint _hercId, uint _fctHash, string _orgName) onlyOwner validValue public payable {
        OrigTrans storage origTrans = origTransAdresses[_address];
        origTrans.orgName   
        origTrans.hercId = _hercId;
        origTrans.fctHash = fctHash;
        origTransAccounts[_addres] = origTrans;
        transfer(hercContract, _transCost);
    }
   
   // recipient transaction
  struct RecipTrans {
        address recipAddress;
        string origOrgName;
        string recipOrgName;
        uint hercId;
        uint origTransFctHash;
        uint recipTransFctHash;
   }

   function newRecipTrans(
        address _address,
        string _origOrgName,
        string _recipOrgName,
        uint _hercId,
        uint _origTransFctHash,
        uint _recipTransFctHash,
        uint _transCost

        ) onlyOwner public payable {
    
        RecipTrans storage recipTrans = recipTransAdresses[_address];
        
        recipTrans.origOrgName = _origOrgName;
        recipTrans.recipOrgName = _recipOrgName;
        recipTrans.hercId = _hercId;
        recipTrans.origTransFctHash = _origTransFctHash;
        recipTrans.recipTransFctHash = _recipTransFctHash;
        
        // recipTransAdresses[_address] = recipTrans;
        recipTransAccounts.push(_address);
        transfer(hercContract, _transCost);
    }
// need something to attach the orig transactions to the recip trans, probably need to discuss further

    

    function getAllOriginTrans() view public returns(address[]){
        return origTransAccounts;
    }
    
    function getSingleOriginTrans(address _address) view public returns (uint) {
         return origTransAccounts[_address].hercId;
    }
    
    function countOriginTrans() view public returns (uint) {
        return origTransAccounts.length;
    }





    function getAllRecipientTrans() view public returns(address[]){
        return recipTransAccounts;
    }
    
    function getSingleRecipientTrans(address _address) view public returns (uint) {
         return recipTransAccounts[_address].hercId;
    }
    
    function countRecipientTrans() view public returns (uint) {
        return recipTransAccounts.length;
    }


// Function structs and mappings for getting the validated transactions from the HIPR smart Contracts

    mapping (address => ValidatedTransaction) validatedTransAdresses;
    address[] public validatedTransAccounts;
    
    struct ValidatedTransaction {
        // address recipAddress;
        string origOrgName;
        string recipOrgName;
        uint hercId;
        uint origTransFctHash;
        uint recipTransFctHash;
    }


// unsure about what entity should commit the validated transactions
function addValidatedTransaction(
     
        string _origOrgName,
        string _recipOrgName,
        uint _hercId,
        uint _origTransFctHash,
        uint _recipTransFctHash
    
    ) public
    {
        ValidatedTransaction storage validatedTransaction = validatedTransAdresses[_address];
        
        validatedTransaction.origOrgName = _origOrgName;
        validatedTransaction.recipOrgName = _recipOrgName;
        validatedTransaction.hercId = _hercId;
        validatedTransaction.origTransFctHash = _origTransFctHash;
        validatedTransaction.recipTransFctHash = _recipTransFctHash;
        
        // validatedTransactionAdresses[_address] = validatedTransaction;
        validatedTransactionAccounts.push(_address);
        // transfer(hercContract, _transCost);
    }
    }


    function getAllValidatedTrans() view public returns(address[]){
        return validatedTransAccounts;
    }
    
    function getSingleValidatedTrans(address _address) view public returns (uint) {
         return recipTransAdresses[_address].hercId;
    }
    
    function countValidatedTrans() view public returns (uint) {
        return recipTransAccounts.length;
    }




    // FOR CHANGES
    // function setTo(address _hercContract) public {
    //     hercContract = _hercContract;
    // }
     
     // FOR CHANGES
    // function setNewAssetFee(uint _newAssetFee) public {
    //     newAssetFee = _newAssetFee;
    // }
    
    // FOR CHANGES
    // function setViewerFee(uint _viewerFee) public {
    //     viewerFee = _viewerFee;
    // }

    
   
    
    

}