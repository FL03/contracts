/// SPDX-License-Identifier: Apache-2.0 
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
 * 
 * @dev An interface describing the basis of each application token
 * @title IAppNFT: 
 */
interface IAppNFT is IERC165, IERC721Receiver {
    event Authenticated(address indexed originator, string indexed appellation, uint256 tokenId);

    event Registered(address indexed originator, string indexed appellation, uint256 tokenId);
    event Registering(address indexed originator, string indexed appellation, uint256 tokenId);
    
    event Updated(address indexed originator, string indexed signature, uint256 cid);
    event Updating(address indexed owner, address indexed originator, string cid);

    /**
     * @dev Retrieve the previous build
     */
    function getPreviousBuild(uint256 versionNumber) external view returns (string memory);
    /**
     * @dev Register the application with the mainnet (Reaction)
     */
    function register(address originator, string memory appellation, uint256 tokenId) external view returns (bool);
    /**
     * @dev Application tokens implement standard update methods, requiring a valid signature verified against the global registry on Reaction
     */
    function update(string memory signature) external view returns (bool);
}
