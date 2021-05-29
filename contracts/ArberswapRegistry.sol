// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.7.6;

/// @title Arberswap Registry
/// @author Chainvisions
/// @notice Registry contract for Arberswap contracts.

contract ArberswapRegistry {
    address public router;

    constructor() {}

    function setRouter(address _router) public {
        router = _router;
    }

}