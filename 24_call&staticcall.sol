/*
call&staticcall

详见：https://medium.com/coinmonks/call-staticcall-and-delegatecall-1f0e1853340

call 是一种底层调用合约的方式，可以在合约内调用其他合约，call语法为：

(bool success, bytes memory data) = addr.call{value: valueAmt, gas: gasAmt}(abi.encodeWithSignature("foo(string,uint256)", 参数1, 参数2)
其中：
1. success：执行结果，一定要校验success是否成功，失败务必要回滚
2. data：执行调用的返回值，是打包的字节序:
    {
        "0": "bool true",
        "1": "bytes: 0x00000000000000000000000000000000002",
    }
3. 需要解析才能得到调用函数的返回值: 
    abi.decode(data, (uint256))

当调用fallback方式给合约转ether的时候，**建议使用call**，而不是使用transfer或send方法

(bool success, bytes memory data) = addr.call{value: 10}("")


对于不存在的方法，不建议使用call方式调用。
(bool success, bytes memory data) = _addr.call(abi.encodeWithSignature("doesNotExist()"));

**调用不存在的方法（又不存在fallback）时，交易会调用成功，但是第一个参数为：false。**

*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Called {
    uint public number;

    // 无返回值
    function increment() public {
        number++;
    }

    // 有返回值
    function increment2(uint _increment) public returns (uint) {
        number = number + _increment;
        return number;
    }

    // 不修改值
    function getNumber() public view returns (uint) {
        return number;
    }
}

contract Caller {
    address public called = 0xd9145CCE52D386f254917e481eB44e9943F39138; // 是Called合约的地址

    // 无返回值
    function callCalled() public returns(bool, bytes memory) {   
        (bool success,bytes memory data) = called.call(abi.encodeWithSignature("increment()"));
        return (success, data);
    }

    // 有返回值 bytes
    function callCalled2() public returns(bool, bytes memory) {
        (bool success,bytes memory data) = called.call(abi.encodeWithSignature("increment2(uint256)",2));
        return (success, data);
    }

    // 返回值解密 bytes => uint
    function callCalled3() public returns(bool, uint) {
        (bool success,bytes memory data) = called.call(abi.encodeWithSignature("increment2(uint256)",2)); 
        uint decoded = abi.decode(data, (uint256));
        return (success, decoded);
    }

    // Sending Ether
    function sendingEther() public returns(bool, bytes memory) {
        (bool success,bytes memory data) = called.call{value: 1 ether, gas: 10000}(""); 
        return (success, data);
    }

    // STATICCALL
    // This is basically the same as call, but will revert if the called function modifies the state in any way.
    function getNumber() public view returns(bool, bytes memory) {
        (bool success,bytes memory data) = called.staticcall(abi.encodeWithSignature('getNumber()', '')); 
        return (success, data);
    }
    
}
