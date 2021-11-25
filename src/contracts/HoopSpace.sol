// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "./ERC721Connector.sol";

contract HoopSpace is ERC721Connector {
  //store nfts in array
  string[] public hoopNfts;

  mapping(string => bool) hoopNftExists;

  function mint(string memory _hoopNft) public {
    require(!hoopNftExists[_hoopNft], "Error hoopSpace nft is already owned");
    //push nft to nfts array
    hoopNfts.push(_hoopNft);
    //create id for erc721 minting function using the index of HoopNfts
    uint256 tokenId = hoopNfts.length - 1;
    _mint(msg.sender, tokenId);
    hoopNftExists[_hoopNft] = true;
  }

  constructor() ERC721Connector("HoopSpace", "HSPACE", 4) {}
}
