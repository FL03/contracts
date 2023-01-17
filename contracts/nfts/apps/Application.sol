/// SPDX-License-Identifier: Apache-2.0 
pragma solidity >=0.8.0 <0.9.0;

import "./IApplication.sol";

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
/**
 * @dev Updating the application requires the user to provide a 
 * @dev The base application token serving as the backbone of each portal
 * @title AppNFT
 */
contract App is Initializable, IApplication, ERC721URIStorageUpgradeable, OwnableUpgradeable, UUPSUpgradeable {
    using CountersUpgradeable for CountersUpgradeable.Counter;
    CountersUpgradeable.Counter public versioning;
    
    mapping(uint256 => string) public versions; // Each version maps to the hash of the version; similar to NixOS packages

    constructor() {
        initialize();
    }
    function initialize() initializer public {
        __ERC721_init("Proton", "PRO");
        __Ownable_init();
        __UUPSUpgradeable_init();
        mint("https://pzzld.eth.limo/_app/immutable/assets/AbstractBlocks-5bb9e3d6.png");
    }
    /// Authorize the contract upgrade
    function _authorizeUpgrade(address newImplementation) internal onlyOwner override virtual {}
    /// Fetch the previous build version given the latest release
    function getPreviousBuild(uint256 versionNumber) public override view returns (string memory) {
        return versions[versionNumber];
    }
    /// Implements the method of generation, minting new applications accordingly
    function mint(string memory tokenURI) private returns (uint256) {
        versioning.increment();
        uint256 tokenId = 1;
        uint256 currentVersion = version();
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);
        versions[currentVersion] = tokenURI;
        return tokenId;
    }
    /// Implements a standard method of transfer
    function transferFrom(address from, address to, uint256 tokenId) public virtual override {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: caller is not token owner nor approved"
        );

        _transfer(from, to, tokenId);
    }
    /// This function enables owners to update their applications to the latest release
    function update(string memory appellation, string memory newTokenURI) override public onlyOwner {
        emit UpdateRequested(msg.sender, appellation, version() + 1);

        _setTokenURI(1, newTokenURI);

        versions[version() + 1] = newTokenURI;
        versioning.increment();
    }
    /// Return the current version number
    function version() override public view returns (uint256) {
        return versioning.current();
    }
    
} 