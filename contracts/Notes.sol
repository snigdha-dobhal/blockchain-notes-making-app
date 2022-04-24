pragma solidity ^0.4.18;

contract Notes {
    struct ToDoList {
        string name;
        mapping(string => string) tasks;
        string status;
    }
    
    address public owner;
    string public profileName;
    
    mapping(string => ToDoList) toDoLists;
    uint public totalVotes;
    
    modifier ownerOnly() {
        require(msg.sender == owner);
        _;
    }
    
    function Notes(string _name) public {
        owner = msg.sender;
        profileName = _name;
    }
    
    function getTotalVotes() public view returns(uint) {
        return totalVotes;
    }
    
    function createToDoList(string _name) ownerOnly public {
        toDoLists[_name] = ToDoList(_name, "open");
    }
    
    function addTask(string _list, string _task) public {
        toDoLists[_list].tasks[_task] = "open";
    }

    function completeTask(string _list, string _task) public {
        toDoLists[_list].tasks[_task] = "complete";
    }

    function deleteTask(string _list, string _task) public {
        toDoLists[_list].tasks[_task] = "removed";
    }

    function deleteToDoList(string _list) public {
        toDoLists[_list].status = "deleted";
    }

    function getTaskStatus(string _list, string _task) public returns(string){
        return toDoLists[_list].tasks[_task];
    }
    
    function getToDoListStatus(string _list) public returns(string){
        return toDoLists[_list].status;
    }

    function end() ownerOnly public {
        selfdestruct(owner);
    }
}
