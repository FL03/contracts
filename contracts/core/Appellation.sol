// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.0 <0.9.0;

import "./Justification.sol";

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";


/**
 * @custom:definition Appellation is defined as an identifying name or title; designation
 * @dev Appellations implement a standard naming schematic which allows us to imbue a certain perspective within
 * @title IAppellation
 */
interface IAppellation {
    event Created(address indexed originator, string indexed appellation);

    function name() external view returns (string memory);
    /**
     * @return address: 
     */
    function origin() external view returns (address);

    function position() external view returns (uint256);
}
