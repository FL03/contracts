/// SPDX-License-Identifier: Apache-2.0 
pragma solidity >=0.8.0 <0.9.0;

import "./IApplication.sol";

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";

/**
 * @dev Updating the application requires the user to provide a 
 * @dev The base application token serving as the backbone of each portal
 * @title AppNFT
 */
contract AppNFT is IApplication, ERC721URIStorageUpgradeable, OwnableUpgradeable, UUPSUpgradeable {
    using CountersUpgradeable for CountersUpgradeable.Counter;
    CountersUpgradeable.Counter public versions;
    mapping(uint256 => string) public builds; // Each version maps to the hash of the version; similar to NixOS packages

    constructor(string memory _name, string memory _symbol, string memory tokenURI) {
        __ERC721_init(_name, _symbol);
        __Ownable_init();
        __UUPSUpgradeable_init();
        mint(tokenURI);
    }

    /// Authorize the contract upgrade
    function _authorizeUpgrade(address newImplementation) internal onlyOwner override virtual {}
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
    function update(string memory appellation, string memory newTokenURI) public onlyOwner {
        emit UpdateRequested(msg.sender, appellation, version() + 1);

        _setTokenURI(1, newTokenURI);

        builds[version() + 1] = newTokenURI;
        versions.increment();
    }
    /// Return the current version number
    function version() public view returns (uint256) {
        return versions.current();
    }

} 