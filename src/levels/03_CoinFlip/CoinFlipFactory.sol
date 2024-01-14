// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {CoinFlip} from "./CoinFlip.sol";

contract CoinFlipFactory is Level(msg.sender) {
    function createInstance(address) public payable override returns (address instanceAddr) {
        instanceAddr = address(new CoinFlip());
    }

    function validateInstance(address payable _instance, address) public view override returns (bool success) {
        success = CoinFlip(_instance).consecutiveWins() >= 10;
    }
}
