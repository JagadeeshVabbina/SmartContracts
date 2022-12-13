//SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;
contract lotteryContest {
    address public Organizer;
    address payable[] players;

    uint public lotteryId;
    mapping(uint => address payable) public lotteryHistory;

    constructor() {
        Organizer = msg.sender;
        lotteryId = 0;
    }

    modifier onlyOrganizer() {
        require(msg.sender == Organizer);
        _;
    }

    function lotteryBalance() public view returns(uint) {
        return address(this).balance;
    }

    function listOfPlayers() public view returns(address payable[] memory) {
        return players;
    }

    receive() external payable {
        require(msg.value >= 1 ether);
        players.push(payable(msg.sender));
    }

    function generateRandomNum() private view returns(uint) {
        return uint(keccak256(abi.encodePacked(Organizer,block.timestamp)));
    }

    function pickWinner() public onlyOrganizer{
        require(players.length >= 2);
        uint index = generateRandomNum() % players.length;
        players[index].transfer(lotteryBalance());
        lotteryId++;
        lotteryHistory[lotteryId] = players[index];

        //reset players array
        players = new address payable[](0);

    }
    
}
