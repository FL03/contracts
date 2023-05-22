/// SPDX-License-Identifier: Apache-2.0 
pragma solidity >=0.8.0 <0.9.0;

import "./IPlatform.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";

/**
 *
 *
 * @title Platform: A composite, dynamic application token forming the basis of a platform
 */
abstract contract Platform is ERC1155, IPlatform, Ownable {

    constructor(string memory _uri) ERC1155(_uri) {

    }
}