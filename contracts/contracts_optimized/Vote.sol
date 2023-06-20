// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.15;

contract OptimizedVote {
    struct Voter {
        uint8 vote;
        bool voted;
    }

    // 1) reorder the struct
    struct Proposal {
        bytes32 name;
        uint8 voteCount;
        bool ended;
    }

    mapping(address => Voter) public voters;

    // 2) use a counter and mapping instead of array
    mapping(uint256 => Proposal) public proposals;
    uint256 proposalCount;

    function createProposal(bytes32 _name) external {
        proposals[++proposalCount] = Proposal({voteCount: 0, name: _name, ended: false});
    }

    function vote(uint8 _proposal) external {
        Voter storage voter = voters[msg.sender];
        require(!voter.voted, 'already voted');
        voter.vote = _proposal;
        voter.voted = true;

        Proposal storage proposal = proposals[_proposal];
        ++proposal.voteCount;
    }

    function getVoteCount(uint8 _proposal) external view returns (uint8) {
        return proposals[_proposal].voteCount;
    }
}
