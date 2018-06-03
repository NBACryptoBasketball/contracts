pragma solidity ^0.4.21;

// Manages the puzzles generation and hashes comparing.
contract PuzzleManager
{
    // Represents a generated puzzle.
    struct Puzzle
    {
        // The unique identifier for this puzzle.
        uint Id;
        // The owner who generated this puzzle.
        address Owner;
        // The original metrics associated to this puzzle.
        string OriginalMetrics;
        // The original hashed metrics associated to this puzzle.
        bytes32 OriginalHash;
        // The map of stored hashed metrics associated to this puzzle.
        mapping(address => bytes32) Hashes;
    }

    // Internal generated puzzles.
    mapping(uint => Puzzle) m_puzzles;

    // The next available id.
    uint m_currentId = 0;

    /// <summary>
    /// Creates a new puzzle with given metrics.
    /// </summary>
    function CreatePuzzle(string metrics) public returns(uint)
    {
        // Instantiate the new puzzle in memory.
        Puzzle memory puzzle = Puzzle(m_currentId, msg.sender, metrics, keccak256(bytes(metrics)));

        // Increment the current id for the next puzzle.
        m_currentId = m_currentId + 1;

        // Store the new generated puzzle.
        m_puzzles[puzzle.Id] = puzzle;

        return puzzle.Id;
    }

    /// <summary>
    /// Pushes metrics for the given puzzle.
    /// </summary>
    function PushMetrics(uint puzzleId, string metrics) public returns(bool)
    {
        m_puzzles[puzzleId].Hashes[msg.sender] = keccak256(bytes(metrics));

        return true;
    }

    /// <summary>
    /// Compares the metrics associated to this address to the
    /// original metrics, for the given puzzle id.
    /// </summary>
    function CompareMetrics(uint puzzleId) public view returns(bool)
    {
        Puzzle storage puzzle = m_puzzles[puzzleId];

        if(puzzle.OriginalHash == puzzle.Hashes[msg.sender])
        {
            return true;
        }
        return false;
    }

    /// <summary>
    /// Returns the original metrics associated to a given puzzle id.
    /// </summary>
    function GetPuzzleOriginalMetrics(uint puzzleId) public view returns(string)
    {
        return m_puzzles[puzzleId].OriginalMetrics;
    }
}