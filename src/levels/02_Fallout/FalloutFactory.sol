// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {Fallout} from "./Fallout.sol";

contract FalloutFactory is Level(msg.sender) {
    function createInstance(address) public payable override returns (address instanceAddr) {
        instanceAddr = address(new Fallout());
    }

    function validateInstance(address payable _instance, address _player) public view override returns (bool success) {
        success = Fallout(_instance).owner() == _player;
    }
}
