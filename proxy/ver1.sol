pragma solidity ^0.5.0;

contract Ver1 {
    uint256 public t;
    
    event L(uint a, uint b, address c);
    
    function add(uint256 a, uint256 b) public returns(uint256) {
        t = a + b;
        emit L(a, b, msg.sender);
        return t;
    }
    
    function tell() public view returns(uint256) {
        return (t);
    }
}