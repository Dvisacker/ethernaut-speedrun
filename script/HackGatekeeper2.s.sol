// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {GatekeeperTwoHack} from "../src/GatekeeperTwoHack.sol";

contract HackGatekeeper2Script is Script {
    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        helperConfig.getGatekeeperTwoConfig().gatekeeperTwoHack;
    }
}
