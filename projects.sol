// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title MedHistory
 * @dev A simple decentralized medical record management system.
 * Patients can store and share their medical history securely on blockchain.
 */
contract MedHistory {
    // Structure for patient medical record
    struct Record {
        string diagnosis;
        string prescription;
        uint256 date;
    }

    // Mapping of patient (address) to their records
    mapping(address => Record[]) private medicalRecords;

    // Event when a new record is added
    event RecordAdded(address indexed patient, string diagnosis, string prescription, uint256 date);

    /**
     * @dev Add a new medical record for sender
     * @param _diagnosis The diagnosis details
     * @param _prescription The prescribed medicines or treatment
     */
    function addRecord(string calldata _diagnosis, string calldata _prescription) external {
        medicalRecords[msg.sender].push(
            Record(_diagnosis, _prescription, block.timestamp)
        );
        emit RecordAdded(msg.sender, _diagnosis, _prescription, block.timestamp);
    }

    /**
     * @dev Get all medical records of the caller
     * @return Array of Record structs
     */
    function getMyRecords() external view returns (Record[] memory) {
        return medicalRecords[msg.sender];
    }

    /**
     * @dev Get medical records of another patient (if shared publicly or in future update)
     * @notice For demo, this function just returns the same records (restricted by design)
     */
    function getPatientRecords(address _patient) external view returns (Record[] memory) {
        require(_patient == msg.sender, "Access denied: Not your record");
        return medicalRecords[_patient];
    }
}
