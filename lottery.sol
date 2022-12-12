//SPDX-License-Identifier:GPL-3.0
pragma solidity ^0.8.17;
contract smartContractLottery {

    /* architecture of the contract:-
    the principle is participant will enter the lottery contest by pooling some ether \
    The admin user will select a random winner and the pooled balance will be transfered to the winner.

    Objects the facilitate the required logic.
    State Variables:- owner, players(array).
    Functions:- enterContest,pickWinner,generateRandomNum

    Optional:- getLotteryAmount,getPlayes..etc.
    */

    address public owner;
    address payable[] public players;
    uint public lotteryId;
    mapping(uint => address payable) public lotteryHistory;

    constructor() {
        owner = msg.sender;
        lotteryId = 1;
    }

    function lotterAmount() public view returns(uint) {
        return address(this).balance;
    }

    function getPlayers() public view returns(address payable[] memory) {
        return players;
    }

    function enterContest() public payable {
        require(msg.value > 0.01 ether );
        players.push(payable(msg.sender));
    }

    function generateRandomNum() public view returns(uint) {
        return uint(keccak256(abi.encodePacked(owner,block.timestamp)));
    }

    function pickWinner() public onlyOwner {
        uint index = generateRandomNum() % players.length;
        players[index].transfer(address(this).balance);
        lotteryHistory[lotteryId] = players[index];
        lotteryId++;

        // reset the state of the contract
        players = new address payable[](0);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;        
    }
}
