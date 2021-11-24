// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract ERC721Metadata {
  //contract properties
  string private _name;
  string private _symbol;
  uint256 private _id;

  constructor(
    string memory named,
    string memory symbolified,
    uint256 identified
  ) {
    _name = named;
    _symbol = symbolified;
    _id = identified;
  }

  //getters
  function name() external view returns (string memory) {
    return _name;
  }

  function symbol() external view returns (string memory) {
    return _symbol;
  }

  function id() external view returns (uint256) {
    return _id;
  }
}
