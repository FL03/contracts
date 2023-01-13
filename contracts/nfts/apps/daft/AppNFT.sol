/// SPDX-License-Identifier: Apache-2.0 
pragma solidity >=0.8.0 <0.9.0;

import "./IAppToken.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
 * @dev Applications are required to provide a signature 
 * @dev The base application token serving as the backbone of each portal
 * @title AppNFT
 */
abstract contract AppNFT is IAppToken, ERC721URIStorageUpgradeable, OwnableUpgradeable, UUPSUpgradeable {
    using Counters for Counters.Counter;
    Counters.Counter public versions;
    mapping(uint256 => string) public builds; // Each version maps to the hash of the version; similar to NixOS packages

    constructor(string memory _name, string memory _symbol, string memory tokenURI) {
        __ERC721_init(_name, _symbol);
        __Ownable_init();
        __UUPSUpgradeable_init();
        mint(tokenURI);
    }

    /// Fetch the previous build version given the latest release
    function getPreviousBuild(uint256 versionNumber)
        public
        override
        view
        returns (string memory)
    {
        return builds[versionNumber];
    }
    /// Implements the method of generation, minting new applications accordingly
    function mint(string memory tokenURI) private returns (uint256) {
        versions.increment();
        uint256 tokenId = 1;
        uint256 currentVersion = versions.current();
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);
        builds[currentVersion] = tokenURI;
        return tokenId;
    }
    /// Implements a standard method of transfer
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: caller is not token owner nor approved"
        );

        _transfer(from, to, tokenId);
    }
    /// This function enables owners to update their applications to the latest release
    function updateApp(string memory appellation, string memory newTokenURI) public {
        emit UpdateRequested(msg.sender, appellation, versions.current() + 1);
        require(
            msg.sender == owner(),
            "Only the app owner can make this change"
        );
        uint256 currentVersion = versions.current();
        _setTokenURI(1, newTokenURI);
        builds[currentVersion + 1] = newTokenURI;
        versions.increment();
    }
} 