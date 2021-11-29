// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./ERC721.sol";

contract ERC721Enumerable is ERC721 {
  uint256[] private _allTokens;

  // mapping from tokenId to position in _allTokens array
  mapping(uint256 => uint256) private _allTokenIndex;

  //mapping from owner to list of all owned token ids
  mapping(address => uint256[]) private _ownedTokens;

  // mapping from token ID to index of the owner tokens list
  mapping(uint256 => uint256) private _ownedTokensIndex;

  modifier validAddress(address to) {
    require(to != address(0), "invalid address");
    _;
  }

  modifier ownerTokenValidIndex(address to, uint256 index) {
    require(index < balanceOf(to), "invalid owner token index");
    _;
  }

  modifier tokenValidIndex(uint256 index) {
    require(index >= 0 && index < _allTokens.length, "token index invalid");
    _;
  }

  /// @notice Count NFTs tracked by this contract
  /// @return A count of valid NFTs tracked by this contract, where each one of
  ///  them has an assigned and queryable owner not equal to the zero address
  function totalSupply() external view returns (uint256) {
    return _allTokens.length;
  }

  /// @notice Enumerate valid NFTs
  /// @dev Throws if `_index` >= `totalSupply()`.
  /// @param _index A counter less than `totalSupply()`
  /// @return The token identifier for the `_index`th NFT,
  ///  (sort order not specified)
  function tokenByIndex(uint256 _index)
    external
    view
    tokenValidIndex(_index)
    returns (uint256)
  {
    //pass in index
    //if index >= length || index < 0 then return error("Index out of bounds")
    //else
    //return tokenId associate with index
    return _allTokens[_index];
  }

  /// @notice Enumerate NFTs assigned to an owner
  /// @dev Throws if `_index` >= `balanceOf(_owner)` or if
  ///  `_owner` is the zero address, representing invalid NFTs.
  /// @param _owner An address where we are interested in NFTs owned by them
  /// @param _index A counter less than `balanceOf(_owner)`
  /// @return The token identifier for the `_index`th NFT assigned to `_owner`,
  ///   (sort order not specified)
  //fix tokenValidIndex should pertain to owners list and not whole
  function tokenOfOwnerByIndex(address _owner, uint256 _index)
    external
    view
    ownerTokenValidIndex(_owner, _index)
    validAddress(_owner)
    returns (uint256)
  {
    return _ownedTokens[_owner][_index];
  }

  function addTokensToAllTokenEnumeration(uint256 tokenId) private {
    //1.add tokens to our total supply
    _allTokens.push(tokenId);
    //2. map token id to all tokens index
    _allTokenIndex[tokenId] = _allTokens.length;
  }

  function addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
    //1.add tokens to the owner
    _ownedTokens[to].push(tokenId);
    //3. add token id to _owned tokens array that belonngs to user
    _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
  }

  //override ERC721 mint function
  function _mint(address to, uint256 tokenId) internal override(ERC721) {
    super._mint(to, tokenId);
    addTokensToAllTokenEnumeration(tokenId);
    addTokensToOwnerEnumeration(to, tokenId);
  }
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
) external payable;
