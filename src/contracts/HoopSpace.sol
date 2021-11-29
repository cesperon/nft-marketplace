// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "./ERC721Connector.sol";

contract HoopSpace is ERC721Connector {
  //store nfts in array
  string[] public hoopNfts;
  //debug i
  uint256[] public nftIds;
  mapping(string => bool) hoopNftExists;

  function mint(string memory _hoopNft) public {
    require(!hoopNftExists[_hoopNft], "Error hoopSpace nft is already owned");
    //push nft to nfts array
    hoopNfts.push(_hoopNft);
    //create id for erc721 minting function using the index of HoopNfts
    uint256 tokenId = hoopNfts.length - 1;
    //debug
    nftIds.push(tokenId);
    _mint(msg.sender, tokenId);
    hoopNftExists[_hoopNft] = true;
  }

  function showNfts() public view returns (string[] memory) {
    return hoopNfts;
  }

  function showNftIds() public view returns (uint256[] memory) {
    return nftIds;
  }

  constructor() ERC721Connector("HoopSpace", "HSPACE", 4) {}
}
