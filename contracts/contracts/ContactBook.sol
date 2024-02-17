// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract ContactBook {
    address private owner;

    struct Contact {
        string name;
        address wallet;
    }

    Contact[] public contacts;

    event newContact(string indexed _name, address indexed _wallet);
    event contactRemoved(uint indexed _index);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract's owner can call this function.");
        _;
    }

    function addContact(string memory _name, address  _wallet) public onlyOwner {
        contacts.push(Contact(_name, _wallet));
        emit newContact(_name, _wallet);
    }

    function removeContact(uint _index) public onlyOwner {
        require( _index < contacts.length, "Invalid index");
        for (uint i = _index; i < contacts.length; i++) {
            contacts[i] = contacts[i + 1];
        }
        contacts.pop();

        emit contactRemoved(_index);
    }

    function getContacts() public view returns (Contact[] memory) {
        return contacts;
    }
}
