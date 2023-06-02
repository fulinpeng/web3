// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "./15_temp.sol";

contract D is B, C {
    // Try:
    // - Call D.foo and check the transaction logs.
    //   Although D inherits A, B and C, it only called C and then A.


    function foo() public override(B, C) {
        emit Log("D.foo called");
        super.foo();
    }

  	// Try:
    // - Call D.bar and check the transaction logs
    //   D called C, then B, and finally A.
    //   Although super was called twice (by B and C) it only called A once.
    function bar() public override(B, C) {
        emit Log("D.bar called");
        super.bar();
    }
}
// 详细解析：

// 1. D调用foo的时候，由于B，C中的foo都没有使用super，所以只是覆盖问题，根据最远继承，C覆盖了B，所以执行顺序为：D -> C -> A；
// 2. D调用bar的时候，由于B，C中的bar使用了super，此时D的两个parent都需要执行一遍，因此为D-> C -> B -> A
// 整个过程中A合约只会被调用一次。具体原因是Solidity借鉴了Python的方式，强制一个由基类构成的DAG（有向无环图）使其保证一个特定的顺序
