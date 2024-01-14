// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {Shop} from "./Shop.sol";

contract ShopFactory is Level(msg.sender) {
    function createInstance(address) public payable override returns (address instanceAddr) {
        instanceAddr = address(new Shop());
    }

    function validateInstance(address payable _instance, address) public view override returns (bool success) {
        success = Shop(_instance).isSold();
    }
}
