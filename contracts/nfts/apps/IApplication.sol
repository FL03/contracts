/// SPDX-License-Identifier: Apache-2.0 
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
 * 
 * @dev An interface describing the basis of each application token
 * @title IDAFT: 
 */
interface IApplication {

    event UpdateRequested(address indexed originator, string indexed appellation, uint256 versionId);
    event UpdateSuccess(address indexed originator, string indexed appellation, uint256 versionId);
    
    /**
     * @dev Retrieve the previous build
     */
    function getPreviousBuild(uint256 versionNumber) external view returns (string memory);
    /**
     * @dev Application tokens implement standard update methods, requiring a valid signature verified against the global registry on Reaction
     */
    function update(string memory signature, string memory versioning) external;
    /**
     * @dev Fetch the current version
     */
    function version() external view returns (uint256);
}
