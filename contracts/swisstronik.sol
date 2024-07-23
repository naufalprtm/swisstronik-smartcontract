// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { ReentrancyGuard } from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

// This contract is only intended for testing purposes
contract Swisstronik is ReentrancyGuard {
    string private message;
    address private owner;

    /**
     * @dev Emitted when the message is updated
     * @param oldMessage The old message before update
     * @param newMessage The new message after update
     */
    event MessageUpdated(string oldMessage, string newMessage);

    /**
     * @dev Constructor is used to set the initial message for the contract
     * @param _message The message to associate with the message variable.
     */
    constructor(string memory _message) payable {
        message = _message;
        owner = msg.sender;
    }

    /**
     * @dev Modifier to restrict functions to only the owner
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    /**
     * @dev setMessage() updates the stored message in the contract
     * @param _message The new message to replace the existing one
     */
    function setMessage(string memory _message) public onlyOwner nonReentrant {
        string memory oldMessage = message;
        message = _message;
        emit MessageUpdated(oldMessage, _message);
    }

    /**
     * @dev getMessage() retrieves the currently stored message in the contract
     * @return The message associated with the contract
     */
    function getMessage() public view returns (string memory) {
        return message;
    }

    /**
     * @dev getOwner() retrieves the owner address of the contract
     * @return The owner address of the contract
     */
    function getOwner() public view returns (address) {
        return owner;
    }
}
