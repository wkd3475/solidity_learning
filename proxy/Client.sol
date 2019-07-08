pragma solidity ^0.5.0;

contract Client {
    uint256 public t;
    address payable public proxyAddr;
    
    constructor(address payable _contractAddr) public {
        proxyAddr = _contractAddr;
    }
    
    function callTest(uint to, uint value) public returns (bool, bytes memory, address) {
        (bool success, bytes memory data) = proxyAddr.call(abi.encodeWithSignature("add(uint256,uint256)", to, value));
        
        if(!success) {
            revert();
        }
        
        return (success, data, proxyAddr);
    }
    
    function callTest2() payable public returns (bool, bytes memory, address) {
        proxyAddr.transfer(msg.value);
        (bool success, bytes memory data) = proxyAddr.call(abi.encodeWithSignature("send()"));
        
        if(!success) {
            revert();
        }
        
        return (success, data, proxyAddr);
    }
    
    function callTest3(address payable friend) public returns (bool, bytes memory, address) {
        (bool success, bytes memory data) = proxyAddr.call(abi.encodeWithSignature("setFriend(address)", friend));
        
        if(!success) {
            revert();
        }
        
        return (success, data, proxyAddr);
    }
    
    function tell() public view returns(uint256) {
        return (t);
    }
}