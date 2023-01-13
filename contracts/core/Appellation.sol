// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.0 <0.9.0;

import "./Justifiable.sol";

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";


/**
 * @custom:definition Appellation is defined as an identifying name or title; designation
 * @dev Appellations implement a standard naming schematic which allows us to imbue a certain perspective within
 * @title IAppellation
 */
contract Appellation is ERC165, Justifiable {

    function justify(address originator, string memory appellation, uint256 uid) override external payable returns (bool) {
        emit Justified(originator, appellation, uid);

        return true;
    }
}