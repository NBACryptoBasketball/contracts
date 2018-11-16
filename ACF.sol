pragma solidity 0.4.25;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";


/**
 * Gas optimization:
 * newOrigTrans function call: Previous gas used 268 632 -> now 260 733
 * newRecipTrans function call: Previous gas used 407 728 -> now 393 452
 *
 * Changes:
 * Changed strings to bytes32
 * Marked all public functions as external
 * Marked mapping as private
 * 
 */
 
 /**
 * Contract deployment: Previous gas used 577 114 -> Reduced to 312 550
 * registerNewAsset function call: Previous gas used 137 479 -> Reduced to 133 753
 *
 * Changes:
 * registerNewAsset function marked as external
 * getAssetsCount & getAsset marked as external
 * bytes32 instead of strings
 * 
 */
 
 //Asset Tracking
contract AssetCoreFunctions is Ownable {
    using SafeMath for uint256;

    // Asset Mappings and Struct
    struct NewAsset {
        bytes32 orgName;
        bytes32 fctChain;
        uint hercId;
    }

    mapping (uint => NewAsset) private hercIdToAsset; // assets mapped to user hercId's

    mapping (address => NewAsset[]) private addressToAssetArray;  // Address mapped to AssetArray

    // Creates the NewAsset and adds it to the various Mappings
    function registerNewAsset(bytes32 _orgName, uint _hercId, bytes32 _fctChain) external onlyOwner {

        NewAsset storage asset = hercIdToAsset[_hercId];

        asset.orgName = _orgName;
        asset.hercId = _hercId;
        asset.fctChain = _fctChain;

        addressToAssetArray[msg.sender].push(asset);

    }

    // Returns all assets belonging to msg.sender
    function getAssetsCount() external view onlyOwner returns (uint) {
        return addressToAssetArray[msg.sender].length;
    }

    // Returns single asset based on hercId
    function getAsset(uint _hercIden) external view onlyOwner returns (uint, bytes32, bytes32) {
        return (
            hercIdToAsset[_hercIden].hercId,
            hercIdToAsset[_hercIden].orgName,
            hercIdToAsset[_hercIden].fctChain
        );
    }

// contract AssetMeasure is Ownable {
//     using SafeMath for uint256;
    // originator transaction

// Asset Measure
    struct OrigTrans {
        bytes32 orgName;
        uint hercId;
        bytes32 origTransFctHash;
        bytes32 codeWord;
    }

    // Address mapped to Array of OrigTrans
    mapping (address => OrigTrans[]) private addressToOrigTransArray;

    // Transaction codeWord mapped to OrigTrans
    mapping (bytes32 => OrigTrans) private codeWordToOrigTrans;

   // HercId mapped to array of OrigTrans
    mapping (uint => OrigTrans[]) private hercIdToOrigTrans;

    // Creates the OrigTrans then records it in the various mappings.
    function newOrigTrans(
        bytes32 _orgName,
        uint _hercId,
        bytes32 _codeWord,
        bytes32 _origTransFctHash
    ) external onlyOwner {
        OrigTrans storage origTrans = codeWordToOrigTrans[_codeWord];

        origTrans.orgName = _orgName;
        origTrans.hercId = _hercId;
        origTrans.codeWord = _codeWord;
        origTrans.origTransFctHash = _origTransFctHash;

        addressToOrigTransArray[msg.sender].push(origTrans);

        hercIdToOrigTrans[_hercId].push(origTrans);
    }

    // Get OrigTrans count by Address
    function getOriginTransCountByAddress() external view returns(uint) {
        return addressToOrigTransArray[msg.sender].length;
    }

    // Get Individual OrigTrans with the CodeWord
    function getOriginTransByCodeWord(bytes32 _codeWord) external view returns(bytes32, uint, bytes32, bytes32) {
        return (
            codeWordToOrigTrans[_codeWord].orgName,
            codeWordToOrigTrans[_codeWord].hercId,
            codeWordToOrigTrans[_codeWord].codeWord,
            codeWordToOrigTrans[_codeWord].origTransFctHash
        );
    }

    // Get OrigTrans count by HercId
    function getOriginTransCountByHercId(uint _hercID) external view returns (uint) {
        return hercIdToOrigTrans[_hercID].length;
    }

    // Recipient transaction

    // RecipTrans Struct
    struct RecipTrans {
        uint hercId;
        bytes32 codeWord;
        bytes32 origOrgName;
        bytes32 recipOrgName;
        bytes32 origTransFctHash;
        bytes32 recipTransFctHash;
        bytes32 location;
    }

    // Address mapped to Array of RecipTrans
    mapping (address => RecipTrans[]) private addressToRecipTransArray;

    // CodeWord mapped to RecipTrans
    mapping (bytes32 => RecipTrans) private codeWordToRecipTrans;

    // HercId mapped to Array of RecipTrans
    mapping (uint => RecipTrans[]) private hercIdToRecipTrans;

   // Creates the RecipTrans and adds it to the various mappings
    function newRecipTrans(
        bytes32 _codeWord,
        bytes32 _origOrgName,
        bytes32 _recipOrgName,
        uint _hercId,
        bytes32 _origTransFctHash,
        bytes32 _recipTransFctHash
    ) external onlyOwner {
        RecipTrans storage recipTrans = codeWordToRecipTrans[_codeWord];

        recipTrans.codeWord = _codeWord;
        recipTrans.hercId = _hercId;
        recipTrans.origOrgName = _origOrgName;
        recipTrans.recipOrgName = _recipOrgName;
        recipTrans.origTransFctHash = _origTransFctHash;
        recipTrans.recipTransFctHash = _recipTransFctHash;

        addressToRecipTransArray[msg.sender].push(recipTrans);
        hercIdToRecipTrans[_hercId].push(recipTrans);
    }

     // Get RecipTrans count by Address
    function getRecipTransCountByAddress()  external view returns(uint) {
        return addressToRecipTransArray[msg.sender].length;
    }

    // Get Individual RecipTrans with the CodeWord
    function getRecipTransByCodeWord(bytes32 _codeWord) external view returns (
        bytes32,
        bytes32,
        uint,
        bytes32,
        bytes32,
        bytes32
    ) {
        return (
            codeWordToRecipTrans[_codeWord].origOrgName,
            codeWordToRecipTrans[_codeWord].recipOrgName,
            codeWordToRecipTrans[_codeWord].hercId,
            codeWordToRecipTrans[_codeWord].origTransFctHash,
            codeWordToRecipTrans[_codeWord].recipTransFctHash,
            codeWordToRecipTrans[_codeWord].codeWord
        );
    }

    // Get RecipTrans count by HercId
    function getRecipTransCountByHercId(uint _hercID) external view returns (uint) {
        return hercIdToRecipTrans[_hercID].length;
    }
}