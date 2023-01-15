/// SPDX-License-Identifier: Apache-2.0 
pragma solidity >=0.8.0 <0.9.0;

import "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@tableland/evm/contracts/utils/SQLHelpers.sol";
import "@tableland/evm/contracts/utils/TablelandDeployments.sol";

/** 
 *
 * @title IPasskeyToken: Interface for the self-managed FIDO Passkey Token
 */
interface IPasskeyToken {
    event RegistrationSuccess(address indexed originator, address indexed registrant, string deviceId, uint256 tokenId);

    function authenticate(uint256 tokenId, string memory sk) external view returns (bool);

    function register(address registrant, string memory deviceId) external view returns (uint256);
}

/** 
 *
 * @title PasskeyToken: The FIDO Passkey Token
 */
abstract contract PasskeyToken is IPasskeyToken, AutomationCompatible, ERC721, IERC721Receiver, Ownable {
    /** 
     * @dev General info for ChainLink & Dynamic NFT's
     */
    using Counters for Counters.Counter;
    uint256 interval; // Time (in seconds) for how frequently the NFTs should change
    uint256 lastTimeStamp; // Most recent timestamp at which the collection was updated
    mapping(uint256 => uint256) public stage; // Track the token ID to its current stage
    Counters.Counter private _tokenIdCounter; // Counter for the current token ID

}