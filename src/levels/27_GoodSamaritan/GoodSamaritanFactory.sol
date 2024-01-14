// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {GoodSamaritan} from "./GoodSamaritan.sol";

contract GoodSamaritanFactory is Level(msg.sender) {
    function createInstance(address) public payable override returns (address instanceAddr) {
        instanceAddr = address(new GoodSamaritan());
    }

    function validateInstance(address payable _instance, address) public view override returns (bool success) {
        GoodSamaritan instance = GoodSamaritan(_instance);
        address walletAddr = address(instance.wallet());
        success = walletAddr.balance == 0;
    }
}
