// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 枚举，进行状态管理，默认第一个值是：0
contract Enum {
    // Enum representing shipping status
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    // Default value is the first element listed in
    // definition of the type, in this case "Pending"
    Status public status; // status 取值只能是：0，1，2，3，4

    // Returns uint
    // Pending  - 0
    // Shipped  - 1
    // Accepted - 2
    // Rejected - 3
    // Canceled - 4
    function get() public view returns (Status) { // 传入5会抱错
        return status;
    }

    // Update status by passing uint into input
    function set(Status _status) public {
        status = _status;
    }

    // delete resets the enum to its first value, 0
    function reset() public {
        delete status;
    }
}
