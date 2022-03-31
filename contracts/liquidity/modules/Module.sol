// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "../../interfaces/IModule.sol";

import "../Types.sol";
import "../Storage.sol";

/**
 * @notice This is the base of all modules. Modules shares part of the storage with `LiquidityManager`
 * @dev do NOT edit this file unless you know what you are doing !!
 */
abstract contract Module is CrossStorage, IModule {
    function id() public pure virtual returns (bytes32);

    function meta()
        public
        pure
        virtual
        returns (
            bytes32[] memory methodIds,
            bytes4[] memory selectors,
            bytes32[] memory initialStates
        );

    function _getDexSpotConfig(uint8 dexId) internal view returns (DexSpotConfiguration memory) {
        require(dexId != 0 && dexId < _dexSpotConfigs.length, "LST"); // the asset is not LiSTed
        return _dexSpotConfigs[dexId];
    }

    /**
     * @dev Using this method to access state storage to ensure the state array exists.
     */
    function _readState(uint256 index) internal view returns (bytes32) {
        require(index < _moduleData[id()].length, "RNG"); // out of range
        return _moduleData[id()][index];
    }

    /**
     * @dev Using this method to access state storage to ensure the state array exists.
     */
    function _writeState(uint256 index, bytes32 newVal) internal returns (bytes32) {
        require(index < _moduleData[id()].length, "RNG"); // out of range
        bytes32 oldVal = _moduleData[id()][index];
        _moduleData[id()][index] = newVal;
        return oldVal;
    }
}
