// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {DenialFactory, Denial} from "../levels/20_Denial/DenialFactory.sol";
import {Hack} from "../levels/20_Denial/Hack.sol";

contract TestDenial is Tests {
    Denial private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new DenialFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance{value: 0.001 ether}());
        level = Denial(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        Hack hack = new Hack(level);
        assertTrue(level.partner() == address(hack));

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
