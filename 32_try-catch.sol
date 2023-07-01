/*
    try/catch 仅可以捕捉在调用 external函数 或 创建合约 中抛出的异常信息
    没有错误信息的时候，直接使用 catch 比较稳妥，如果使用 reason ，会捕捉require发出的信息

    require() 声明失败应该被认为是正常和健壮的情况（跟 revert() 一样）；而当 assert() 声明失败时，则意味着有些东西失控了，需要修复代码中的问题
    Require相当于Revert校验失败会退回剩下的gas，而assert会烧掉所有的gas
    Require对比Revert，复杂时候用Revert
    require应该被最常使用到，一般用于函数的开头处，尽量少使用 assert 调用，如要使用assert 应该在函数结尾处使用
    如果有复杂的 if/else 逻辑流，那么应该考虑使用 revert() 函数而不是require()
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// External contract used for try / catch examples
contract Foo {
    address public owner;

    constructor(address _owner) {
        require(_owner != address(0), "invalid address");
        assert(_owner != 0x0000000000000000000000000000000000000001);
        owner = _owner;
    }

    function myFunc(uint x) public pure returns (string memory) {
        require(x != 0, "require failed");
        return "my func was called";
    }
}

contract Bar {
    event Log(string message);
    event LogBytes(bytes data);

    Foo public foo;

    constructor() {
        // This Foo contract is used for example of try catch with external call
        foo = new Foo(msg.sender);
    }

    // Example of try / catch with external call
    // tryCatchExternalCall(0) => Log("external call failed")
    // tryCatchExternalCall(1) => Log("my func was called")
    function tryCatchExternalCall(uint _i) public {
        try foo.myFunc(_i) returns (string memory result) {
            emit Log(result);
        } catch {
            emit Log("external call failed");
        }
    }

    // Example of try / catch with contract creation
    // tryCatchNewContract(0x0000000000000000000000000000000000000000) => Log("invalid address")
    // tryCatchNewContract(0x0000000000000000000000000000000000000001) => LogBytes("")
    // tryCatchNewContract(0x0000000000000000000000000000000000000002) => Log("Foo created")
    function tryCatchNewContract(address _owner) public {
        try new Foo(_owner) returns (Foo foo) {
            // you can use variable foo here
            emit Log("Foo created");
        } catch Error(string memory reason) {
            // catch failing revert() and require()
            emit Log(reason);
        } catch (bytes memory reason) {
            // catch failing assert()
            emit LogBytes(reason);
        }
    }
}
