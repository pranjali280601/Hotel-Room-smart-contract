pragma solidity ^0.6.0;

contract HotelRoom{
    
    address payable public owner;
    enum Status {vacant, occupied}
    
    Status curstatus;
    
    event occupy( address _occupant, uint _value);
    
    constructor()public{
        owner=msg.sender;
        curstatus=Status.vacant;
    }
    modifier checkstatus{
         require(curstatus==Status.vacant, "Room occupied!");
         _;
    }
    
    modifier cost(uint _amount){
        require(msg.value>=2 ether, "Not enough ether provided!");
        _;
    }
    receive()external payable checkstatus cost(2 ether){
        
        curstatus=Status.occupied; 
        owner.transfer(msg.value);
        emit occupy(msg.sender, msg.value);
    }
}