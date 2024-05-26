// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import "../src/VulnerableDailyLimitWallet.sol";

contract VulnerableDailyLimitWalletTest is Test {
    VulnerableDailyLimitWallet wallet;
    address user1;
    address user2;


    function setUp() public {
        wallet = new VulnerableDailyLimitWallet();
        user1 = address(10);
        user2 = address(20);


        vm.deal(user1, 10 ether);
        vm.deal(user2, 10 ether);
    }


    function testDeposit() public {
        vm.startPrank(user1);
        wallet.deposit{value: 1 ether}();
        assertEq(wallet.getBalance(), 1 ether);
        vm.stopPrank();
    }


    function testWithdraw() public {
        vm.startPrank(user1);
        wallet.deposit{value: 2 ether}();
        wallet.setDailyLimit(1 ether);
        vm.stopPrank();


        vm.warp(block.timestamp + 1 days); // Avanza el tiempo un día


        vm.startPrank(user1);
        wallet.withdraw(1 ether);
        assertEq(wallet.getBalance(), 1 ether);
        vm.stopPrank();
    }


    function testTransfer() public {
        vm.startPrank(user1);
        wallet.deposit{value: 2 ether}();
        wallet.transfer(user2, 1 ether);
        assertEq(wallet.getBalance(), 1 ether);
        vm.stopPrank();


        vm.startPrank(user2);
        // Para verificar el saldo de user2 en el contrato
        // Necesitamos acceder al balance de user2 en el contrato
        assertEq(wallet.getBalance(), 1 ether);
        vm.stopPrank();
    }


    function testSetDailyLimit() public {
        vm.startPrank(user1);
        wallet.setDailyLimit(2 ether);
        assertEq(wallet.dailyLimit(), 2 ether);
        vm.stopPrank();


        vm.startPrank(user2);
        wallet.setDailyLimit(3 ether);
        assertEq(wallet.dailyLimit(), 3 ether); // Verifica la vulnerabilidad
        vm.stopPrank();
    }


}

