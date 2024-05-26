
# VulnerableDailyLimitWallet Smart Contract

## Descripción

Este proyecto consiste en un contrato inteligente llamado VulnerableDailyLimitWallet, el cual implementa una billetera digital con un límite diario de retiro. El contrato permite a los usuarios depositar fondos, retirar fondos dentro del límite diario establecido y transferir fondos a otros usuarios. También incluye la capacidad de cambiar el límite diario, que solo está disponible para el propietario del contrato.
## Contenido

## VulnerableDailyLimitWallet tiene las siguientes características:

- Permite a los usuarios depositar fondos en la billetera.
- Permite a los usuarios retirar fondos dentro del límite diario establecido.
- Permite a los usuarios transferir fondos a otras direcciones.
- Incluye un mecanismo para cambiar el límite diario, accesible solo para el propietario del contrato.

El contrato está diseñado para ser simple y fácil de usar, pero presenta una vulnerabilidad que permite a un atacante adquirir el control del contrato y realizar retiros sin restricciones.

## Descripción del contrato
El contrato está diseñado para ser simple y fácil de usar, pero presenta una vulnerabilidad que permite a un atacante adquirir el control del contrato y realizar retiros sin restricciones.
## Funciones principales

#### Función deposit: 
Permite a los usuarios depositar fondos en la billetera. Los fondos depositados se agregan al saldo del remitente y se emite un evento Deposit para registrar la transacción.

#### Función withdraw(uint256 amount):
Permite a los usuarios retirar fondos de la billetera. Se verifica que el monto de retiro sea mayor que cero, que el saldo del remitente sea suficiente para cubrir el monto y que el monto de retiro no exceda el límite diario establecido. Si todas las verificaciones pasan, se reduce el saldo del remitente, se registra el retiro y se transfiere el monto al remitente.

#### Función transfer(address to, uint256 amount): 
Permite a los usuarios transferir fondos a otra dirección. Se verifica que el monto de transferencia sea mayor que cero, que el saldo del remitente sea suficiente para cubrir el monto y que la dirección de destino no sea nula. Si todas las verificaciones pasan, se reduce el saldo del remitente y se incrementa el saldo del destinatario.

#### Función getBalance(): 
Permite a los usuarios consultar su saldo actual en la billetera.

#### Función setDailyLimit(uint256 newLimit): 
Permite al propietario del contrato cambiar el límite diario de retiro.

#### Función canWithdraw(address user, uint256 amount): 
Verifica si un usuario puede retirar la cantidad especificada sin exceder el límite diario. Esta función se utiliza internamente en la función de retiro.
## Eventos
- Deposit: Se emite cuando un usuario realiza un depósito.
- Withdrawal: Se emite cuando un usuario realiza un retiro.
## Requisitos

### IDE

Se recomienda utilizar un entorno de desarrollo integrado (IDE) como Visual Studio Code o Remix para interactuar con el contrato, además es necesario instalar la extensiones de solídity para un desarrollo óptimo.

## ¿Por qué Foundry?
- Es un framework rápido y eficiente.
- Permite escribir tests y scripts directamente en Solidity.
- Incluye múltiples cheatcodes para testing y debugging.





## Instalación de Foundry
## Paso a Paso

Instalación básica:

```bash
  curl -L https://foundry.paradigm.xyz | bash
```
Añadir Foundry al PATH:

```bash
  source /home/user/.bashrc 
  foundryup
```
Añadir Foundry al PATH:

```bash
forge --version
```

## Instalación

### Clonar el repositorio:

```bash
git clone https://github.com/tu-repo/VulnerableBank.git
cd VulnerableBank

```
### Instalar dependencias:

```bash
forge install foundry-rs/forge-std --no-commit
```

### Compilar el proyecto:

```bash
forge build

```
## Ejecución de Test
Para ejecutar los tests, utilizamos Foundry. Los tests se encuentran en la carpeta /test y validan el funcionamiento de las funciones principales del contrato.

### Comandos de Ejecución

### · Ejecutar todos los tests:
```bash
forge test -vvvv

```
## Tests Incluidos
El contrato VulnerableDailyLimitWallet viene con un conjunto de pruebas diseñadas para demostrar su funcionamiento y exponer la vulnerabilidad presente en el contrato.

Las pruebas están diseñadas para:

Probar la funcionalidad básica del contrato, como depositar, retirar y transferir fondos.
Mostrar cómo un atacante puede adquirir el control del contrato y realizar retiros sin restricciones.
## Seguridad

El contrato está diseñado para ser un ejemplo educativo y contiene varias vulnerabilidades que pueden ser explotadas. Se recomienda revisar el contrato y realizar una auditoría exhaustiva antes de utilizarlo en un entorno de producción.

### Posibles Vulnerabilidades

* Desbordamiento de enteros: Usar una versión anterior a Solidity 0.8.0 puede permitir desbordamientos de enteros.
* Acceso no autorizado: Asegurarse de que las funciones críticas están adecuadamente protegidas.
* Reentrancy Attack: Verificar que las funciones de retiro son seguras contra ataques de reentrada.
## Conclusión
El contrato VulnerableDailyLimitWallet es un ejemplo de cómo una aparentemente simple funcionalidad puede contener vulnerabilidades si no se implementa correctamente. Es fundamental realizar una auditoría exhaustiva de los contratos inteligentes para identificar y corregir posibles vulnerabilidades antes de desplegarlos en la red principal.

Espero que esta guía te haya sido útil para entender el proyecto y cómo ejecutar las pruebas. Si tienes alguna pregunta o sugerencia, no dudes en contactar con el equipo de desarrollo. ¡Gracias por tu interés en la seguridad de los contratos inteligentes!