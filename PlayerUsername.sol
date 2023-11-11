// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PlayerUsername {
    // Mapping from Ethereum addresses to usernames
    mapping(address => string) private usernames;

    // Reverse mapping from usernames to Ethereum addresses
    mapping(string => address) private usernameToAddress;

    // Array to keep track of addresses that have set a username
    address[] private userAddresses;

    // Mapping to keep track if an address has already been added to userAddresses
    mapping(address => bool) private addressAdded;

    // Event that is emitted when a username is set
    event UsernameSet(address indexed user, string username);

    function isValidUsername(string memory _username) internal pure returns (bool) {
        bytes memory b = bytes(_username);
        if(b.length < 4 || b.length > 15) return false; // Length check
        for(uint i = 0; i < b.length; i++){
            bytes1 char = b[i];
            if(!(char >= 0x30 && char <= 0x39) && // 0-9
            !(char >= 0x41 && char <= 0x5A) && // A-Z
            !(char >= 0x61 && char <= 0x7A))   // a-z
            return false;
        }
        return true;
    }
    function setUsername(address _user, string memory _username) external {
    // Check if the username is valid
    require(isValidUsername(_username), "Invalid username");

    // Check if the username is already taken
    require(usernameToAddress[_username] == address(0) || usernameToAddress[_username] == _user, "Username already taken");

    if (!addressAdded[_user]) {
        userAddresses.push(_user);
        addressAdded[_user] = true;
    }
    usernames[_user] = _username;
    usernameToAddress[_username] = _user;
    emit UsernameSet(_user, _username);
}

    function getUsername(address _user) external view returns (string memory) {
        return usernames[_user];
    }

    // View function to get the number of players
    function getNumberOfPlayers() external view returns (uint) {
        return userAddresses.length;
    }

    // View function to get the address associated with a username
    function getAddressOfUsername(string memory _username) external view returns (address) {
        return usernameToAddress[_username];
    }
}