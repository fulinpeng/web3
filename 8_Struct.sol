// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./8_Todo.sol";


/**
结构体Struct
1. 自定义结构类型，将不同的数据类型组合到一个结构中，目前支持参数传递结构体
2. 枚举和结构体都可以定义在另外一个文件中，进行import后使用
*/

contract Todos {
    // 内部定义
    // struct Todo {
    //     string text;
    //     bool completed;
    // }

    // An array of 'Todo' structs
    Todo[] public todos;

    function create(string memory _text) public {
        // 3 ways to initialize a struct
        // 1 - calling it like a function
        todos.push(Todo(_text, false));

        // 2 - key value mapping
        // todos.push(Todo({text: _text, completed: false}));

        // 3 - initialize an empty struct and then update it
        // Todo memory todo;
        // todo.text = _text; // todo.completed initialized to false
        // todos.push(todo);
    }

    // Solidity automatically created a getter for 'todos' so
    // you don't actually need this function.
    function get(uint _index) public view returns (string memory text, bool completed) {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    // update text
    function update(uint _index, string memory _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text;
    }

    // update completed
    function toggleCompleted(uint _index) public {
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }
}

/**
怎么理解 storage 关键字？
*/
