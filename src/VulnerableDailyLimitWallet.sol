// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableDailyLimitWallet {
    mapping(address => uint256) private balances;
    mapping(address => uint256) private lastWithdrawalTime;
    mapping(address => uint256) private dailyWithdrawalAmount;


    uint256 public dailyLimit;


    // Evento para registrar depósitos
    event Deposit(address indexed user, uint256 amount);


    // Evento para registrar retiros
    event Withdrawal(address indexed user, uint256 amount);


    // Evento para registrar transferencias
    event Transfer(address indexed from, address indexed to, uint256 amount);


    // Función para depositar fondos
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }


    // Función para retirar fondos con un límite diario
    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdrawal amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(canWithdraw(msg.sender, amount), "Daily limit exceeded");


        balances[msg.sender] -= amount;
        dailyWithdrawalAmount[msg.sender] += amount;
        lastWithdrawalTime[msg.sender] = block.timestamp;


        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }


    // Función para transferir fondos a otro usuario
    function transfer(address to, uint256 amount) public {
        require(amount > 0, "Transfer amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(to != address(0), "Invalid recipient address");


        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }


    // Función para consultar el saldo del usuario
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }


    // Función para cambiar el límite diario, solo accesible por el propietario
    function setDailyLimit(uint256 newLimit) public {
        dailyLimit = newLimit;
    }


    // Función para verificar si el usuario puede retirar la cantidad especificada sin exceder el límite diario
    function canWithdraw(address user, uint256 amount) public view returns (bool) {
        if (block.timestamp > lastWithdrawalTime[user] + 1 days) {
            return amount <= dailyLimit;
        } else {
            return (dailyWithdrawalAmount[user] + amount) <= dailyLimit;
        }
    }


    // Recibir pagos
    receive() external payable {
        deposit();
    }
}
