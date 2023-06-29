
// 案例二：
// SPDX-License-Identifier: MIT
pragma solidity =0.8.19;
pragma abicoder v2;

contract StructTest {
    event Info(uint8 _type, address _addr);

    struct Token {
        uint8 tokenType;
        address tokenAddress;
    }

    function call(Token [] memory tokens) external {
        for (uint8 i = 0; i< tokens.length; i++) {
            (uint8 t, address addr) = (tokens[i].tokenType, tokens[i].tokenAddress);
            emit Info(t, addr);
        }
    }
}
/*
输入参数：

```sh
[[0,0x5B38Da6a701c568545dCfcB03FcB875f56beddC4],[1,0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2]]
```

但是一直失败！

原因：地址需要使用双引号包裹传递，正确参数：

```sh
[[0,"0x5B38Da6a701c568545dCfcB03FcB875f56beddC4"],[1,"0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2"]]
```



## 当结构体中有数组

### 正确做法：

1. 先使用storage创建空的数组对象
2. 然后拼装对象，push到数组中

### 错误做法：

1. 先new一个数组，拼装数据
2. 然后赋值到结构体中

*/
