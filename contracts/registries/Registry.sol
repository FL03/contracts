/// SPDX-License-Identifier: Apache-2.0 
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
 * @dev An interface describing the basic functionality of an operable registry
 * @title Registry
 */
interface Registry {
    
    event Created(address indexed originator, string indexed appellation, uint256 tokenId);
    event Updated(address indexed originator, string indexed appellation, uint256 tokenId);

    function register(address originator, string memory appellation, uint256 tokenId) external view returns (bool);
    
}