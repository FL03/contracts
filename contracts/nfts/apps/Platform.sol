/// SPDX-License-Identifier: Apache-2.0 
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";

/**
 *
 *
 * @title ProtonOS: A composite, dynamic application token
 */
interface IPlatform is IERC165, IERC1155 {


    function update(string memory versioning) external view returns (bool);
}