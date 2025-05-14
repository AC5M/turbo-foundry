// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.29;

import { Test } from "forge-std/src/Test.sol";

import { Foo } from "../../src/Foo.sol";

contract InvariantCounter is Test {
    Foo foo;
    uint256 private lastCounter; // stores previous value

    function setUp() public {
        foo = new Foo();
        lastCounter = foo.counter();
    }

    /// Expose functions for Foundry's invariant fuzzer
    function callEcho(uint128 amt) public {
        foo.echo(amt);
    }

    function callReset() public {
        foo.reset();
        lastCounter = 0; // reset baseline
    }

    /// The invariant itself: counter should never decrease below previous snapshot
    function invariant_counterNeverDecreases() public {
        uint256 current = foo.counter();
        assertGe(current, lastCounter);
        lastCounter = current; // update snapshot
    }
}
