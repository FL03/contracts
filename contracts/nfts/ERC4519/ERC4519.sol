// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.0 <0.9.0;

import "./IERC4519.sol";

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/**
 * @custom:url https://eips.ethereum.org/EIPS/eip-4519 
 * @notice The EIP-165 identifier for the interface is 0x8a68abe3
 * @title ERC4519: 'SmartNFT' Extension of EIP-721 Non-Fungible Token Standard
 */
abstract contract ERC4519 is IERC4519, ERC721 {

    uint256 internal _dataEngagement;
    uint256 internal _hashK_A;

}