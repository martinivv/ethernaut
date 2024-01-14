// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {PuzzleWallet, PuzzleProxy} from "./PuzzleWallet.sol";

contract PuzzleWalletFactory is Level(msg.sender) {
    function createInstance(address) public payable override returns (address instanceAddr) {
        if (msg.value != 0.001 ether) revert(); // We should store 0.001 ether in the proxy

        PuzzleWallet walletLogic = new PuzzleWallet();
        bytes memory data = abi.encodeWithSelector(PuzzleWallet.init.selector, 100 ether);
        PuzzleProxy proxy = new PuzzleProxy(address(this), address(walletLogic), data);
        instanceAddr = address(proxy);

        PuzzleWallet instance = PuzzleWallet(instanceAddr);
        instance.addToWhitelist(address(this));
        instance.deposit{value: msg.value}();
    }

    function validateInstance(address payable _instance, address _player) public view override returns (bool success) {
        success = PuzzleProxy(_instance).admin() == _player;
    }
}
