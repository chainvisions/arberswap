// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.7.6;

interface IArberswapRouter {
    function paused() external view returns (bool);
    function swapFeeNumerator() external view returns (uint);
    function swapFeeDenominator() external view returns (uint);

    function dexAllowlist(address) external view returns (bool);
    function feeOnTransferTokens(address) external view returns (bool);

    function swap(uint, uint, address[] calldata, address[] calldata) external returns (uint);
}