// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {FalloutFactory, Fallout} from "../levels/02_Fallout/FalloutFactory.sol";

contract TestFallout is Tests {
    Fallout private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new FalloutFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = Fallout(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        level.Fal1out();

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
