pragma solidity ^0.5.0;

contract Send {
    address payable public friend;
    uint _amount = 0.1 ether;
    function send() public payable {
        friend.transfer(_amount);
        msg.sender.transfer(msg.value - _amount);
    }
    
    function setFriend(address payable _friend) public {
        friend = _friend;
    }
}