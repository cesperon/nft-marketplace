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

  /// @notice Count NFTs tracked by this contract
  /// @return A count of valid NFTs tracked by this contract, where each one of
  ///  them has an assigned and queryable owner not equal to the zero address
  function totalSupply() external view returns (uint256) {
    return _allTokens.length;
  }

  modifier validAddress(address to) {
    require(to != address(0), "invalid address");
    _;
  }
  //   function validIndex() external view returns (uint256) {}

  modifier tokenValidIndex(uint256 index) {
    require(index >= 0 && index < _allTokens.length, "token index invalid");
    _;
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
  function tokenOfOwnerByIndex(address _owner, uint256 _index)
    external
    view
    tokenValidIndex(_index)
    validAddress(_owner)
    returns (uint256)
  {
    return _ownedTokens[_owner][_index];
  }

  function _mint(address to, uint256 tokenId) internal override(ERC721) {
    super._mint(to, tokenId);
    //1.add tokens to the owner
    _ownedTokens[to].push(tokenId);
    //2.add tokens to our total supply
    _allTokens.push(tokenId);
    //3. add token id to _owned tokens array that belonngs to user
    _ownedTokensIndex[tokenId] = _ownedTokens[to].length - 1;
  }
}
