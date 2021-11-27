// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./ERC721Metadata.sol";
import "./ERC721Enumerable.sol";

//inhertiance keywords all functions in ERC721Metada, ERC721 that are public are now in the connector
contract ERC721Connector is ERC721Metadata, ERC721Enumerable {
  constructor(
    string memory name,
    string memory symbol,
    uint256 id
  ) ERC721Metadata(name, symbol, id) {}
}
