// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {Dex, SwappableToken, IERC20} from "./Dex.sol";

contract DexFactory is Level(msg.sender) {
    function createInstance(address _player) public payable override returns (address instanceAddr) {
        Dex instance = new Dex();
        instanceAddr = address(instance);

        SwappableToken tokenInstance = new SwappableToken(instanceAddr, "Token 1", "TKN1", 110);
        SwappableToken tokenInstanceTwo = new SwappableToken(instanceAddr, "Token 2", "TKN2", 110);
        address tokenInstanceAddress = address(tokenInstance);
        address tokenInstanceTwoAddress = address(tokenInstanceTwo);

        instance.setTokens(tokenInstanceAddress, tokenInstanceTwoAddress);
        tokenInstance.approve(instanceAddr, 100);
        tokenInstanceTwo.approve(instanceAddr, 100);
        instance.addLiquidity(tokenInstanceAddress, 100);
        instance.addLiquidity(tokenInstanceTwoAddress, 100);
        tokenInstance.transfer(_player, 10);
        tokenInstanceTwo.transfer(_player, 10);
    }

    function validateInstance(address payable _instance, address) public view override returns (bool success) {
        address token1 = Dex(_instance).token1();
        address token2 = Dex(_instance).token2();
        success = IERC20(token1).balanceOf(_instance) == 0 || IERC20(token2).balanceOf(_instance) == 0;
    }
}
