// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {KingFactory, King} from "../levels/09_King/KingFactory.sol";
import {HackKing} from "../levels/09_King/HackKing.sol";

contract TestKing is Tests {
    King private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new KingFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance{value: 1 ether}());
        level = King(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        HackKing hack = new HackKing();
        hack.attack{value: 1 ether}(levelAddress);
        assertEq(level._king(), address(hack));

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
