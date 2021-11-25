// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract ERC721 {
  /*
    building out the minting function:
        a. nft to point to an address that
        b. keep track of the token ids
        c. keep track of token owner addresses to token ids
        d. keep track of how many tokens an owner address has
        e. create an event that emits a 
        transfer log- contract address, where it is being minted to, the id
    */

  /*
    minting basic protocol:
      1. write a function _mint that takes two arguments 
      an address called to and an integer tokenId.
      2. add internal visibility to the signature of the
      3. set the tokenOwner of the tokenId to the address
      argument 'to'
      4. increase the owner token count by 1 each time the function
      is called

    require:
      1. mint address cannot be 0
      2. a token that is minted cannot be already
      minted

   */
  //shows data of indexed token, use indexed to search through evm typically 3 per event
  event Transfer(
    address indexed contractAdress,
    address indexed tokenOwner,
    uint256 indexed tokenId
  );
  //mapping from token id to owner
  mapping(uint256 => address) private _tokenOwner;

  //mapping from owner to number of owned tokens
  mapping(address => uint256) private _OwnedTokensCount;

  //modifiers act as error checking for functions
  modifier addressNotNull(address tokenOwner) {
    require(tokenOwner != address(0), "ERC721: minting to the zero address");
    _;
  }

  //modifiers act as error checking for functions
  modifier tokenNotMinted(uint256 tokenId) {
    require(
      _tokenOwner[tokenId] == address(0),
      "This function is requires that tokenID has not been minted"
    );
    _;
  }

  //basic minting function
  //internal functions can only be access by contract or derived contracts
  function _mint(address tokenOwner, uint256 tokenId)
    internal
    addressNotNull(tokenOwner)
    tokenNotMinted(tokenId)
  {
    //in map set token id to token owner address
    _tokenOwner[tokenId] = tokenOwner;
    //in map increment addresses owned tokens
    _OwnedTokensCount[tokenOwner] += 1;

    emit Transfer(address(0), tokenOwner, tokenId);
  }
}
