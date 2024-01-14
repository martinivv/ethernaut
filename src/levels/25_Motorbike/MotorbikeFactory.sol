// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {Motorbike, Engine} from "./Motorbike.sol";

contract MotorbikeFactory is Level(msg.sender) {
    function createInstance(address) public payable override returns (address implementationAddr) {
        implementationAddr = address(new Engine());
        new Motorbike(address(implementationAddr));
    }

    function validateInstance(address payable, address) public pure override returns (bool success) {
        success = true;
    }
}
