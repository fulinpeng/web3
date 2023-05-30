// SPDX-License-Identifier: MIT
  pragma solidity ^0.8.7;

// 关键字 contract 跟java的class一样  智能合约是Inbox      
contract Inbox{
    
  // 状态变量，存在链上
	string public message;
    
    // 构造函数
	constructor(string memory initMessage) {
    // 本地变量
    string memory tmp = initMessage;
    message = tmp;
	}
  
  // 写操作，需要支付手续费
  function setMessage(string memory _newMessage) public {
    message = _newMessage;
  }
  
  // 读操作，不需要支付手续费
  function getMessage() public view returns(string memory) {
    return message;
  }

}
// memory 关键词表示函数内部变量，用完即删
