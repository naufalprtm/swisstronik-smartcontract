# Swisstronik Smart Contract

Swisstronik is a Solidity contract designed for testing purposes. It allows an authorized owner to set and get a message stored on the blockchain. The contract includes mechanisms to protect against reentrancy attacks and ensures only the owner can modify the message.

## Features

- **Set Message**: Allows the owner to set a new message.
- **Get Message**: Allows anyone to retrieve the current message.
- **Ownership**: Only the owner can set a new message.
- **Reentrancy Protection**: Uses OpenZeppelin's `ReentrancyGuard` to prevent reentrancy attacks.

## Dependencies

To use this project, you need to have the following dependencies installed:

- [Node.js](https://nodejs.org/) (>=16)
- [Hardhat](https://hardhat.org/)
- [TypeScript](https://www.typescriptlang.org/)
- [OpenZeppelin Contracts](https://openzeppelin.com/contracts/)

## Installation

1. Clone the repository:

    ```sh
    git clone https://github.com/naufalprtm/swisstronik-smartcontract.git
    cd swisstronik-smartcontract
    ```

2. Install the dependencies:

    ```sh
    npm install
    ```

## Configuration

Create a `.env` file in the root of the project and add the following environment variables:

```
SWISSTRONIK_URL=<Your Swisstronik Node URL>
PRIVATE_KEY=<Your Private Key>
```

## Usage
Compile the Contract
To compile the contract, run:


```
npm run compile
```

Deploy the Contract
To deploy the contract to the Swisstronik network, run:

```
npm run deploy
```

Interact with the Contract
Get the Message
To retrieve the current message stored in the contract, run:

```
npm run get-message
```

Set a New Message
To set a new message, run:

```
npm run set-message -- <new-message>
```

Replace <new-message> with the message you want to store.

Contract Explanation
The Swisstronik contract is defined as follows:



```
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Swisstronik is ReentrancyGuard {
    string private message;
    address private owner;

    event MessageUpdated(string oldMessage, string newMessage);

    constructor(string memory _message) payable {
        message = _message;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function setMessage(string memory _message) public onlyOwner nonReentrant {
        string memory oldMessage = message;
        message = _message;
        emit MessageUpdated(oldMessage, _message);
    }

    function getMessage() public view returns (string memory) {
        return message;
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}
```


Constructor: Initializes the contract with an initial message and sets the deployer as the owner.
setMessage: Allows the owner to set a new message. Emits a MessageUpdated event.
getMessage: Retrieves the current message stored in the contract.
getOwner: Retrieves the owner address of the contract.
Contributing
If you would like to contribute, please fork the repository and use a feature branch. Pull requests are warmly welcome.
