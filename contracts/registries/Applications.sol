/// SPDX-License-Identifier: Apache-2.0 
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "./Registry.sol";

/**
 * @dev The base application token serving as the backbone of each portal
 * @title ApplicationRegistry
 */
abstract contract ApplicationRegistry is Registry {
    address private owner;
    mapping(address => mapping(string => string[])) userbase;

    constructor() {
        owner == msg.sender;
    }
}