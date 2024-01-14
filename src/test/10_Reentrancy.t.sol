// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {ReentranceFactory, Reentrance} from "../levels/10_Reentrance/ReentranceFactory.sol";
import {HackReentrance} from "../levels/10_Reentrance/HackReentrance.sol";

contract TestReentrancy is Tests {
    Reentrance private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new ReentranceFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = Reentrance(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        HackReentrance hack = new HackReentrance(levelAddress);
        hack.attack{value: 1 ether}();
        assertEq(levelAddress.balance, 0);

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
