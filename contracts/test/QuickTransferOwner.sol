// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "@openzeppelin/contracts/utils/Address.sol";

contract QuickTransferOwner {
    using Address for address;

    function transferOwnership(address target, address newOwner) public {
        target.functionCall(abi.encodeWithSignature("transferOwnership(address)", newOwner));
    }
}
