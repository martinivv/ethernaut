// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {Force} from "./Force.sol";

contract ForceFactory is Level(msg.sender) {
    function createInstance(address) public payable override returns (address instanceAddr) {
        instanceAddr = address(new Force());
    }

    function validateInstance(address payable _instance, address) public view override returns (bool success) {
        success = address(Force(_instance)).balance > 0;
    }
}
