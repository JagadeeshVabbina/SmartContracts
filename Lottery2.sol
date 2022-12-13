//SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;
contract iterateLottery {
    address public owner;
    address payable[] players;

    uint public lotteryId;
    mapping(uint => address payable) public lotteryHistory;
    
    constructor() {
        owner = msg.sender;
        lotteryId = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function lotteryBalance() public view returns(uint) {
        return address(this).balance;
    }

    function listOfPlayers() public view returns(address payable[] memory) {
        return players;
    }

    //enter the lottery contest function
    function enterLottery() public payable {
        require(msg.sender != owner,"Organizer can not participate");
        require(alreadyEntered() == false,"User has already entered the contest");
        require(msg.value >= 1 ether);
        players.push(payable(msg.sender));
    }


    //to check whether the user has already entered the contest
    function alreadyEntered() private view returns(bool) {
        for(uint i=0;i<players.length;i++) {
            if(players[i] == msg.sender) {
                return true;
            }
        }

        return false; 
    }

    function generateRandomNum() public view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp,block.number,owner)));
    }

    //pick winner logic
    function pickWinner() public onlyOwner {
        uint index = generateRandomNum() % players.length;
        players[index].transfer(address(this).balance);
        lotteryId++;
        lotteryHistory[lotteryId] = players[index];

        //reset the contract status
        players = new address payable[](0);
    }
}

// 2.
contract lotteryContract2 {
    address public owner;
    address payable[] players;
    uint public lotteryId;
    mapping(uint => address payable) public lotteryHistory;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function lotteryAmount() public view returns(uint) {
        return address(this).balance;
    }

    function listOfPlayers() public view returns(address payable[] memory) {
        return players;
    }

    function enterContest() public payable {
        require(msg.sender != owner);
        require(alreadyEntered() == false,"User has already entered the contest");
        require(msg.value >= 1 ether);
        players.push(payable(msg.sender));
    }

    function alreadyEntered() private view returns(bool) {
        for (uint i = 0;i < players.length;i++) {
            if (players[i] == msg.sender) {
                return true;
            }
        }

        return false;
    }

    function generateRandomNum()  private view returns(uint) {
        return uint(keccak256(abi.encodePacked(owner,block.timestamp)));
    }

    function pickWinner() public onlyOwner {
        uint index = generateRandomNum() % players.length;
        players[index].transfer(address(this).balance);
        lotteryId++;
        lotteryHistory[lotteryId] = players[index];

        //reset the contract status
        players = new address payable[](0);
    }
}

// 3.
contract lotteryContract3 {

    address public owner;
    address payable[] players;
    uint public lotteryId;
    mapping(uint => address payable) public lotteryHistory;

    constructor() {
        owner = msg.sender;
        lotteryId = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function lotteryAmount() public view returns(uint) {
        return address(this).balance;
    }

    function listOfPlayers() public view returns(address payable[] memory) {
        return players;
    }

    function enterContest() public payable {
        require(msg.sender != owner,"Organizer can not participate in the contest");
        require(alreadyEntered() == false,"User has already entered the contest");
        require(msg.value >= 1 ether);
        players.push(payable(msg.sender));
    }

    function alreadyEntered() private view returns(bool) {
        for(uint i =0;i < players.length;i++) {
            if (players[i] == msg.sender) {
                return true;
            }           
        }

        return false;        
    }

    function generateRandomNum() private view returns(uint) {
        return uint(keccak256(abi.encodePacked(owner,block.timestamp)));
    }

    function pickWinner() onlyOwner public {
        uint index = generateRandomNum() % players.length;
        players[index].transfer(address(this).balance);
        lotteryId++;
        lotteryHistory[lotteryId] = players[index];

        //reset the state of the contract
        players = new address payable[](0);
    }
}

// 4.
contract lotteryContract4 {
    address public owner;
    address payable[] players;
    uint public lotteryId;
    mapping(uint => address payable) public lotteryHistory;

    constructor() {
        owner = msg.sender;
        lotteryId = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function lotteryBalance() public view returns(uint) {
        return address(this).balance;
    }

    function listOfPlayers() public view returns(address payable[] memory) {
        return players;
    }

    function enterContest() public payable {
        require(msg.sender != owner,"The organizer can not participate in the contest");
        require(alreadyEntered() == false,"User has already entered the contest");
        require(msg.value >= 1 ether);
        players.push(payable(msg.sender));
    }

    function alreadyEntered() private view returns(bool) {
        for(uint i = 0;i<players.length;i++) {
            if(players[i] == msg.sender) {
                return true;
            }
        }

        return false;
    }

    function generateRandomNum() private view returns(uint) {
        return uint(keccak256(abi.encodePacked(owner,block.timestamp)));
    }

    function pickWinner() public onlyOwner {
        uint index = generateRandomNum() % players.length;
        players[index].transfer(address(this).balance);
        lotteryId++;
        lotteryHistory[lotteryId] = players[index];

        //reset the contract status
        players = new address payable[](0);

    }
}

// 5.
contract lotteryContract5 {
    address public owner;
    address payable[] players;

    uint public lotteryId;
    mapping(uint => address payable) public lotteryHistory; 

    constructor() {
        owner = msg.sender;
        lotteryId = 0;
    }

    function lotteryBalance() public view returns(uint) {
        return address(this).balance;
    }

    function listOfPlayers() public view returns(address payable[] memory) {
        return players;
    }

    function enterContest() public payable {
        require(msg.sender != owner,"The Organizer should not enter the contest");
        require(alreadyEntered() == false,"User has already entered the contest");
        require(msg.value >= 1 ether);
        players.push(payable(msg.sender));
    }

    function alreadyEntered() private view returns(bool) {
        for(uint i = 0;i<players.length;i++) {
            if(players[i] == msg.sender) {
                return true;
            }
        }

        return false;
    }

    function generateRandomNum() private view returns(uint) {
        return uint(keccak256(abi.encodePacked(owner,block.timestamp)));
    }

    function pickWinner() public {
        uint index = generateRandomNum() % players.length;
        players[index].transfer(address(this).balance);
        lotteryId++;
        lotteryHistory[lotteryId] = players[index];

        //reset the status of contract

        players = new address payable[](0);
    }
}
