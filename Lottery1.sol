//SPDX-License-Identifier:GPL-3.0
pragma solidity ^0.8.17;
contract lotteryContract {
    /* One admin user conducts the lottery which he/she could not participate,
    users enter the contest by providing minimum ether set by contract,
    no user can join twice in a current iteration of lottery. the admin user will be 
    able to choose a random user as winner and the winner receives the pooled ether.
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

     function lotteryBalance() public view returns(uint) {
         return address(this).balance;
     }

     function listOfPlayers() public view returns(address payable[] memory) {
         return players;
     }

     function alreadyEntered() private view returns(bool) {
         for(uint i = 0;i < players.length;i++) {
             if(players[i] == msg.sender) {
               return true;
             }                    
                   
         }

         return false;      

         
     }

     function enterLottery() public payable {
         require(msg.sender != owner);
         require(alreadyEntered() == false,"User Already Entered");
         require(msg.value > 1 ether);
         players.push(payable(msg.sender));

     }

     function generateRandomNum() public view returns(uint) {
         return uint(keccak256(abi.encodePacked(owner,block.timestamp,block.number)));
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
