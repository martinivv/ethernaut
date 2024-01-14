// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {IDetectionBot, IForta} from "./DoubleEntryPoint.sol";

contract DetectionBot is IDetectionBot {
    address private monitoredSource;
    bytes private monitoredSig;

    constructor(address _monitoredSource, bytes memory _monitoredSig) {
        monitoredSource = _monitoredSource;
        monitoredSig = _monitoredSig;
    }

    function handleTransaction(address user, bytes calldata msgData) external override {
        (,, address origSender) = abi.decode(msgData[4:], (address, uint256, address));
        bytes memory callSig = abi.encodePacked(msgData[0], msgData[1], msgData[2], msgData[3]);
        if (origSender == monitoredSource && keccak256(callSig) == keccak256(monitoredSig)) {
            IForta(msg.sender).raiseAlert(user);
        }
    }
}
