// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {ElevatorHack} from "../src/ElevatorHack.sol";

contract HackElevator is Script {
    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        ElevatorHack elevatorHack = helperConfig.getElevatorConfig().elevatorHack;
        vm.startBroadcast();
        elevatorHack.hack();
        vm.stopBroadcast();
    }
}
