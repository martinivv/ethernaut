// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {Fallback} from "./Fallback.sol";

contract FallbackFactory is Level(msg.sender) {
    function createInstance(address) public payable override returns (address instanceAddr) {
        instanceAddr = address(new Fallback());
    }

    function validateInstance(address payable _instance, address _player) public view override returns (bool success) {
        Fallback instance = Fallback(_instance);
        success = instance.owner() == _player && address(instance).balance == 0;
    }
}
