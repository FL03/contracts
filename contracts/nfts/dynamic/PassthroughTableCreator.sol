// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@tableland/evm/contracts/ITablelandTables.sol";

/**
 * @dev Rather than implementing ERC721Holder, the contract simply facilitates the creation of tables pointing the registry to the sender insted of trhe contract itself...
 * @notice This is a sample contract demonstrating how to create Tableland table's directly from Soilidity.
 * @title PassthroughTableCreator
 */
contract PassthroughTableCreator {
	// A mapping that holds `tableName` and its `tableId`
    mapping(string => uint256) public tables;
	// Interface to the `TablelandTables` registry contract
    ITablelandTables private _tableland;

    constructor(address registry) {
        _tableland = ITablelandTables(registry);
    }

    function create(string memory prefix) public payable {
        uint256 tableId = _tableland.createTable(
            address(msg.sender),
            /*
            *  CREATE TABLE {prefix}_{chainId} (
            *    id integer primary key,
            *    message text
            *  );
            */
            string.concat(
                "CREATE TABLE ",
                prefix,
                "_",
                Strings.toString(block.chainid),
                " (id integer primary key, message text);"
            )
        );

        string memory tableName = string.concat(
            prefix,
            "_",
            Strings.toString(block.chainid),
            "_",
            Strings.toString(tableId)
        );

        tables[tableName] = tableId;
    }
}