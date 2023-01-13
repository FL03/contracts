// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.10 <0.9.0;

import "./IAppToken.sol";

import "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";
import "@tableland/evm/contracts/utils/SQLHelpers.sol";
import "@tableland/evm/contracts/utils/TablelandDeployments.sol";

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";

/**
 * @dev A composite, dynamic application token for conviently managing cloud-native applications
 * 
 * @title AppNFT
 */
contract Application is IAppToken, Initializable, ERC721Upgradeable, ERC721BurnableUpgradeable, ERC721URIStorageUpgradeable, OwnableUpgradeable, UUPSUpgradeable  {
    using CountersUpgradeable for CountersUpgradeable.Counter;
    
    /** 
     * @notice General information for creating dynamic tokens
     */
    // Counter for the current token ID
    CountersUpgradeable.Counter private _tokenIdCounter; 
    // Most recent timestamp at which the collection was updated
    uint256 lastTimeStamp; 
    uint256 interval; // Time (in seconds) for how frequently the NFTs should change
    // Track the token ID to its current version
    mapping(uint256 => string) public versions; 
    
    /** 
     * @notice Tableland-specific Information
     */
    uint256 private _attributesTableId; // A table ID -- stores NFT attributes
    string private _baseURIString; // The Tableland gateway URL
    uint256 private _tokensTableId; // A table ID -- stores the token ID and its current stage

    string private constant _ATTRIBUTES_TABLE_PREFIX = "components"; // Table prefix for the components table
    string private constant _TOKENS_TABLE_PREFIX = "tokens"; // Table prefix for the tokens table
    

    constructor(string memory baseURIString) {
        interval = 30; // Hardcode some interval value (in seconds) for when the dynamic NFT should "grow" into the next stage
        lastTimeStamp = block.timestamp; // Track the most recent timestamp for when a dynamic VRF update occurred
        _baseURIString = baseURIString;
        initialize();
    }
    
    function initialize() initializer public {
        __ERC721_init("MyToken", "MTK");
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        onlyOwner
        override
    {}

	function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }

    function checkUpkeep(bytes calldata checkData) external pure returns (bool upkeepNeeded, bytes memory performData) {
        
        return (false, checkData);
    }
    /// Implements the method of generation, minting new applications accordingly
    function mint(string memory _tokenURI) private returns (uint256) {
        _tokenIdCounter.increment();
        uint256 tokenId = 1;
        uint256 currentVersion = _tokenIdCounter.current();
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, _tokenURI);
        versions[currentVersion] = _tokenURI;
        return tokenId;
    }

    function performUpkeep(bytes calldata performData) external pure {
    }
    /**
     * @dev Retrieve the previous build
     */
    function getPreviousBuild(uint256 versionNumber) external view returns (string memory) {
        return versions[versionNumber];
    }
    /**
     * @dev Register the created token with the correct registry
     */
    function register(address originator, string memory appellation, uint256 tokenId) external payable returns (bool) {
        emit Registering(originator, appellation, tokenId);
        return true;
    }
    /**
     * @dev Application tokens implement standard update methods, requiring a valid signature verified against the global registry on Reaction
     */
    function update(address originator, string memory signature, uint256 versioning) external payable returns (bool) {
        emit Updating(originator, signature, versioning);
        return true;
    }
    /**
     * @dev Fetch the current version from the store
     */
    function version() external view returns (string memory) {
        return versions[_tokenIdCounter.current()];
    }

    // The following functions are overrides required by Solidity.
    function _burn(uint256 tokenId)
        internal
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}