// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {Token} from "./Token.sol";

contract TokenFactory is Level(msg.sender) {
    uint256 constant INITIAL_SUPPLY = 10_000;
    uint256 constant PLAYER_SUPPLY = 20;

    function createInstance(address _player) public payable override returns (address instanceAddr) {
        Token instance = new Token(INITIAL_SUPPLY);
        instance.transfer(_player, PLAYER_SUPPLY);
        instanceAddr = address(instance);
    }

    function validateInstance(address payable _instance, address _player) public view override returns (bool success) {
        success = Token(_instance).balanceOf(_player) > 20;
    }
}
