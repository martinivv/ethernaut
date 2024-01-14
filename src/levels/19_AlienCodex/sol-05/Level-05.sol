// SPDX-License-Identifier: Unlicense
pragma solidity ^0.5.0;

import {Ownable} from "./Ownable-05.sol";

contract Level is Ownable {
    function createInstance(address _player) public payable returns (address instanceAddr);

    function validateInstance(address payable _instance, address _player) public returns (bool success);
}
