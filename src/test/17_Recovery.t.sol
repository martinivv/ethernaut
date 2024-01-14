// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {RecoveryFactory, Recovery} from "../levels/17_Recovery/RecoveryFactory.sol";
import {HelperRecovery} from "../levels/17_Recovery/HelperRecovery.sol";

contract TestRecovery is Tests {
    Recovery private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new RecoveryFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance{value: 0.001 ether}());
        level = Recovery(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        HelperRecovery helper = new HelperRecovery();
        helper.takeOutValue(levelAddress);

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
