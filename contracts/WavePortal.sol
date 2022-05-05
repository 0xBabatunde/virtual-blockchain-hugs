// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
  uint256 totalHugs;

  /*
  * To generate random numbers
  */
  uint256 private seed;

  event NewHug(address indexed from, uint256 timestamp, string message);


  struct Hug {
    address waver;
    string message;
    uint256 timestamp;
  }

  Hug[] hugs;

  mapping(address => uint256) public lastHugSent;

    constructor() payable {
        console.log("GM. WAGMI!");

        /*
        * Set the initial seed
        */
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function hug(string memory _message) public {
      require(
        lastHugSent[msg.sender] + 30 seconds < block.timestamp,
        "Please wait 30secs before sending another hug"
      );

      lastHugSent[msg.sender] = block.timestamp;

      totalHugs += 1;
      console.log("%s sent you a hug with Twitter handle: %s", msg.sender, _message);

      hugs.push(Hug(msg.sender, _message, block.timestamp));

      /*
      * Generate a new seed for the next user that sends a wave
      */
      seed = (block.timestamp + block.difficulty) % 100;

      console.log("Random number generated: %d", seed);

      /*
      * Give a 50% chance that the user wins the price
      */
      if (seed <= 50) {
        console.log("%s won", msg.sender);


      uint256 prizeAmount = 0.0001 ether;
      require(
        prizeAmount <= address(this).balance,
        "Trying to withdraw more money than the contract has."
      );

      (bool success, ) = (msg.sender).call{value: prizeAmount}("");
      require(success, "Failed to withdraw money from contract");

      }

      emit NewHug(msg.sender, block.timestamp, _message);
    }

    function getAllHugs() public view returns (Hug[] memory) {
      return hugs;
    }

    function getTotalHugs() public view returns (uint256) {
      return totalHugs;
    }
}
