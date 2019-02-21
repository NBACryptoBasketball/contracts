pragma solidity 0.4.24;
//pragma solidity ^0.4.25;

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

    uint TopScoresSecureCount = 0;

    Score[] public TopScoresSecure;

    function GetTopScoresSecureCount() view public returns (uint)
    {
        return TopScoresSecureCount;
    }

    function SetScoreSecure(address player, int score) 
        public
        onlyOwner
    {
        int currentScore = Scores[player];
        
        // Replace the old score with the new one
        // if it is higher.
        if(currentScore < score)
        {
            Scores[player] = score;
        }
        
        // Now we populate the top scores array.
        if(TopScoresSecureCount < m_maxScores)
        {
            // If we didn't reach yet the maximum stored
            // scores amount, we simply add the new entry.
            Score memory newScore = Score(player, score);
            TopScoresSecure.push(newScore);
            TopScoresSecureCount++;
        }
        else
        {
            // If we reached the maximum stored scores amount,
            // we have to verify if the new received score is
            // higher than the lowest one in the top scores array.
            int lowestScore = TopScoresSecure[0].score;
            uint lowestScoreIndex = 0;
            
            // We search for the lowest stored score.
            for(uint i = 1; i < TopScoresSecureCount; i++)
            {
                Score memory current = TopScoresSecure[i];
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
                TopScoresSecure[lowestScoreIndex] = newScoreToReplace;
            }
        }
    }

    function uintToString(uint v) public returns (string)
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

    function addressToString(address x) public returns (string) 
    {
        bytes memory b = new bytes(20);
        for (uint i = 0; i < 20; i++)
            b[i] = byte(uint8(uint(x) / (2**(8*(19 - i)))));
        return string(b);
    }

    function debugS1(address player) public returns (string) {
        string memory s1 = addressToString(player);
        return s1;
    }

    function debugS2(uint score) public returns (string) {
        string memory s2 = uintToString(score);
        return s2;
    }

    function debugS3(string s1, string s2, string metrics) public returns (string) {
        string memory smsg = string(abi.encodePacked(s1, s2, metrics, "", ""));
        return smsg;
    }

    function verifySign(string smsg, uint8 v, bytes32 r, bytes32 s) public returns (address) {
        bytes32 h = keccak256(bytes(smsg));
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
//        bytes32 prefixedHash = keccak256(prefix, h);
//        bytes32 prefixedHash = sign(keccak256("\x19Ethereum Signed Message:\n" + len(smsg) + smsg));
        bytes32 prefixedHash = keccak256(abi.encodePacked(prefix, h));
        address addr = ecrecover(prefixedHash, v, r, s);        
        return addr;
    }

    function SetScoreSecureSign(address player, int score, string metrics, uint8 v, bytes32 r, bytes32 s) 
        public
    {
//        address player = msg.sender;

        // Make string [
        // format: 0xPLAYER SCORE METRICS
/*
        string memory s1 = addressToString(player);
        string memory s2 = uintToString(uint(score));
//        string memory smsg = string(abi.encodePacked(s1, s2, metrics, "", ""));
        string memory smsg = string(abi.encodePacked(s1, s2, metrics, "", ""));

        address addr = verifySign(smsg, v, r, s);*/
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
/*
        require(addr == owner(), "check signature fail");

        // Verify signature ]

        SetScoreSecureSignInternal(player, score);
        */
    }

    function SetScoreSecureSignInternal(address player, int score) 
        internal
    {
        int currentScore = Scores[player];
        
        // Replace the old score with the new one
        // if it is higher.
        if(currentScore < score)
        {
            Scores[player] = score;
        }
        
        // Now we populate the top scores array.
        if(TopScoresSecureCount < m_maxScores)
        {
            // If we didn't reach yet the maximum stored
            // scores amount, we simply add the new entry.
            Score memory newScore = Score(player, score);
            TopScoresSecure.push(newScore);
            TopScoresSecureCount++;
        }
        else
        {
            // If we reached the maximum stored scores amount,
            // we have to verify if the new received score is
            // higher than the lowest one in the top scores array.
            int lowestScore = TopScoresSecure[0].score;
            uint lowestScoreIndex = 0;
            
            // We search for the lowest stored score.
            for(uint i = 1; i < TopScoresSecureCount; i++)
            {
                Score memory current = TopScoresSecure[i];
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
                TopScoresSecure[lowestScoreIndex] = newScoreToReplace;
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

    function PayoutToWinners()
        public
        onlyOwner
    {
        require (IsSeasonOver(), "Season in progress");

        // update season
        SetNextSeasonReleaseDate(releaseDate, releaseDate + seasonInterval);

        // move scores to memory for sort and progress
        uint count = GetTopScoresSecureCount();

        Score[] memory scores = new Score[](count);

        uint i;
        for (i = 0; i < count; i++) {
            Score memory score = TopScoresSecure[i];
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

    function WipeScores()
        public
        onlyOwner
    {
        lastWipeDate = now;
//        TopScores.length = 0;
        TopScoresSecureCount = 0;
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
