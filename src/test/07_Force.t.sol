// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.17;

import {Tests} from "@core/Tests.sol";
import {ForceFactory, Force} from "../levels/07_Force/ForceFactory.sol";
import {HackForce} from "../levels/07_Force/HackForce.sol";

contract TestForce is Tests {
    Force private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new ForceFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = Force(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        new HackForce{value: 1 wei}(levelAddress);
        assertGt(levelAddress.balance, 0);

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
