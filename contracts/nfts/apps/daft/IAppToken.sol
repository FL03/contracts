/// SPDX-License-Identifier: Apache-2.0 
pragma solidity >=0.8.0 <0.9.0;

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
interface IAppToken {
    event Authenticated(address indexed originator, string indexed appellation, uint256 tokenId);

    event Registered(address indexed originator, string indexed appellation, uint256 tokenId);
    event Registering(address indexed originator, string indexed appellation, uint256 tokenId);
    
    event Updating(address indexed originator, string indexed signature, uint256 versionNumber);

    /**
     * @dev Retrieve the previous build
     */
    function getPreviousBuild(uint256 versionNumber) external view returns (string memory);
    /**
     * @dev Register the created token with the correct registry
     */
    function register(address originator, string memory appellation, uint256 tokenId) external payable returns (bool);
    /**
     * @dev Application tokens implement standard update methods, requiring a valid signature verified against the global registry on Reaction
     */
    function update(address originator, string memory signature, uint256 versioning) external payable returns (bool);
    /**
     * @dev Fetch the current version
     */
    function version() external view returns (string memory);
}
