# Degen-Token-Redefining-Gaming-on-Avalanche


Welcome to the Degen Token project! Degen Token is an ERC-20 token on the Avalanche network, designed to enhance the gaming experience with innovative features like token minting, transfers, and in-game redemptions.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Getting Started](#getting-started)
- [Installation](#installation)
- [Deployment](#deployment)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Degen Token aims to revolutionize the gaming landscape by providing a versatile digital asset that integrates seamlessly across various platforms. By adhering to ERC-20 standards, Degen Token ensures compatibility and usability, creating a dynamic and rewarding gaming ecosystem.

## Features

- **Token Minting:** Ability to create new tokens and distribute them.
- **Token Transfers:** Players can transfer tokens to other users.
- **In-Game Redemptions:** Redeem tokens for in-game items.
- **Token Burning:** Allows burning of tokens that are no longer needed.
- **Balance Check:** Players can check their token balance at any time.

## Getting Started

### Prerequisites

Ensure you have the following installed:

- Node.js
- npm
- Visual Studio Code (or any preferred code editor)

### Running the Program

To run this program, use [Remix Ethereum IDE](https://remix.ethereum.org/#lang=en&optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.23+commit.f704f362.js) or Gitpod for an online development environment.

### File Setup

Save the smart contract code in a file named `DegenToken.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    
    uint256 public constant REWARD_RATE = 100;
    mapping(address => uint256) public itemsOwned;

    constructor() ERC20("Degen", "DGN") {
        _mint(msg.sender, 10 * (10 ** uint256(decimals())));
    }

    function redeemItem(uint256 quantity) public {
        uint256 cost = REWARD_RATE * quantity;
        require(balanceOf(msg.sender) >= cost, "Insufficient tokens to redeem item");
        itemsOwned[msg.sender] += quantity;
        _burn(msg.sender, cost);
    }

    function checkItemsOwned(address user) public view returns (uint256) {
        return itemsOwned[user];
    }

    function mintTokens(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function burnTokens(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient tokens to burn");
        _burn(msg.sender, amount);
    }

    function transferTokens(address to, uint256 amount) public {
        require(to != address(0), "Invalid address");
        require(balanceOf(msg.sender) >= amount, "Insufficient tokens to transfer");
        _transfer(msg.sender, to, amount);
    }
}
```

## Deployment

### Hardhat Configuration

Update your `hardhat.config.js`:

```javascript
require("@nomicfoundation/hardhat-toolbox");

const FORK_FUJI = false;
const FORK_MAINNET = false;
let forkingData = undefined;

if (FORK_MAINNET) {
  forkingData = {
    url: "https://api.avax.network/ext/bc/C/rpcc",
  };
}
if (FORK_FUJI) {
  forkingData = {
    url: "https://api.avax-test.network/ext/bc/C/rpc",
  };
}

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  etherscan: {
    apiKey: "your snowtrace api key here",
  },
  networks: {
    hardhat: {
      gasPrice: 225000000000,
      chainId: !forkingData ? 43112 : undefined, 
      forking: forkingData,
    },
    fuji: {
      url: "https://api.avax-test.network/ext/bc/C/rpc",
      gasPrice: 225000000000,
      chainId: 43113,
      accounts: ["your private key here"],
    },
    mainnet: {
      url: "https://api.avax.network/ext/bc/C/rpc",
      gasPrice: 225000000000,
      chainId: 43114,
      accounts: ["your private key here"],
    },
  },
};
```

### Deploying the Contract

Run the following command in your terminal:

```sh
npx hardhat run scripts/deploy.js --network fuji
```

Verify the contract deployment on [Snowtrace](https://snowtrace.io).

## Usage

### Local Development

To set up the project locally:

1. Open two additional terminals in VS Code.
2. In the second terminal, start Hardhat node:
   ```sh
   npx hardhat node
   ```
3. In the third terminal, deploy the contract locally:
   ```sh
   npx hardhat run --network localhost scripts/deploy.js
   ```
4. In the first terminal, launch the frontend:
   ```sh
   npm run dev
   ```

The project should now be running on `http://localhost:3000`.




This project is licensed under the MIT License.

---

Feel free to modify this template as per your project specifics and requirements.
