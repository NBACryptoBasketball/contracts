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

pragma solidity ^ 0.4.23;

import "/./assetTracking/contracts/assetCoreFunctions.sol"
import "/./assetVerification/contracts/assetVerification.sol"
import "/./herc-erc777-token/contracts/HERCTokenERC777.sol"
import "/./contracts/AGLD/Mintable.sol"

contract MintableAssetToken is assetCoreFunctions, assetVerification, HERCTokenERC777, Mintable  {

  using SafeMath for unit256;
  
   event MintNewAssetToken(uint, string, string); //thinking should be hercID, assetId, 
//to be refractored 82018
    event NewTransactionCreated(uint, string, string);
    
    // event AssetCreate(address account, string uuid, string manufacturer);
    // event RejectCreate(address account, string uuid, string message);
    // event AssetTransfer(address from, address to, string uuid);
    // event RejectTransfer(address from, address to, string uuid, string message);
    
uint _hercId; // this will be the asset id
    
    Asset _newAsset;
    Transaction _newTrans;
    address _newReceiver;

    // Asset[] public assets;
    
    // Transaction[] public transactions;
    
    mapping (uint => Asset) assets; //  links _Id to asset, starting with a single but will be an array in the future
    mapping (uint => Transaction) transactions;
    
    mapping (uint => address) assetOwners; // links herc Id to eth address owner
    mapping (uint => address) transactionOwners; // txid to address
    mapping (address => uint) ownerAssetCount; // hercId mapped to asset arrays
    mapping (address => uint) ownerTransactionCount; // id to Transaction

    mapping (address => mapping(address => bool)) recipientList;    


    modifier isRecipient(address newReceiver) {
        require(recipientList[msg.sender][newReceiver]);
        _;
    }
   
    function addRecipient(address receiver) public onlyOwner returns(bool) {
        
        return recipientList[msg.sender][receiver] = true;
    }

    struct Asset {

        string name;
        string description;
        string manufacturer;
        uint id;
        uint createdOn;
        address owner;
        bool exists;
        mapping(address => bool) recpientList;
        // uint[] components; // not needed currently
        }
        
   
   
   function  _createAsset(
        string _name,
        string _description,
        string _manufacturer,
        uint _createdOn,
        address _owner
        // bool _exists useful in the future
        
        ) public 
        onlyOwner
        {
       
        uint _assetId = ownerAssetCount[msg.sender]++;
        
        assets[_assetId] = (Asset(_name, _description, _manufacturer, _assetId, _createdOn, _owner, true));
        
        assetOwners[_assetId] = msg.sender;
        
        

        emit NewAssetCreate (_assetId, assets[_assetId].name, assets[_assetId].manufacturer); 
      
    }

    function _getAsset(uint id) public constant returns(uint, string, string) {
        return (assets[id].id, assets[id].name, assets[id].manufacturer);
    }

     struct Transaction {
        // perhaps implement lat and long in addition or instead of strings
        uint transactionId;    
        address to;    
        string origin;
        string destination;
        uint startDate;
        bool error;

    }
    
    function _startTransaction(
       
        address _to,
        string _origin,
        string _destination,
        uint _startDate,
        bool _error
        )
    public
    isRecipient(_to) {   
        uint _transId = ownerTransactionCount[msg.sender]++;
        transactions[_transId] = (Transaction(_transId, _to, _origin, _destination, _startDate, _error));
        transactionOwners[_transId] = msg.sender;
        
        
        emit NewTransactionCreated(_transId, _origin, _destination);
    }

    function _getTransaction(uint id) public constant  returns(uint, string, string, uint){
        return (transactions[id].transactionId, transactions[id].origin, transactions[id].destination, transactions[id].startDate);
    }

contract MintableToken is StandardToken, Ownable {
  event Mint(address indexed to, uint256 amount);
  event MintFinished();

  bool public mintingFinished = false;


  modifier canMint() {
    require(!mintingFinished);
    _;
  }

  modifier hasMintPermission() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Function to mint tokens
   * @param _to The address that will receive the minted tokens.
   * @param _amount The amount of tokens to mint.
   * @return A boolean that indicates if the operation was successful.
   */
  function mint(
    address _to,
    uint256 _amount
  )
    public
    hasMintPermission
    canMint
    returns (bool)
  {
    _mint(_to, _amount);
    emit Mint(_to, _amount);
    return true;
  }

  /**
   * @dev Function to stop minting new tokens.
   * @return True if the operation was successful.
   */
  function finishMinting() public onlyOwner canMint returns (bool) {
    mintingFinished = true;
    emit MintFinished();
    return true;
  }
}

}
