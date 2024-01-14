// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {GoodSamaritanFactory, GoodSamaritan} from "../levels/27_GoodSamaritan/GoodSamaritanFactory.sol";
import {GoodSamaritanHack} from "../levels/27_GoodSamaritan/GoodSamaritanHack.sol";

contract TestGoodSamaritan is Tests {
    GoodSamaritan private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new GoodSamaritanFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = GoodSamaritan(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        GoodSamaritanHack hack = new GoodSamaritanHack(levelAddress);
        hack.attack();

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
