// Inheritance、virtual、override

// 1. 合约之间存在继承关系，使用关键字：is
// 2. 如果父合约的方法想被子合约继承，则需要使用关键字：virtual
// 3. 如果子合约想覆盖父合约的方法，则需要使用关键字：override
// 4. 在子合约中如果想调用父合约的方法，需要使用关键字：super
// 5. 继承的顺序很重要，遵循最远继承，即后面继承的合约会覆盖前面父合约的方法
// 6. super会调用继承链条上的每一个合约的相关函数，而不仅仅是最近的父合约

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/* Inheritance tree
   A
 /  \
B   C
 \ /
  D
*/

contract A {
    // This is called an event. You can emit events from your function
    // and they are logged into the transaction log.
    // In our case, this will be useful for tracing function calls.
    event Log(string message);

    function foo() public virtual {
        emit Log("A.foo called");
    }

    function bar() public virtual {
        emit Log("A.bar called");
    }
}

contract B is A {
    // 重写的方法，还可以被其子代重写
    function foo() public virtual override {
        emit Log("B.foo called");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("B.bar called");
        super.bar();
    }
}

contract C is A {
    function foo() public virtual override {
        emit Log("C.foo called");
        A.foo();
    }

    function bar() public virtual override {
        emit Log("C.bar called");
        super.bar();
    }
}
