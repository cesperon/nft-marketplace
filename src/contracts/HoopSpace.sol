// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "./ERC721Connector.sol";

contract HoopSpace is ERC721Connector {
  constructor() ERC721Connector("HoopSpace", "HSPACE", 4) {}
}
