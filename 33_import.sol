/**
    我们可以使用import将本地的.sol文件或外部（github或openzeppelin等）.sol导入进来
    ```js
        ├── Import.sol
        └── Foo.sol
    ```
    Fool.sol
    常量、函数、枚举、结构体、Error可以定义在合约之外；
    事件、变量不允许定义在合约之外
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./33_Foo.sol";

import {Unauthorized, add as func, Point} from "./33_Foo.sol";
contract Import {
    // Initialize Foo.sol
    Foo public foo = new Foo();

    // Test Foo.sol by getting it's name.
    function getFooName() public view returns (string memory) {
        return foo.name();
    }

    function myAdd() public pure returns(uint) {
        return func(1,2);
    }

    function greetingCall() public pure returns(string memory) {
        return greeting;
    }
}
