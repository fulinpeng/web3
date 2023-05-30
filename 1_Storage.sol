// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


// contract SimpleStorage {
//     // boolean, uint, int, address, bytes
//     uint256 public favoriteNumber;
    
//     function store(uint256 _favoriteNumber) public {
//         favoriteNumber = _favoriteNumber;
//     }
// }

contract Storage {

    uint256 number;

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People public person = People({favoriteNumber: 2, name: 'flp'});

    // 数组
    People[] public peoples;
    
    // 映射
    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 num) public {
        number += num;
    }

    
    // view, pure 不允许修改状态
    // view
    function retrieve() public view returns (uint256){
        return number;
    }

// pure
    function add() public pure returns (uint256){
        return 1+1;
    }
    // memory 临时/可修改/可删除
    // calldata 临时/不可修改
    // storage 永久储存

    // string比较复杂（这里也可以认为是数组），程序不知道储存在什么位置
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        peoples.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

}
