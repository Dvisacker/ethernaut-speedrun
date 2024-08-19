// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperOne} from "./GatekeeperOne.sol";
import {console} from "forge-std/console.sol";

contract GatekeeperOneHack {
    GatekeeperOne gatekeeperOne;

    constructor(address _gatekeeperOne) {
        gatekeeperOne = GatekeeperOne(_gatekeeperOne);
    }

    function hack() public view {
        bytes2 last4Numbers = bytes2(uint16(uint160(tx.origin)));
        bytes6 first12Numbers = bytes6(0x000000010000);
        bytes8 gateKey = bytes8(bytes.concat(first12Numbers, last4Numbers));
        console.logBytes8(gateKey);
    }
}
