// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
struct Point {
    uint x;
    uint y;
}
// 事件不允许定义在合约之外
// event Greeting(string);
error Unauthorized(address caller);
string constant greeting = "hell world";
function add(uint x, uint y) pure returns (uint) {
    return x + y;
}

contract Foo {
    string public name = "Foo";
}
