// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title GenoConsent
 * @dev Dynamic consent and right to be forgotten management system for genomic data.
 */
contract GenoConsent {
    
    // Registry tracking which researcher has been granted access by which patient (Data Owner)
    // Patient Address => Researcher Address => Access Status (True/False)
    mapping(address => mapping(address => bool)) public accessRegistry;

    // Logs to ensure immutable tracking of transactions with cryptographic timestamps on-chain
    event ConsentGranted(address indexed patient, address indexed researcher, uint256 timestamp);
    event ConsentRevoked(address indexed patient, address indexed researcher, uint256 timestamp);

    /**
     * @dev Function 1: Patient grants data access permission to a specific researcher wallet.
     * @param _researcher The wallet address of the researcher requesting access.
     */
    function grantConsent(address _researcher) public {
        accessRegistry[msg.sender][_researcher] = true;
        emit ConsentGranted(msg.sender, _researcher, block.timestamp);
    }

    /**
     * @dev Function 2: Patient instantly revokes access permission (Right to be Forgotten / GDPR & KVKK Compliance).
     * @param _researcher The wallet address of the researcher whose access is being revoked.
     */
    function revokeConsent(address _researcher) public {
        accessRegistry[msg.sender][_researcher] = false;
        emit ConsentRevoked(msg.sender, _researcher, block.timestamp);
    }

    /**
     * @dev Function 3: Off-chain hospital server queries the blockchain to verify researcher's authorization.
     * @param _patient The wallet address of the patient (Data Owner).
     * @param _researcher The wallet address of the researcher requesting access.
     * @return bool True if authorized, False otherwise.
     */
    function checkConsent(address _patient, address _researcher) public view returns (bool) {
        return accessRegistry[_patient][_researcher];
    }
}