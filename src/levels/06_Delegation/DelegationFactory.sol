// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {Delegate, Delegation} from "./Delegation.sol";

contract DelegationFactory is Level(msg.sender) {
    address immutable delegateAddress;

    constructor() {
        delegateAddress = address(new Delegate(msg.sender));
    }

    function createInstance(address) public payable override returns (address instanceAddr) {
        instanceAddr = address(new Delegation(delegateAddress));
    }

    function validateInstance(address payable _instance, address _player) public view override returns (bool success) {
        success = Delegation(_instance).owner() == _player;
    }
}
