pragma solidity 0.4.24;
//pragma solidity ^0.4.25;
//pragma experimental ABIEncoderV2;

//import "./base/Ownable.sol";

import "./herc/herc20.sol";

// A contract to manage players' top scores.
contract PlayerScore is Ownable
{
    // Represents the maximum amount of
    // stored top scores.
    uint constant m_maxScores = 100;
    
    // Represents the player-score entry.
    struct Score
    {
        address player;
        int score;
    }

    // WARNING! UNSECURE OLD NOT USED - todo: review, cleanup & remove [
    
    /// <summary>
    /// Most relevant scores stored in this contract.
    /// </summary>
    Score[] public TopScores;
    
    // Maps each player with its own score.
    mapping(address=>int) public Scores;

    mapping(address=>int)[] public Scores1;
    
    /// <summary>
    /// Sets the score for current sender.
    /// If no score exists, a new one is created.
    /// </summary>
    function SetScore(int score) public
    {
        int currentScore = Scores[msg.sender];
        
        // Replace the old score with the new one
        // if it is higher.
        if(currentScore < score)
        {
            Scores[msg.sender] = score;
        }
        
        // Now we populate the top scores array.
        if(TopScores.length < m_maxScores)
        {
            // If we didn't reach yet the maximum stored
            // scores amount, we simply add the new entry.
            Score memory newScore = Score(msg.sender, score);
            TopScores.push(newScore);
        }
        else
        {
            // If we reached the maximum stored scores amount,
            // we have to verify if the new received score is
            // higher than the lowest one in the top scores array.
            int lowestScore = TopScores[0].score;
            uint lowestScoreIndex = 0;
            
            // We search for the lowest stored score.
            for(uint i = 1; i < TopScores.length; i++)
            {
                Score memory current = TopScores[i];
                if(lowestScore > current.score)
                {
                    lowestScore = current.score;
                    lowestScoreIndex = i;
                }
            }
            
            // Now we can check our new pushed score against
            // the lowest one.
            if(lowestScore < score)
            {
                Score memory newScoreToReplace = Score(msg.sender, score);
                TopScores[lowestScoreIndex] = newScoreToReplace;
            }
        }
    }
    
    /// <summary>
    /// Get the amount of top scores.
    /// </summary>
    function GetTopScoresCount() view public returns (uint)
    {
        return TopScores.length;
    }

    // WARNING! UNSECURE OLD NOT USED - todo: review, cleanup & remove ]

    function GetTopScoresMax() view public returns (uint)
    {
        return m_maxScores;
    }

    // SECURE [

//    uint private BaseIndexSecure = 0;
//    uint private TopScoresSecureCount = 0;

//    Score[] public TopScoresSecure;

    uint[] private BaseIndexSecure1;
    uint[] private TopScoresSecureCount1;
    Score[][] public TopScoresSecure1;

    function GetTopScoresSecureCount(uint gameId) view public returns (uint)
    {
        return TopScoresSecureCount1[gameId];
    }

    function getTopPlayerAddress(uint gameId, uint index) view public returns (address) {
        return TopScoresSecure1[gameId][BaseIndexSecure1[gameId] + index].player;
    }

    function getTopPlayerScore(uint gameId, uint index) view public returns (int) {
        return TopScoresSecure1[gameId][BaseIndexSecure1[gameId] + index].score;
    }

    function SetScoreSecure(uint gameId, address player, int score) 
        public
        onlyOwner
    {
        int currentScore = Scores1[gameId][player];
        
        // Replace the old score with the new one
        // if it is higher.
        if(currentScore < score)
        {
            Scores1[gameId][player] = score;
        }
        
        // Now we populate the top scores array.
        if(TopScoresSecureCount1[gameId] < m_maxScores)
        {
            // If we didn't reach yet the maximum stored
            // scores amount, we simply add the new entry.
            Score memory newScore = Score(player, score);
            TopScoresSecure1[gameId].push(newScore);
            TopScoresSecureCount1[gameId]++;
        }
        else
        {
            // If we reached the maximum stored scores amount,
            // we have to verify if the new received score is
            // higher than the lowest one in the top scores array.
            int lowestScore = TopScoresSecure1[gameId][0].score;
            uint lowestScoreIndex = 0;
            
            // We search for the lowest stored score.
            for(uint i = 1; i < TopScoresSecureCount1[gameId]; i++)
            {
                Score memory current = TopScoresSecure1[gameId][i];
                if(lowestScore > current.score)
                {
                    lowestScore = current.score;
                    lowestScoreIndex = i;
                }
            }
            
            // Now we can check our new pushed score against
            // the lowest one.
            if(lowestScore < score)
            {
                Score memory newScoreToReplace = Score(player, score);
                TopScoresSecure1[gameId][lowestScoreIndex] = newScoreToReplace;
            }
        }
    }
/*
    function uintToString(uint v) public view returns (string)
    {
        uint maxlength = 100;
        bytes memory reversed = new bytes(maxlength);
        uint i = 0;
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[i++] = byte(48 + remainder);
        }
        bytes memory s = new bytes(i + 1);
        for (uint j = 0; j <= i; j++) {
            s[j] = reversed[i - j];
        }
        return string(s);
    }
*/

    // 0.5 Compiler Version:
/*
    function uintToString(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }
*/
    //Pre 0.5 Compiler Version:

    function uintToString(uint i) internal view returns (string)
    {
        if (i == 0) return "0";
        uint j = i;
        uint length;
        while (j != 0){
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint k = length - 1;
        while (i != 0){
            bstr[k--] = byte(48 + i % 10);
            i /= 10;
        }
        return string(bstr);
    }

    function addressToString(address _addr) public view returns(string) {
        bytes32 value = bytes32(uint256(_addr));
        bytes memory alphabet = "0123456789abcdef";

        bytes memory str = new bytes(42);
        str[0] = "0";
        str[1] = "x";
        for (uint i = 0; i < 20; i++) {
            str[2+i*2] = alphabet[uint(value[i + 12] >> 4)];
            str[3+i*2] = alphabet[uint(value[i + 12] & 0x0f)];
        }
        return string(str);
    }
/*
    function debugS1(address player) public view returns (string) {
        string memory s1 = addressToString(player);
        return s1;
    }

    function debugS2(uint score) public view returns (string) {
        string memory s2 = uintToString(score);
        return s2;
    }

    function debugS3(string s1, string s2, string metrics) view public returns (string) {
        string memory smsg = string(abi.encodePacked(s1, s2, metrics, "", ""));
        return smsg;
    }

    function debugS4(string s1, string s2, string metrics) view public returns (bytes32) {
        string memory smsg = string(abi.encodePacked(s1, s2, metrics, "", ""));
        bytes32 h = keccak256(bytes(smsg));
        return h;
    }
    function debugS5(string s1, string s2, string metrics) view public returns (bytes32) {
        string memory smsg = string(abi.encodePacked(s1, s2, metrics, "", ""));
        bytes32 h = keccak256(bytes(smsg));
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
        bytes32 prefixedHash = keccak256(abi.encodePacked(prefix, h));
        return prefixedHash;
    }
*/
    function verifySign(string smsg, uint8 v, bytes32 r, bytes32 s) public view returns (address) {
        bytes32 h = keccak256(bytes(smsg));
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
//        bytes32 prefixedHash = keccak256(prefix, h);
//        bytes32 prefixedHash = sign(keccak256("\x19Ethereum Signed Message:\n" + len(smsg) + smsg));
        bytes32 prefixedHash = keccak256(abi.encodePacked(prefix, h));
        address addr = ecrecover(prefixedHash, v, r, s);        
        return addr;
    }
/*
    function verifySignH(bytes32 h, uint8 v, bytes32 r, bytes32 s) public view returns (address) {
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
        bytes32 prefixedHash = keccak256(abi.encodePacked(prefix, h));
        address addr = ecrecover(prefixedHash, v, r, s);
        return addr;
    }

    function verifySignNoPrefix(string smsg, uint8 v, bytes32 r, bytes32 s) public view returns (address) {
        bytes32 h = keccak256(bytes(smsg));
        address addr = ecrecover(h, v, r, s);
        return addr;
    }

    function verifySignNoPrefixH(bytes32 h, uint8 v, bytes32 r, bytes32 s) public view returns (address) {
        address addr = ecrecover(h, v, r, s);
        return addr;
    }
*/
    function SetScoreSecureSign(uint gameId, address player, int score, string metrics, uint8 v, bytes32 r, bytes32 s) 
        public
    {
//        address player = msg.sender;

        // Make string [
        // format: 0xPLAYER SCORE METRICS

        string memory s1 = addressToString(player);
        string memory s2 = uintToString(uint(score));
//        string memory smsg = string(abi.encodePacked(s1, s2, metrics, "", ""));
        string memory smsg = string(abi.encodePacked(s1, s2, metrics, "", ""));

        address addr = verifySign(smsg, v, r, s);
/*
        bytes32 h = keccak256(bytes(smsg));

        // Make string [
        // Verify signature [

        bytes memory prefix = "\x19Ethereum Signed Message:\n32";

//        bytes32 prefixedHash = sha3(prefix, h);
//        bytes32 prefixedHash = sign(keccak256("\x19Ethereum Signed Message:\n" + len(smsg) + smsg));
        bytes32 prefixedHash = keccak256(abi.encodePacked(prefix, h));

        address addr = ecrecover(prefixedHash, v, r, s);
*/

        require(addr == owner(), "check signature fail");

        // Verify signature ]

        SetScoreSecureSignInternal(gameId, player, score);
    }

    function SetScoreSecureSignInternal(uint gameId, address player, int score) 
        internal
    {
        int currentScore = Scores1[gameId][player];
        
        // Replace the old score with the new one
        // if it is higher.
        if(currentScore < score)
        {
            Scores1[gameId][player] = score;
        }
        
        // Now we populate the top scores array.
        if(TopScoresSecureCount1[gameId] < m_maxScores)
        {
            // If we didn't reach yet the maximum stored
            // scores amount, we simply add the new entry.
            Score memory newScore = Score(player, score);
            TopScoresSecure1[gameId].push(newScore);
            TopScoresSecureCount1[gameId]++;
        }
        else
        {
            // If we reached the maximum stored scores amount,
            // we have to verify if the new received score is
            // higher than the lowest one in the top scores array.
            int lowestScore = TopScoresSecure1[gameId][BaseIndexSecure1[gameId] + 0].score;
            uint lowestScoreIndex = BaseIndexSecure1[gameId] + 0;
            
            // We search for the lowest stored score.
            for(uint i = 1; i < TopScoresSecureCount1[gameId]; i++)
            {
                Score memory current = TopScoresSecure1[gameId][BaseIndexSecure1[gameId] + i];
                if(lowestScore > current.score)
                {
                    lowestScore = current.score;
                    lowestScoreIndex = i;
                }
            }
            
            // Now we can check our new pushed score against
            // the lowest one.
            if(lowestScore < score)
            {
                Score memory newScoreToReplace = Score(player, score);
                TopScoresSecure1[gameId][BaseIndexSecure1[gameId] + lowestScoreIndex] = newScoreToReplace;
            }
        }
    }
    // SECURE ]

    // PAYOUT LOGIC [

    // CONFIGURE PAYOUTS [

    address public hercContract;
    address public payoutBoss;
    uint[m_maxScores] public winnerReward;

    function SetHERCTokenAddress(address hercContract_)
        public
        onlyOwner
    {
        hercContract = hercContract_;
    }

    function SetPayoutAddress(address boss)
        public
        onlyOwner
    {
        payoutBoss = boss;
    }

    function SetWinnerReward(uint rank, uint reward)
        public
        onlyOwner
    {
        winnerReward[rank] = reward;
    }

    // CONFIGURE PAYOUTS ]
    // SEASON DATE [

    uint public startDate;
    uint public releaseDate;
    uint public seasonInterval=9;
    uint public lastWipeDate=9;

    function SetNextSeasonReleaseDate(uint startDate_, uint releaseDate_)
        public
        onlyOwner
    {
        startDate = startDate_;
        releaseDate = releaseDate_;
    }

    function SetSeasonInterval(uint interval)
        public
        onlyOwner
    {
        seasonInterval = interval;
//        lastWipeDate = interval;
    }

    function IsSeasonOver()
        public
        view
        returns(bool)
    {
        return (now >= releaseDate);
    }

    // SEASON DATE ]
    // SEASON PAYOUT [

    function PayoutToWinners(uint gameId)
        public
        onlyOwner
    {
        require (IsSeasonOver(), "Season in progress");

        // update season
        SetNextSeasonReleaseDate(releaseDate, releaseDate + seasonInterval);

        // move scores to memory for sort and progress
        uint count = GetTopScoresSecureCount(gameId);

        Score[] memory scores = new Score[](count);

        uint i;
        for (i = 0; i < count; i++) {
            Score memory score = TopScoresSecure1[gameId][i];
            //scores.push(score);
            scores[i] = score;
        }
        
        sortScores(scores);

        // clean up scores for prevet double spent
        //WipeScores();

        for (i = 0; i < count; i++) {
            payoutScore(scores[i].player, i);
        }
    }

    event WinnerPayout(address player, uint rank, uint reward);

    function payoutScore(address player, uint rank)
        internal
        onlyOwner
    {
        uint reward = winnerReward[rank];

        HERCToken(hercContract).approve(player, reward);
//        HERCToken(hercContract).approve(payoutBoss, reward);

//        HERCToken(hercContract).transferFrom(payoutBoss, player, reward);

        emit WinnerPayout(player, rank, reward);
    }

    function WipeScores(uint gameId)
        public
        onlyOwner
    {
        lastWipeDate = now;
//        TopScores.length = 0;
//        BaseIndexSecure += TopScoresSecureCount; //TopScoresSecure.length;
        BaseIndexSecure1[gameId] = TopScoresSecure1[gameId].length;
        TopScoresSecureCount1[gameId] = 0;
    }

    // SEASON PAYOUT ]
    // UTILS [

    function sortScores(Score[] memory scores)
        internal
    {
        uint l = scores.length;
        for(uint i = 0; i < l; i++) {
            for(uint j = i+1; j < l ;j++) {
                if(scores[i].score > scores[j].score) {
                    Score memory temp = scores[i];
                    scores[i] = scores[j];
                    scores[j] = temp;
                }
            }
        }
    }

    // UTILS ]
    // PAYOUT LOGIC ]
}
