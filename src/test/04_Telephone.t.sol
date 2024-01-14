// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {TelephoneFactory, Telephone} from "../levels/04_Telephone/TelephoneFactory.sol";
import {HackTelephone} from "../levels/04_Telephone/HackTelephone.sol";

contract TestTelephone is Tests {
    Telephone private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new TelephoneFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = Telephone(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        HackTelephone hack = new HackTelephone();
        hack.attack(levelAddress);
        assertEq(level.owner(), PLAYER);

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
