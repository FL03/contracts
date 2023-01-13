// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";

/**
 * @custom:definition Justifiable is defined as capable of being justified; where justified is defined as having or proving to have a just, right, or reasonable basis
 * @dev
 * @title Justifiable
 */
interface Justifiable {
    event Justified(address indexed originator, string indexed appellation, uint256 uid);

    function justify(address originator, string memory appellation, uint256 uid) external payable returns (bool);
}

/**
 * @title Justification
 */
abstract contract Justification is ERC721Upgradeable, Justifiable, OwnableUpgradeable {
    using CountersUpgradeable for CountersUpgradeable.Counter;
    // Counter for the current token ID
    CountersUpgradeable.Counter private _tokenIdCounter;

    constructor(string memory _name, string memory _symbol) ERC721Upgradeable() {

    }

    function justify(address originator, string memory appellation, uint256 uid) override external payable returns (bool) {
        emit Justified(originator, appellation, uid);

        return true;
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }
}