// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {ShopFactory, Shop} from "../levels/21_Shop/ShopFactory.sol";
import {ShopHack} from "../levels/21_Shop/ShopHack.sol";

contract TestShop is Tests {
    Shop private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new ShopFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance{value: 0.001 ether}());
        level = Shop(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        ShopHack hack = new ShopHack(levelAddress);
        hack.attack();
        assertTrue(level.isSold());

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
