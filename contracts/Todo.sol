// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;


contract TodoContract {
    struct Todo {
        string title;
        uint256 created_at;
        uint256 finish_at;
    }

    mapping(address => Todo[]) public todos;


    /// @dev this function would add a todo the todo mapping of a user 
    /// @param _title: this is the name of the todo
    /// @param _finish_at: this is the time in secs when the task is due
    function createTodo(string memory _title, uint256 _finish_at) public {
        Todo[] storage ss = todos[msg.sender];
        Todo memory st = Todo(_title,  block.timestamp, block.timestamp + _finish_at);

        ss.push(st);
    }


    function completeTodo(uint256 _todo_id) public {
        Todo[] storage ss = todos[msg.sender];
        delete ss[_todo_id];
    }

    function viewTodoByIndex(uint256 _toto_id) public view returns(Todo memory ) {
        Todo[] storage ss = todos[msg.sender];
         return ss[_toto_id];
    }

    function viewAllTodo() public view returns(Todo[] memory ) {
        Todo[] storage ss = todos[msg.sender];
         return ss;
    }

    function viewDueTodo() public view returns(Todo[] memory ) {
        Todo[] storage ss = todos[msg.sender];
        Todo[] memory st = new Todo[](ss.length);
        uint id;

        for (uint i = 0; i < ss.length; i++) {
            if(ss[i].finish_at < block.timestamp) {
                st[id] = ss[i];
                id++;
            }
        }

        return st;
    }
}