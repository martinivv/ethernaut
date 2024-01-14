// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {GatekeeperOneFactory, GatekeeperOne} from "../levels/13_GatekeeperOne/GatekeeperOneFactory.sol";
import {HackGatekeeperOne} from "../levels/13_GatekeeperOne/HackGatekeeperOne.sol";

contract TestGatekeeperOne is Tests {
    GatekeeperOne private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new GatekeeperOneFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = GatekeeperOne(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        HackGatekeeperOne hack = new HackGatekeeperOne();
        hack.attack(levelAddress);
        assertEq(level.entrant(), PLAYER);

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
