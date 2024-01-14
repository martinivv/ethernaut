// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {Vault} from "./Vault.sol";

contract VaultFactory is Level(msg.sender) {
    function createInstance(address) public payable override returns (address instanceAddr) {
        instanceAddr = address(new Vault(bytes32("secret")));
    }

    function validateInstance(address payable _instance, address) public view override returns (bool success) {
        success = !Vault(_instance).locked();
    }
}
