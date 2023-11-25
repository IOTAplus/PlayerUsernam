// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PlayerUsername {
    // Mapping from Ethereum addresses to usernames
    mapping(address => string) private usernames;

    // Reverse mapping from usernames to Ethereum addresses
    mapping(string => address) private usernameToAddress;

    // Mapping to keep track of addresses that have set a username
    mapping(address => address) private userAddresses;

    mapping(string => uint256) private namesById;
    mapping(string => bool) private flag;

    uint256 private totalPlayers;

    // Event that is emitted when a username is set
    event UsernameSet(address indexed user, string username);

    function isValidUsername(string memory _username) internal pure returns (bool) {
        bytes memory b = bytes(_username);
        uint256 len = b.length;
        if (len < 4 || len > 15) return false; // Length check
        bytes1 char;
        unchecked {
            for (uint i; i < len; i++) {
                char = b[i];
                if (!(char >= 0x30 && char <= 0x39) &&  // 0-9
                    !(char >= 0x41 && char <= 0x5A) && // A-Z
                    !(char >= 0x61 && char <= 0x7A))  // a-z
                    return false;
            }
        }
        return true;
    }

    function setUsername(string memory _username) external {
        // Check that msg.sender can not have more than one username
        if (userAddresses[msg.sender] != address(0)) revert("already have one.");
        // Check if the username is taken (global)
        if (flag[_username]) revert("username already taken.");
        // Check if the username is valid
        if (!isValidUsername(_username)) revert("invalid username.");

        namesById[_username] = totalPlayers;
        usernames[msg.sender] = _username;
        userAddresses[msg.sender] = msg.sender;
        usernameToAddress[_username] = msg.sender;
        flag[_username] = true;

        totalPlayers++;
        emit UsernameSet(msg.sender, _username);
    }

    function changeUsername(string memory _oldUserName, string memory _newUsername) external {
        if (keccak256(bytes(_oldUserName)) == keccak256(bytes(_newUsername))) revert("same username.");
        if (!isValidUsername(_newUsername)) revert("invalid username.");
        if (usernameToAddress[_oldUserName] != msg.sender) revert("owner dont match.");
        if (flag[_newUsername]) revert("username already taken.");

        uint256 id = namesById[_oldUserName];

        namesById[_newUsername] = id;
        usernames[msg.sender] = _newUsername;

        delete flag[_oldUserName];
        flag[_newUsername] = true;

        delete usernameToAddress[_oldUserName];
        usernameToAddress[_newUsername] = msg.sender;

	    emit UsernameSet(msg.sender, _newUsername);
    }

    function getUsername(address _user) external view returns (string memory) {
        return usernames[_user];
    }

    // View function to get the number of players
    function getNumberOfPlayers() external view returns (uint) {
        return totalPlayers;
    }

    // View function to get the address associated with a username
    function getAddressOfUsername(string memory _username) external view returns (address) {
        return usernameToAddress[_username];
    }
}