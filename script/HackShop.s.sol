// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {Shop, ShopHack} from "../src/Shop.sol";

contract HackShopScript is Script {
    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        ShopHack shopHack = helperConfig.getShopConfig().shopHack;
        vm.startBroadcast();
        shopHack.hack();
        vm.stopBroadcast();
    }
}
