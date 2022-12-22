//SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;
contract Lottery {
    address public owner;
    address payable[] public players;

    address public winner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner,"You are not authorized");
        _;
    }

    function getContestPot() public view returns(uint) {
        return address(this).balance;
    }

    function enterContest() public payable {
        require(msg.value >= 1 ether);
        players.push(payable(msg.sender));
    }

    function generateRandomNum() private view returns(uint) {
        return uint(keccak256(abi.encodePacked(owner,block.timestamp,block.difficulty)));
    }

    function pickWinner() onlyOwner public {
        uint index = generateRandomNum() % players.length;
        players[index].transfer(address(this).balance);
        winner = players[index];

        //reset the contract status
        players = new address payable[](0);
    }
}
