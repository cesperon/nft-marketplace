// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./ERC721Metadata.sol";

//inhertiance keywords all functions in ERC721Metada that are public are now in the connector
contract ERC721Connector is ERC721Metadata {
  constructor(
    string memory name,
    string memory symbol,
    uint256 id
  ) ERC721Metadata(name, symbol, id) {}
}
