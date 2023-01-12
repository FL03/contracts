// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.10 <0.9.0;

import "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@tableland/evm/contracts/utils/SQLHelpers.sol";
import "@tableland/evm/contracts/utils/TablelandDeployments.sol";

/**
 * @dev A composite, dynamic application token for conveintly managing sofware
 * 
 * @title AppNFT
 */
abstract contract AppNFT is ERC721, IERC721Receiver, Ownable, AutomationCompatible {
    // General dNFT and Chainlink data
    using Counters for Counters.Counter;
    // Counter for the current token ID
    Counters.Counter private _tokenIdCounter; 
    // Most recent timestamp at which the collection was updated
    uint256 lastTimeStamp; 
    uint256 interval; // Time (in seconds) for how frequently the NFTs should change
    // Track the token ID to its current stage
    mapping(uint256 => uint256) public stage; 
    
    /** 
     * @notice Tableland-specific Information
     */
    uint256 private _attributesTableId; // A table ID -- stores NFT attributes
    string private _baseURIString; // The Tableland gateway URL
    uint256 private _tokensTableId; // A table ID -- stores the token ID and its current stage

    string private constant _ATTRIBUTES_TABLE_PREFIX = "components"; // Table prefix for the components table
    string private constant _TOKENS_TABLE_PREFIX = "tokens"; // Table prefix for the tokens table
    

    constructor(string memory baseURIString) ERC721("dNFTs", "dNFT") {
        interval = 30; // Hardcode some interval value (in seconds) for when the dynamic NFT should "grow" into the next stage
        lastTimeStamp = block.timestamp; // Track the most recent timestamp for when a dynamic VRF update occurred
        _baseURIString = baseURIString;
    }

	function onERC721Received(address, address, uint256, bytes calldata) override external pure returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }

    // function checkUpkeep(bytes calldata checkData) override external returns (bool upkeepNeeded, bytes memory performData) {
        
    // }

}