//SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;
contract voting {
    /* one admin owner will conduct a voting, only the owner would be able to set the status of the voting,
    call the winner and will register candidates.any one can cast their vote  */
    address public owner;
    address[] public candidates;
    mapping(address => uint) public votesReceivedBy;

    uint public highestVotes;
    address public winner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner,"you're not authorized");
        _;
    }    

    function registerCandidates(address _candidate) onlyOwner public {
        candidates.push(_candidate);
    }

    function castVote(address _candidate) public {        
        require(validateCandidate(_candidate) == true,"The candidate is not nominated");
        require(status== votingStatus.Running,"either not yet started / completed");
        votesReceivedBy[_candidate] += 1;
    }

    function validateCandidate(address _candidate) private view returns(bool) {
        for (uint i =0;i < candidates.length;i++) {
            if(candidates[i] == _candidate) {
                return true;
            }
        }

        return false;
    }

    function checkWinner() public onlyOwner {
        require(status == votingStatus.Completed,"The election is still going on");
        for (uint i;i< candidates.length;i++) {
            if(votesReceivedBy[candidates[i]] > highestVotes) {
                highestVotes = votesReceivedBy[candidates[i]];
                winner = candidates[i];
            }
        }
    }

    enum votingStatus {NotStarted,Running,Completed}
    votingStatus public status;

    function setStatus() onlyOwner public {
        if(status != votingStatus.Running) {
            status = votingStatus.Running;
        }

        else 
        status = votingStatus.Completed;
    }


}
