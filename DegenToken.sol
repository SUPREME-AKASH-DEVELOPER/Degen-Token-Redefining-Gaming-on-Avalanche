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
