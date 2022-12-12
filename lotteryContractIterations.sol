//SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;
contract lotteryContract {
    /* Architecture:- 
       Principle:- users will enter the lottery contest by sending a minimum ether.
       the contract owner will be able to pick a random winner and the lottery amount will be
       transfered to the winner.
       Objects which facilitate that logic.
       State variables:- owner, players(array)
       Functions:- enterContest,pickWinner,generateRandomNum.
       Optional:- contractBalance,playersList..etc
    */

    address public owner;
    address payable[] public players;
    uint public lotteryId;
    mapping(uint => address payable) public lotteryHistory;

    constructor() {
        owner = msg.sender;
        lotteryId = 0;
    }

    function LotteryBalance() public view returns(uint) {
        return address(this).balance;
    }

    function listOfPlayers() public view returns(address payable[] memory) {
        return players;
    }
    
    // This allows users to participate in the lottery Contest.
    function enterContest() public payable {
        require(msg.value > 0.01 ether);
        players.push(payable(msg.sender));
    }

    function generateRandomNum() public view returns(uint) {
        return uint(keccak256(abi.encodePacked(owner,block.timestamp)));
    }

    function pickWinner() onlyOwner public {        
        uint index = generateRandomNum() % players.length;
        players[index].transfer(address(this).balance);
        lotteryId++;
        lotteryHistory[lotteryId] = players[index];

        //update the state of the contract
        players = new address payable[](0);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
}

// 2.
contract LotteryContract2 {
    /* Architecture{
        Principle:- users will participate in the lottery contest by pool a minimum ether.
        the admin user will be able to choose a random participant as winner and will get all the contract's ether.
        Objects to facilitate the Logic:
        State variable:- owner, players(array).
        Functions:- enterContest,pickWinner,generateRandomNum
        Optional:- utility functions
        lotteryBalance,listOfPlayers..etc...
    */

    address public owner;
    address payable[] public players;
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

    function listOfParticipants() public view returns(address payable[] memory) {
        return players;
    }

    function enterContest() public payable {
     require(msg.value > 0.01 ether);
     //contest participants
     players.push(payable(msg.sender));
    }

    function generateRandomNum() public view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp,tx.gasprice)));
    }

    function pickWinner() public onlyOwner {
        uint index = generateRandomNum() % players.length;
        players[index].transfer(address(this).balance);
        lotteryId++;
        lotteryHistory[lotteryId] = players[index];

        //reset the state of the contract
        players = new address payable[](0);
    }
}

// 3.
contract lotteryContract3 {
    /* architecture:- 
    principle:- users will participate in the contest by providing  ether, then the
    admin user will be able to select a random user as a winner and the winner will receive all the pooled amount.
    Objects to facilitate the Logic:-
    State Variables:- owner,players(array).
    functions:- participateContest,pickWinner,generateRandomNum
    Optional:- lotteryAmount,listOfParticipants..etc
    */

    address public owner;
    address payable[] players;
    uint public lotteryId;
    mapping(uint => address payable) public lotteryWinners;

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

    function listOfParticipants() public view returns(address payable[] memory) {
        return players;
    }

    function enterContest() public payable {
        require(msg.value > 0.01 ether);
        players.push(payable(msg.sender));        
    }

    function generateRandomNum() public view returns(uint) {
        return uint(keccak256(abi.encodePacked(owner,block.timestamp)));
    }

    function pickWinner() onlyOwner public {
        uint index = generateRandomNum() % players.length;
        players[index].transfer(address(this).balance);
        lotteryId++;
        lotteryWinners[lotteryId] = players[index];

        //reset the state of the contract.
        players = new address payable[](0);
    }
}

// 4.
contract lotteryContract4 {
    /* architecture:-
    principle:- bunch of users will participate in a lucky lottery contest by providng ether,
    the admin user will be able to initiate a method that will choose a lucky winner and the winner will receive the pooled ether.
    Objects to facitate the Logic:-
    state variables:- owner,players(array).
    functions:- participateContest,pickWinner,generateRandomNum.
    Optional:- lotteryAmount,listOfParticipants..etc    
    */

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
        require(msg.value > 0.01 ether);
        players.push(payable(msg.sender));
    }

    function generateRandomNum() public view returns(uint) {
        return uint(keccak256(abi.encodePacked(owner,block.timestamp)));
    }

    function pickWinner() public onlyOwner {
        uint index = generateRandomNum() % players.length;
        players[index].transfer(address(this).balance);
        lotteryId++;
        lotteryHistory[lotteryId] = players[index];

        //reset the status of contract
        players = new address payable[](0);
    }
}

// 5.

contract lotteryContract5 {
    /*architecture:-
    principle:- users will participate in a lottery contest by providing ether,
    one user will be randomly selected as winner thus receives the pooled ether.
    Objects to facilitate the Logic:-
    state variables:- owner,players(array)
    Functions:- participateContest,pickWinner,generateRandomNum...
    Optional:- lotteryAmount,listOfparticipants..etc
     */

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

     function listOfParticipants() public view returns(address payable[] memory) {
         return players;
     }

     function enterContest() public payable {
         require(msg.value > 0.01 ether);
         players.push(payable(msg.sender));
     }

     function generateRandomNum() public view returns(uint) {
         return uint(keccak256(abi.encodePacked(owner,block.timestamp)));
     }

     function pickWinner() onlyOwner public {
         uint index = generateRandomNum() % players.length;
         players[index].transfer(address(this).balance);
         lotteryId++;
         lotteryHistory[lotteryId] = players[index];

         //reset the status of contract
         players = new address payable[](0);
     }

}

