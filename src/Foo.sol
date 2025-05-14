// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.29;

contract Foo {
    uint256 public counter;

    function echo(uint256 value) external returns (uint256) {
        counter += value;
        return value;
    }

    function reset() external {
        counter = 0;
    }
}
