// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/utils/introspection/IERC165.sol";

/**
 * @custom:url https://eips.ethereum.org/EIPS/eip-5516
 * @notice IERC5516 implements the interface for so-called soulbound multi-owner tokens
 * @title ERC5516: Solubound Multi-Owner Tokens
 */
interface IERC5516 is IERC165 {
/**
     * @dev Emitted when `account` claims or rejects pending tokens under `ids[]`.
     */
    event TokenClaimed(
        address indexed operator,
        address indexed account,
        bool[] actions,
        uint256[] ids
    );

    /**
     * @dev Emitted when `from` transfers token under `id` to every address at `to[]`.
     */
    event TransferMulti(
        address indexed operator,
        address indexed from,
        address[] to,
        uint256 amount,
        uint256 id
    );

    /**
     * @dev Get tokens owned by a given address.
     */
    function tokensFrom(address from) external view returns (uint256[] memory);

    /**
     * @dev Get tokens awaiting to be claimed by a given address.
     */
    function pendingFrom(address from) external view returns (uint256[] memory);

    /**
     * @dev Claims or Reject pending `id`.
     *
     * Requirements:
     * - `account` must have a pending token under `id` at the moment of call.
     * - `account` must not own a token under `id` at the moment of call.
     *
     * Emits a {TokenClaimed} event.
     *
     */
    function claimOrReject(
        address account,
        uint256 id,
        bool action
    ) external;

    /**
     * @dev Claims or Reject pending tokens under `ids[]`.
     *
     * Requirements for each `id` `action` pair:
     * - `account` must have a pending token under `id` at the moment of call.
     * - `account` must not own a token under `id` at the moment of call.
     *
     * Emits a {TokenClaimed} event.
     *
     */
    function claimOrRejectBatch(
        address account,
        uint256[] memory ids,
        bool[] memory actions
    ) external;

    /**
     * @dev Transfers `id` token from `from` to every address at `to[]`.
     *
     * Requirements:
     *
     * - `from` MUST be the creator(minter) of `id`.
     * - All addresses in `to[]` MUST be non-zero.
     * - All addresses in `to[]` MUST have the token `id` under `_pendings`.
     * - All addresses in `to[]` MUST not own a token type under `id`.
     *
     * Emits a {TransfersMulti} event.
     *
     */
    function batchTransfer(
        address from,
        address[] memory to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) external;
}
