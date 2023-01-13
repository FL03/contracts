/// SPDX-License-Identifier: Apache-2.0 
pragma solidity >=0.8.0 <0.9.0;

import "../../../core/Versionable.sol";

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";

/**
 * 
 * @dev An interface describing the basis of each application token
 * @title IDAFT: 
 */
interface IAppToken is Versionable {
    event Authenticated(address indexed originator, string indexed appellation, uint256 tokenId);

    event Registered(address indexed originator, string indexed appellation, uint256 tokenId);
    event Registering(address indexed originator, string indexed appellation, uint256 tokenId);


    /**
     * @dev Register the created token with the correct registry
     */
    function register(address originator, string memory appellation, uint256 tokenId) external payable returns (bool);
    
    function application() external view returns (string memory);
}
