// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {Telephone} from "./Telephone.sol";

contract TelephoneFactory is Level(msg.sender) {
    function createInstance(address) public payable override returns (address instanceAddr) {
        instanceAddr = address(new Telephone());
    }

    function validateInstance(address payable _instance, address _player) public view override returns (bool success) {
        success = Telephone(_instance).owner() == _player;
    }
}
