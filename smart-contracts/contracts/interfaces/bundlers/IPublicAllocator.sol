// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;

import {Id, MarketParams, IMorpho} from "@morpho-org/morpho-blue/src/interfaces/IMorpho.sol";

struct FlowCaps {
    uint128 maxIn;
    uint128 maxOut;
}

struct FlowCapsConfig {
    Id id;
    FlowCaps caps;
}

struct Withdrawal {
    MarketParams marketParams;
    uint128 amount;
}

/// @dev Copy of the Public Allocator interface but using the struct of morpho-blue imported by the bundler.
interface IPublicAllocator {
    /// @dev Max settable flow cap, such that caps can always be stored on 128 bits.
    /// @dev The actual max possible flow cap is type(uint128).max-1.
    /// @dev Equals to 170141183460469231731687303715884105727;
    uint128 constant MAX_SETTABLE_FLOW_CAP = type(uint128).max / 2;

    function MORPHO() external view returns (IMorpho);

    function owner(address vault) external view returns (address);

    function fee(address vault) external view returns (uint256);

    function accruedFee(address vault) external view returns (uint256);

    function reallocateTo(
        address vault,
        Withdrawal[] calldata withdrawals,
        MarketParams calldata supplyMarketParams
    ) external payable;

    function setOwner(address vault, address newOwner) external;

    function setFee(address vault, uint256 newFee) external;

    function transferFee(address vault, address payable feeRecipient) external;

    function setFlowCaps(
        address vault,
        FlowCapsConfig[] calldata config
    ) external;

    function flowCaps(
        address vault,
        Id
    ) external view returns (FlowCaps memory);
}
