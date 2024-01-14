// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {GatekeeperOne} from "./GatekeeperOne.sol";

contract GatekeeperOneFactory is Level(msg.sender) {
    function createInstance(address) public payable override returns (address instanceAddr) {
        instanceAddr = address(new GatekeeperOne());
    }

    function validateInstance(address payable _instance, address _player) public view override returns (bool success) {
        success = GatekeeperOne(_instance).entrant() == _player;
    }
}
