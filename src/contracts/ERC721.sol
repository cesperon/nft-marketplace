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
    require(tokenOwner != address(0), "ERC721: address doesnt exist");
    _;
  }

  modifier nftOwned(uint256 id) {
    require(_tokenOwner[id] != address(0), "NFT token is not owned");
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

  modifier ownerValidation(address _from, uint256 tokenId) {
    require(
      _tokenOwner[tokenId] == _from,
      "sender of transaction is not the owner of the token"
    );
    _;
  }

  //basic minting function
  //internal functions can only be access by contract or derived contracts
  //virtual functions allow for other functions to override original functionality
  function _mint(address tokenOwner, uint256 tokenId)
    internal
    virtual
    addressNotNull(tokenOwner)
    tokenNotMinted(tokenId)
  {
    //in map set token id to token owner address
    _tokenOwner[tokenId] = tokenOwner;
    //in map increment addresses owned tokens
    _OwnedTokensCount[tokenOwner] += 1;

    emit Transfer(address(0), tokenOwner, tokenId);
  }

  /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
  ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
  ///  THEY MAY BE PERMANENTLY LOST
  /// @dev Throws unless `msg.sender` is the current owner, an authorized
  ///  operator, or the approved address for this NFT. Throws if `_from` is
  ///  not the current owner. Throws if `_to` is the zero address. Throws if
  ///  `_tokenId` is not a valid NFT.
  /// @param _from The current owner of the NFT
  /// @param _to The new owner
  /// @param _tokenId The NFT to transfer
  function transferFrom(
    address _from,
    address _to,
    uint256 _tokenId
  ) external payable {
    _transferFrom(_from, _to, _tokenId);
  }

  function _transferFrom(
    address _from,
    address _to,
    uint256 _tokenId
  ) internal ownerValidation(_from, _tokenId) addressNotNull(_to) {
    _OwnedTokensCount[_from] -= 1;
    _OwnedTokensCount[_to] += 1;
    _tokenOwner[_tokenId] = _to;

    emit Transfer(_from, _to, _tokenId);
  }

  /// @notice Count all NFTs assigned to an owner
  /// @dev NFTs assigned to the zero address are considered invalid, and this
  ///  function throws for queries about the zero address.
  /// @param _owner An address for whom to query the balance
  /// @return The number of NFTs owned by `_owner`, possibly zero
  function balanceOf(address _owner)
    public
    view
    addressNotNull(_owner)
    returns (uint256)
  {
    return _OwnedTokensCount[_owner];
  }

  /// @notice Find the owner of an NFT
  /// @dev NFTs assigned to zero address are considered invalid, and queries
  ///  about them do throw.
  /// @param _tokenId The identifier for an NFT
  /// @return The address of the owner of the NFT
  function ownerOf(uint256 _tokenId)
    external
    view
    nftOwned(_tokenId)
    returns (address)
  {
    return _tokenOwner[_tokenId];
  }
}
