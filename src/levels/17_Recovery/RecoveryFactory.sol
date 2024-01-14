// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {Recovery} from "./Recovery.sol";

contract RecoveryFactory is Level(msg.sender) {
    address generatedTokenAddr;

    function createInstance(address) public payable override returns (address instanceAddr) {
        Recovery instance = new Recovery();

        instance.generateToken("FOO", 1);
        // Following the EIP161, contract accounts are initiated with nonce = 1
        generatedTokenAddr = address(
            uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), address(instance), bytes1(0x01)))))
        );
        (bool ok,) = generatedTokenAddr.call{value: 0.001 ether}("");
        require(ok);

        instanceAddr = address(instance);
    }

    function validateInstance(address payable, address) public view override returns (bool success) {
        success = generatedTokenAddr.balance == 0;
    }
}
