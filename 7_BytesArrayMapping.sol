// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EBytesArrayMapping {

// byteN、bytes、string直接的关系：

// - bytes是动态数组，相当于byte数组（如：byte[10])
// - 支持push方法添加
// - 可以与string相互转换
    bytes public name;
    
    //1. 获取字节长度
    function getLen() public view returns(uint256) {
        return name.length;
    }

    //2. 可以不分空间，直接进行字符串赋值，会自动分配空间
    function setValue(bytes memory input) public {
        name = input;
    }
    
    //3. 支持push操作，在bytes最后面追加元素
    function pushData() public {
        name.push("h");
    }

    // - string 动态尺寸的UTF-8编码字符串，是特殊的可变字节数组
    // - string **不支持下标索引**、**不支持length、push方法**
    // - string **可以修改(需通过bytes转换)**

    string public name1 = "lily";   
    
    function setName() public {
        bytes(name1)[0] = "L";   
    }
    
    function getLength() public view returns(uint256) {
        return bytes(name1).length;
    }


// - 定义：mapping(keyType => valueType)  myMapping
// - key可以是任意类型，value可以是任意类型（value也可以是mapping或者数组）
// - mapping不支持迭代器
// - 不需要实例化等，定义后直接可以使用

    // Mapping from address to uint
    mapping(address => uint) public myMap2;

    function get(address _addr) public view returns (uint) {
        // Mapping always returns a value.
        // If the value was never set, it will return the default value.
        return myMap2[_addr];
    }

    function set(address _addr, uint _i) public {
        // Update the value at this address
        myMap2[_addr] = _i;
    }

    function remove(address _addr) public {
        // Reset the value to the default value.
        delete myMap2[_addr];
    }

    // Nested mapping (mapping from address to another mapping)
    mapping(address => mapping(uint => bool)) public nested;

    function get(address _addr1, uint _i) public view returns (bool) {
        // You can get values from a nested mapping
        // even when it is not initialized
        return nested[_addr1][_i];
    }

    function set(
        address _addr1,
        uint _i,
        bool _boo
    ) public {
        nested[_addr1][_i] = _boo;
    }

    function remove(address _addr1, uint _i) public {
        delete nested[_addr1][_i];
    }

// *****数组****
// 1. 定长数组（编译时确定）和动态数组
// 2. 下面的arr和arr2是相同的，arr2多了三个初始化的值，arr2也支持push和pop操作
// 3. 2022年，数组可以直接在构造函数中赋值
// 4. new uint256[](len) 语法用于对memory进行修饰，storage不需要使用new
// 5. 仅状态变量数组和storage支持动态扩容：push

    // Several ways to initialize an array
    uint[] public arr;
    uint[] public arr2 = [1, 2, 3];
    // Fixed sized array, all elements initialize to 0
    uint[10] public myFixedSizeArr;

    function get(uint i) public view returns (uint) {
        return arr[i];
    }

    // Solidity can return the entire array.
    // But this function should be avoided for
    // arrays that can grow indefinitely in length.
    function getArr() public view returns (uint[] memory) {
        return arr;
    }

    function push(uint i) public {
        // Append to array
        // This will increase the array length by 1.
        arr.push(i);
    }

    function pop() public {
        // Remove last element from array
        // This will decrease the array length by 1
        arr.pop();
    }

    function getLength2() public view returns (uint) {
        return arr.length;
    }

    function remove2(uint index) public {
        // Delete does not change the array length.
        // It resets the value at index to it's default value,
        // in this case 0
        delete arr[index];
    }

    function examples() pure external returns(uint[] memory) {
        // create array in memory, only fixed size can be created
        uint[] memory a = new uint[](5);
        return a;
    }

// demo1：删除某个位置的元素，剩余元素向左移动（保留顺序）
    // [1, 2, 3] -- remove(1) --> [1, 3, 3] --> [1, 3]
    // [1, 2, 3, 4, 5, 6] -- remove(2) --> [1, 2, 4, 5, 6, 6] --> [1, 2, 4, 5, 6]
    // [1, 2, 3, 4, 5, 6] -- remove(0) --> [2, 3, 4, 5, 6, 6] --> [2, 3, 4, 5, 6]
    // [1] -- remove(0) --> [1] --> []

    uint[] public arr3;

    function remove(uint _index) public {
        require(_index < arr3.length, "index out of bound");

        for (uint i = _index; i < arr3.length - 1; i++) {
            arr3[i] = arr3[i + 1];
        }
        arr3.pop();
    }

    function test2() external {
        arr3 = [1, 2, 3, 4, 5];
        remove(2);
        // [1, 2, 4, 5]
        assert(arr3[0] == 1);
        assert(arr3[1] == 2);
        assert(arr3[2] == 4);
        assert(arr3[3] == 5);
        assert(arr3.length == 4);

        arr3 = [1];
        remove(0);
        // []
        assert(arr3.length == 0);
    }

// demo2：删除某位置元素，使用最后一个元素填充（不考虑顺序）
    // Deleting an element creates a gap in the array.
    // One trick to keep the array compact is to
    // move the last element into the place to delete.

    function remove3(uint index) public {
        // Move the last element into the place to delete
        arr3[index] = arr3[arr3.length - 1];
        // Remove the last element
        arr3.pop();
    }

    uint[] public arr4;
    function test4() public {
        arr4 = [1, 2, 3, 4];

        remove(1);
        // [1, 4, 3]
        assert(arr4.length == 3);
        assert(arr4[0] == 1);
        assert(arr4[1] == 4);
        assert(arr4[2] == 3);

        remove(2);
        // [1, 4]
        assert(arr4.length == 2);
        assert(arr4[0] == 1);
        assert(arr4[1] == 4);
    }


}
