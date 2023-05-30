
// - 常用单位为：wei，gwei，ether
// - 不含任何后缀的默认单位是 wei
// - 1 gwei = 10^9 wei
// - 1 ther = 10^9 gwei


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EtherUnits {
    uint256 public oneWei = 1 wei;
    // 1 wei is equal to 1
    bool public isOneWei = 1 wei == 1;
    // 1 gwei is equal to 10^9 wei
    bool public isOneGwei = 1 gwei == 1e9;
    // 1 ether is equal to 10^18 wei
    bool public isOneEther = 1 ether == 1e18;

    uint256 public oneGwei = 1e9 gwei;
    bool public isEtherToGwei = 1 ether == oneGwei;
}
