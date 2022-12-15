//SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;
contract VotingIterations {

    address public owner;
    address[] public Candidates;
    mapping(address => uint) public votesReceivedBy;

    uint public highestVotes;
    address public winner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner,"You're not Authorized");
        _;
    }

    function registerCandidates(address _candidate) public onlyOwner {
        Candidates.push(_candidate);
    }

    function castVote(address _candidate) public {        
        require(validateCandidate(_candidate) == true,"The candidate is not nominated");
        require(status == votingStatus.Running,"The voting is either not started/completed");
        votesReceivedBy[_candidate] += 1;
    }

    //validating the candidate
    function validateCandidate(address _candidate) private view returns(bool) {
        for(uint i = 0;i<Candidates.length;i++) {
            if(Candidates[i] ==  _candidate)
            return true;
        }

        return false;
    }

    function winnerIs() public onlyOwner returns(address) {
        require(status == votingStatus.Completed,"Voting is still going on");
        for(uint i = 0;i < Candidates.length;i++) {
            if(votesReceivedBy[Candidates[i]] > highestVotes) {
                highestVotes = votesReceivedBy[Candidates[i]];
                winner = Candidates[i];                
            }
        }

        return winner;
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

// 2.
contract Voting2 {
    /* A election will be conducted by an owner and the owner should have absolute control over
    nominating candidates,setting the election status and declaring winner and any one can cast their
    votes provided they are castring for the nominated candidates only.*/

    address public owner;

    //list of nominated candidates
    address[] public candidates;

    //votes casted to the candidates
    mapping(address => uint) public votesReceivedBy;

    uint public highestVotes;
    address public winner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner,"you're not Authorized");
        _;
    }

    function nominateCandidates(address _candidate) public onlyOwner {
        candidates.push(_candidate);
    }

    function castVote(address _candidate) public {
        require(validate(_candidate) == true,"Not a valid candidate");
        require(status == votingStatus.Running,"Voting is either completed/Not yet started");
        votesReceivedBy[_candidate] += 1;
    }

    //function to validate the candidate
    function validate(address _candidate) private view returns(bool) {
        for(uint i =0;i<candidates.length;i++) {
            if(candidates[i] == _candidate)
              return true;     
        }
        
         return false;
    }

    //winner
    function winnerIs() public onlyOwner  returns(address) { 
        require(status != votingStatus.Running,"Voting is going on");       
        for(uint i = 0;i<candidates.length;i++) {
            if(votesReceivedBy[candidates[i]] > highestVotes) 
            highestVotes = votesReceivedBy[candidates[i]];
            winner = candidates[i];            
        }

        return winner;

    }

    enum votingStatus {NotStarted,Running,Completed} 
    votingStatus public status;

    //set the voting status
    function setStatus() onlyOwner public {
        if (status != votingStatus.Running) {
            status = votingStatus.Running;
        }        

        else 
            status = votingStatus.Completed;
    }
}


