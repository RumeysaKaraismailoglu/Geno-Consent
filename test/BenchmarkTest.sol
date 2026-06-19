// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "forge-std/Test.sol";
import "../src/GenoConsent.sol";
import "../src/FileStorage.sol"; 

contract BenchmarkTest is Test {
    GenoConsent geno;
    FileStorage baseline; 

    function setUp() public {
        geno = new GenoConsent();
        baseline = new FileStorage(); 
    }

    /// @notice Benchmark for Gas Consumption and Execution Latency
    function test_PerformanceMetrics() public {
        // --- Geno-Consent Measurements ---
        uint256 startGasGeno = gasleft();
        uint256 startTimeGeno = block.timestamp;
        geno.grantConsent(address(0x1));
        emit log_named_uint("Geno Gas Used", startGasGeno - gasleft());
        emit log_named_uint("Geno Latency (ms)", (block.timestamp - startTimeGeno) * 1000);

        // --- Competitor (FileStorage) Measurements ---
        uint256 startGasBaseline = gasleft(); 
        uint256 startTimeBaseline = block.timestamp; 
        baseline.addFile("Hash123", "Key123"); 
        emit log_named_uint("Competitor Gas Used", startGasBaseline - gasleft()); 
        emit log_named_uint("Competitor Latency (ms)", (block.timestamp - startTimeBaseline) * 1000); 
    }

    /// @notice Stress test for Throughput (TPS) Calculation
    function test_Throughput() public {
        uint256 operations = 1000;
        uint256 startTime = block.timestamp;
        
        for(uint i = 0; i < operations; i++) {
            geno.checkConsent(address(this), address(0x1));
        }
        
        uint256 duration = block.timestamp - startTime;
        uint256 tps = operations / (duration > 0 ? duration : 1);
        emit log_named_uint("Geno Throughput (TPS)", tps);
    }
}