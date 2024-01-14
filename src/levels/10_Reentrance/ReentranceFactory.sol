// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {Reentrance} from "./Reentrance.sol";

contract ReentranceFactory is Level(msg.sender) {
    function createInstance(address) public payable override returns (address instanceAddr) {
        instanceAddr = address(new Reentrance());
    }

    function validateInstance(address payable _instance, address) public view override returns (bool success) {
        success = address(Reentrance(_instance)).balance == 0;
    }
}
