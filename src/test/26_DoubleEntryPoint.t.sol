// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {DoubleEntryPointFactory, DoubleEntryPoint} from "../levels/26_DoubleEntryPoint/DoubleEntryPointFactory.sol";
import {DetectionBot} from "../levels/26_DoubleEntryPoint/DetectionRobot.sol";

contract TestDoubleEntryPoint is Tests {
    DoubleEntryPoint private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new DoubleEntryPointFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = DoubleEntryPoint(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        DetectionBot bot =
            new DetectionBot(level.cryptoVault(), abi.encodeWithSignature("delegateTransfer(address,uint256,address)"));
        level.forta().setDetectionBot(address(bot));

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
