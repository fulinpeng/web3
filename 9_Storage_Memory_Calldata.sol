// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/**
storage：属于状态变量，数据会存储在链上，仅适用于所有引用类型：string，bytes，数组，结构体，mapping等；
memory：仅存储在内存中，供函数使用，数据不上链，适用于所有类型，包括：
      值类型（int，bool，bytes8等）
      引用类型（string，bytes，数组，结构体，mapping）
calldata：存储函数的参数的位置，是只读的（只有calldata支持数组切片，状态变量不可以直接使用切片，需要new新数组，然后使用for循环解决）

注意事项：
1. Solidity 变量中 memory 、calldata 作用非常类似，都是函数内部临时变量，
   它们最大的区别就是 calldata 是不可修改的，在某些只读的情况比较省 Gas
2. 局部变量（此处指引用类型）默认是Storage类型的，只能将使用storage类型赋值，不能使用memory类型来赋值
3. storage 赋值给 memory，完全拷贝。storage 赋值给storage，指针传递
   memory 不能赋值给 storage 。memory赋值给memory：对象是传递指针，值类型的数据是拷贝
*/


import "hardhat/console.sol";

contract Test{

    constructor() {
        personArrayGlobal.push(Person("Lily", 20, true));
        personArrayGlobal.push(Person("James", 30, false));
    }

    struct Person {
        string name;
        uint256 age;
        bool married;
    }

    Person[] public personArrayGlobal;

    // remix: [["Lily", 20, true]]
    function changeTestMemory(Person[] memory _psersonArray) public view {
        Person memory pTmp = _psersonArray[0];

        // error, 不能基于memory对象创建storage对象
        // Person storage pTmp = _psersonArray[0]
        _innerChangeMemory(pTmp);

        console.log(pTmp.name);             // David memory
        console.log(_psersonArray[0].name); // David memory，居然改变了！虽然在memory中，但是实际上也是传递的指针

        uint256 tmpInt = 200;
        _innerChangeInt(tmpInt);
        console.log(tmpInt);                // 200，值类型的变量，总是直接复制一份
    }

    function _innerChangeInt(uint _newValue) internal pure {
        _newValue = 100;
    }

    function _innerChangeMemory(Person memory _p) internal pure {
        _p.name = "David memory";
        _p.age = 30;
        _p.married = false;
    }

    function _innerChangeStorage(Person storage _p) internal {
        _p.name = "David Storage";
        _p.age = 30;
        _p.married = false;
    }

    // run before changeTestGlobalWithStorage
    function changeTestGlobalWithMemory() public view {
        Person memory pTmp = personArrayGlobal[0];

        _innerChangeMemory(pTmp);

        // error，memory 不能赋值给storage
        // _innerChangeStorage(pTmp);

        console.log(pTmp.name); // David memory，memory中的变量改变了
        console.log(personArrayGlobal[0].name); // Lily，原storage中数据未改变
    }

    // run after changeTestGlobalWithMemory
    function changeTestGlobalWithStorage() public {
        Person storage pTmp = personArrayGlobal[0];

        // storage 赋值给memory，完全拷贝
        _innerChangeMemory(pTmp); 
        console.log(pTmp.name); // Lily
        console.log(personArrayGlobal[0].name); // Lily

        // storage 赋值给storage，指针传递
        _innerChangeStorage(pTmp);

        console.log(pTmp.name); // David
        console.log(personArrayGlobal[0].name); // David

    }
}
