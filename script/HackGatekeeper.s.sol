// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {GatekeeperOne} from "../src/GatekeeperOne.sol";
import {GatekeeperOneHack} from "../src/GatekeeperOneHack.sol";

contract HackGatekeeperScript is Script {
    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        GatekeeperOneHack gatekeeperOneHack = helperConfig.getGatekeeperOneConfig().gatekeeperOneHack;
        vm.startBroadcast();
        gatekeeperOneHack.hack();
        vm.stopBroadcast();
    }
}
