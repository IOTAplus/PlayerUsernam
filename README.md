# PlayerUsername Smart Contract

## Overview

The `PlayerUsername` smart contract is designed to manage a mapping of Ethereum addresses to unique usernames. This contract serves as a fundamental component for decentralized applications (dApps) that require a human-friendly way to identify users by their Ethereum addresses. It ensures that each username is distinct and provides methods to set, update, and retrieve usernames.

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Contract Functions](#contract-functions)
   - [setUsername](#setusername)
   - [getUsername](#getusername)
   - [getNumberOfPlayers](#getnumberofplayers)
   - [getAddressOfUsername](#getaddressofusername)
4. [How to Use in Remix](#how-to-use-in-remix)
5. [Use Cases](#use-cases)
6. [Notes and Best Practices](#notes-and-best-practices)
7. [Contributing](#contributing)

## Features

- **Set and Update Usernames**: Allows users to set and update their usernames tied to Ethereum addresses.
- **Unique Usernames**: Enforces the uniqueness of usernames across all users.
- **Retrieve Usernames**: Provides functionality to retrieve the username associated with a specific Ethereum address.
- **Retrieve Address by Username**: Offers a way to find the Ethereum address associated with a given username.
- **User Count**: A utility function to count the total number of users who have set usernames.

## Contract Functions

### `setUsername`

#### Description
Sets or updates the username for a given Ethereum address.

#### Parameters
- `_user`: `address` - The Ethereum address for which the username is being set.
- `_username`: `string` - The desired username.

#### Conditions
- The username must be 4 to 15 characters in length.
- Only alphanumeric characters are allowed.
- Each username must be unique.

#### Usage
Used to assign or change a username for an Ethereum address. If the username is already taken, the transaction is reverted.

### `getUsername`

#### Description
Retrieves the username associated with the specified Ethereum address.

#### Parameters
- `_user`: `address` - The Ethereum address whose username is being queried.

#### Returns
`string` - The username associated with the given address.

### `getNumberOfPlayers`

#### Description
Returns the total number of users who have set usernames.

#### Returns
`uint` - The count of users with usernames.

### `getAddressOfUsername`

#### Description
Retrieves the Ethereum address associated with a given username.

#### Parameters
- `_username`: `string` - The username for which the associated address is being queried.

#### Returns
`address` - The Ethereum address associated with the specified username.

## How to Use in Remix

1. **Deployment**:
   - Open [Remix IDE](https://remix.ethereum.org/).
   - Paste the contract code in a new Solidity file.
   - Compile the contract using the Solidity compiler plugin.
   - Deploy the contract on your chosen network (mainnet, testnet, or local blockchain).

2. **Interacting with the Contract**:
   - Use the Remix interface to interact with the deployed contract.
   - Call the contract functions with appropriate parameters as needed.
   - View the transaction logs for emitted events.

## Use Cases

- **Decentralized Identity Management**: Mapping Ethereum addresses to human-readable usernames.
- **User Profile Management in dApps**: Managing user profiles and identities in decentralized applications.

## Notes and Best Practices

- Usernames are sensitive to letter casing.
- Ensure compliance with character and length restrictions when setting usernames.
- Consider network gas costs when interacting with contract functions.
- Regularly update and test the contract to ensure security and efficiency.

## Contributing

Contributions to the `PlayerUsername` smart contract are welcome. Please adhere to the following guidelines:

- **Issues and Suggestions**: Use the GitHub Issues section to report issues or suggest enhancements.
