// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {Denial} from "./Denial.sol";

contract DenialFactory is Level(msg.sender) {
    function createInstance(address) public payable override returns (address instanceAddr) {
        if (msg.value < 0.001 ether) revert();

        instanceAddr = address(new Denial());
        (bool ok,) = instanceAddr.call{value: msg.value}("");
        if (!ok) revert();
    }

    function validateInstance(address payable _instance, address) public override returns (bool) {
        Denial instance = Denial(_instance);
        if (address(instance).balance <= 100 wei) return false;

        // Must revert
        (bool notOkay,) = address(instance).call{gas: 1000000}(abi.encodeWithSignature("withdraw()"));
        return !notOkay;
    }
}
