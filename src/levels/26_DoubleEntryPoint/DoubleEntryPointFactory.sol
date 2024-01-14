// SPDX-License-Identifier: Unlicense
pragma solidity =0.8.23;

import {Level} from "@core/Level.sol";
import {DoubleEntryPoint, LegacyToken, Forta, CryptoVault, DelegateERC20, IERC20} from "./DoubleEntryPoint.sol";

contract DoubleEntryPointFactory is Level(msg.sender) {
    function createInstance(address _player) public payable override returns (address newTokenAddr) {
        LegacyToken oldToken = new LegacyToken();
        Forta forta = new Forta();
        CryptoVault vault = new CryptoVault(_player);
        DoubleEntryPoint newToken = new DoubleEntryPoint(address(oldToken), address(vault), address(forta), _player);
        newTokenAddr = address(newToken);

        vault.setUnderlying(newTokenAddr);
        oldToken.delegateToNewContract(DelegateERC20(address(newToken)));
        oldToken.mint(address(vault), 100 ether);
    }

    function validateInstance(address payable _instance, address _player) public override returns (bool success) {
        DoubleEntryPoint instance = DoubleEntryPoint(_instance);
        Forta forta = instance.forta();

        address usersDetectionBot = address(forta.usersDetectionBots(_player));
        if (usersDetectionBot == address(0)) return false;

        address vault = instance.cryptoVault();
        CryptoVault cryptoVault = CryptoVault(vault);
        (bool ok, bytes memory data) = this.__trySweep(cryptoVault, instance);
        if (ok) revert();
        bool swept = abi.decode(data, (bool));
        return swept;
    }

    function __trySweep(CryptoVault cryptoVault, DoubleEntryPoint instance) external returns (bool, bytes memory) {
        try cryptoVault.sweepToken(IERC20(instance.delegatedFrom())) {
            return (true, abi.encode(false));
        } catch {
            return (false, abi.encode(instance.balanceOf(instance.cryptoVault()) > 0));
        }
    }
}
