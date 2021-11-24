// SPDX-License-Identifier: MIT
//Migrations are used to update contracts on the blockchain
pragma solidity >=0.4.22 <0.9.0;

contract Migrations {
  address public owner = msg.sender;
  uint256 public last_completed_migration;

  //modifiers act as error checking for functions
  modifier restricted() {
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner"
    );
    _;
  }

  //set last completed migration to the migration that has just completed
  function setCompleted(uint256 completed) public restricted {
    last_completed_migration = completed;
  }

  //upgrade contract
  function upgrade(address new_address) public restricted {
    //inhertance of migrations contract
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
