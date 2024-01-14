// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {GatekeeperTwoFactory, GatekeeperTwo} from "../levels/14_GatekeeperTwo/GatekeeperTwoFactory.sol";
import {HackGatekeeperTwo} from "../levels/14_GatekeeperTwo/HackGatekeeperTwo.sol";

contract TestGatekeeperTwo is Tests {
    GatekeeperTwo private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new GatekeeperTwoFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = GatekeeperTwo(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        new HackGatekeeperTwo(level);
        assertEq(level.entrant(), PLAYER);

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
