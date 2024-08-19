// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {Vault} from "../src/Vault.sol";
import {SimpleToken} from "../src/Recovery.sol";

pragma solidity ^0.8.0;

contract MagicNum {
    address public solver;

    constructor() {}

    function setSolver(address _solver) public {
        solver = _solver;
    }
}

contract HackSolverScript is Script {
    function run() public {
        // HelperConfig helperConfig = new HelperConfig();
        // address player = helperConfig.getBasicSepoliaConfig().account;
        MagicNum magicNum = MagicNum(0x3dad65d7f2fB9E6228E0F1e826017A27AbD2e3EA);
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        vm.startBroadcast();
        address addr;
        assembly {
            addr := create(0, add(bytecode, 0x20), mload(bytecode))
        }
        console.log("Bytecode contract: ", addr);
        magicNum.setSolver(addr);
        vm.stopBroadcast();
    }
}

interface ISolver {
    function whatIsTheMeaningOfLife() external view returns (uint256);
}

contract TestSolverScript is Script {
    function run() public view {
        ISolver solver = ISolver(0x3a5810E55Df6b1e02AF29bAC8278A57C8a738949);
        console.log("Meaning of life: ", solver.whatIsTheMeaningOfLife());
    }
}
