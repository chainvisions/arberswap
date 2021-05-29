// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.7.6;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "./interfaces/IArberswapRouter.sol";

/// @title Arberswap Router
/// @author Chainvisions
/// @notice Router for Arberswap trades.

contract ArberswapRouter is IArberswapRouter {
    using SafeMath for uint;
    using SafeERC20 for IERC20;

    bool public override paused;

    uint public override swapFeeNumerator = 1; // 0.1%
    uint public override constant swapFeeDenominator = 1000;

    mapping(address => bool) public override dexAllowlist;
    mapping(address => bool) public override feeOnTransferTokens;

    modifier onlyWhenNotPaused {
        require(!paused, "ArberswapRouter: Contract paused");
        _;
    }

    /// @dev Performs a trade through the router.
    /// @param _amountIn Amount transfer from the user to trade.
    /// @param _amountOutMin Minimum amount of the end token the user must receive.
    /// @param _route Route for the tokens to go through during the trade.
    /// @param _dexRoute The DEXs that the tokens go through during the trade.
    function swap(
        uint _amountIn, 
        uint _amountOutMin, 
        address[] calldata _route,
        address[] calldata _dexRoute
    ) public override onlyWhenNotPaused returns (uint) {
        // Perform checks before proceeding with the trade.
        require(_route.length == _dexRoute.length.add(1), "ArberswapRouter: Routes do not match");

        IERC20(_route[0]).safeTransferFrom(msg.sender, address(this), _amountIn);

        for(uint i = 0; i < _dexRoute.length; i++) {
            require(dexAllowlist[_dexRoute[i]], "ArberswapRouter: Specified DEX is not on the allowlist");
        }

        return 1000; // Placeholder.
    }

    /// @dev Adds a DEX to the allowlist, allowing for swapping.
    function addToAllowlist(address _dex) public {
        dexAllowlist[_dex] = true;
    }

    /// @dev Removes a DEX from the allowlist.
    function removeFromAllowlist(address _dex) public {
        dexAllowlist[_dex] = false;
    }

    /// @dev Sets the numerator for the swap fee.
    function setSwapFee(uint _swapFeeNumerator) public {
        swapFeeNumerator = _swapFeeNumerator;
    }

    /// @dev Pauses swapping on the contract.
    function pause() public {
        paused = true;
    }

    /// @dev Unpauses swapping on the contract.
    function unpause() public {
        paused = false;
    }

}