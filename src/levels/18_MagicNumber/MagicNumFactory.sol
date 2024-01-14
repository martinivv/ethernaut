// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {MagicNum} from "./MagicNum.sol";

interface ISolver {
    function whatIsTheMeaningOfLife() external view returns (bytes32);
}

contract MagicNumFactory is Level(msg.sender) {
    function createInstance(address) public payable override returns (address instanceAddr) {
        instanceAddr = address(new MagicNum());
    }

    function validateInstance(address payable _instance, address) public view override returns (bool) {
        MagicNum instance = MagicNum(_instance);
        ISolver solver = ISolver(instance.solver());

        bytes32 magic = solver.whatIsTheMeaningOfLife();
        if (magic != 0x000000000000000000000000000000000000000000000000000000000000002a) return false;
        uint256 size;
        assembly {
            size := extcodesize(solver)
        }
        if (size > 10) return false;

        return true;
    }
}
