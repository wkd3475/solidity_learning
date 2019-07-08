pragma solidity ^0.5.0;

contract Ver2 {
    address payable public friend;
    uint _amount = 0.1 ether;
    uint256 public t;
    
    event L(uint a, uint b, address c);
    
    function add(uint256 a, uint256 b) public returns(uint256) {
        t = a + b;
        emit L(a, b, msg.sender);
        return t;
    }
    
    function send() public payable {
        require(msg.value > _amount);
        friend.transfer(_amount);
        msg.sender.transfer(msg.value - _amount);
    }
    
    function setFriend(address payable _friend) public {
        friend = _friend;
    }
}