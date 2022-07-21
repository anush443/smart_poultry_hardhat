// SPDX-License-Identifier: MIT

//owner
//temperature,humidity,air-quailty
//readStats
//updateStats

pragma solidity ^0.8.8;

// 3. Interfaces, Libraries, Contracts
error SmartPoultry__NotOwner();

contract SmartPoultry {
    /*state variables */
    address private immutable i_owner;
    struct iotStats {
        uint256 temperature;
        uint256 humidity;
        uint256 airQuality;
        uint256 updatedAtTimeStamp;
    }
    iotStats[] private s_iotStatsArray;
    // Events (we have none!)

    // Modifiers
    modifier onlyOwner() {
        if (msg.sender != i_owner) {
            revert SmartPoultry__NotOwner();
        }
        _;
    }

    constructor() {
        i_owner = msg.sender;
    }

    function updateIotStats(
        uint256 _temperature,
        uint256 _humidity,
        uint256 _airQuality
    ) public onlyOwner {
        s_iotStatsArray.push(
            iotStats(_temperature, _humidity, _airQuality, block.timestamp)
        );
    }

    function getLatestStats() public view returns (iotStats memory) {
        return s_iotStatsArray[getIotStatsArrayLength() - 1];
    }

    function getIotStatsArrayLength() public view returns (uint256) {
        uint256 iotStatsArrayLength = s_iotStatsArray.length;
        return iotStatsArrayLength;
    }

    function getOnwer() public view returns (address) {
        return i_owner;
    }
}
