// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {Privacy} from "./Privacy.sol";

contract PrivacyFactory is Level(msg.sender) {
    function createInstance(address) public payable override returns (address instanceAddr) {
        bytes32[3] memory data;
        data[0] = bytes32("1");
        data[1] = bytes32("2");
        data[2] = bytes32("3");

        instanceAddr = address(new Privacy(data));
    }

    function validateInstance(address payable _instance, address) public view override returns (bool success) {
        success = Privacy(_instance).locked() == false;
    }
}
