// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "../core/Tests.sol";
import {MagicNumFactory, MagicNum} from "../levels/18_MagicNumber/MagicNumFactory.sol";

contract TestMagicNum is Tests {
    MagicNum private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new MagicNumFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = MagicNum(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        address solverInstance;
        assembly {
            let ptr := mload(0x40)
            mstore(ptr, shl(0x68, 0x69602A60005260206000F3600052600A6016F3))
            solverInstance := create(0, ptr, 0x13)
        }
        level.setSolver(solverInstance);

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
