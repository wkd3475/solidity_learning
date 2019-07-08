pragma solidity ^0.5.0;

contract Storage {
    address payable public friend;
    uint _amount = 0.1 ether;
    uint256 public t;
}

contract Proxy is Storage {
    address payable public targetAddress;
    
    event FallbackCalledEvent(bytes data);

    constructor(address payable _address) public {
        setTargetAddress(_address);
    }

    function setTargetAddress(address payable _address) public {
        require(_address != address(0));
        targetAddress = _address;
    }

    function () payable external {
        emit FallbackCalledEvent(msg.data);
        address payable contractAddr = targetAddress;
        require(contractAddr != address(0));
        
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize)
            let result := delegatecall(gas, contractAddr, ptr, calldatasize, 0, 0)
            let size := returndatasize
            returndatacopy(ptr, 0, size)

            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
        }
    }
    
    function tell() public view returns(uint256) {
        return (t);
    }
}