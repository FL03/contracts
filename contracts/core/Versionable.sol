/// SPDX-License-Identifier: Apache-2.0 
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/utils/introspection/IERC165.sol";

interface Buildable {
    event BuildRequested(address indexed originator, string indexed appellation, uint256 buildId);

    function build(string memory appellation) external payable returns (uint256);
    
}

interface Versionable {
    event UpdateRequested(address indexed originator, string indexed appellation, uint256 versionId);

    /**
     * @dev Retrieve the previous build
     */
    function getPreviousBuild(uint256 versionNumber) external view returns (string memory);
    /**
     * @dev Application tokens implement standard update methods, requiring a valid signature verified against the global registry on Reaction
     */
    function update(address originator, string memory signature, uint256 versioning) external payable returns (bool);
    /**
     * @dev Fetch the current version
     */
    function version() external view returns (uint256);
}