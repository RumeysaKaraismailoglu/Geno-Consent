# Geno-Consent: A Resource-Efficient Blockchain Architecture for Dynamic Consent Management

This repository contains the smart contracts and benchmarking test suites for the study: **"Geno-Consent: A Resource-Efficient Blockchain Architecture for Dynamic Consent Management in Genomic Data Sharing."** This project utilizes the Design Science Research Methodology (DSRM) to introduce a paradigm shift: structurally decoupling off-chain genomic data storage from on-chain cryptographic authorization to ensure full compliance with GDPR and KVKK's "Right to be Forgotten".

## Repository Structure

* `src/`: Contains the core smart contracts.
    * `GenoConsent.sol`: The proposed $O(1)$ double-mapping architecture for zero-gas verification and consent management.
    * `FileStorage.sol`: The baseline array-based model used for comparative performance analysis.
* `test/`: Contains the Foundry benchmarking scripts.
    * `BenchmarkTest.sol`: Measures gas consumption, execution latency (ms), and system throughput (TPS).

## Technology Stack
* **Smart Contract Development:** Solidity ^0.8.28
* **Testing & Benchmarking Framework:** Foundry (Anvil)
* **Network:** Ethereum (Sepolia Testnet)

## Reproducibility and Benchmarking

To replicate the empirical benchmarking results presented in the paper, follow these steps:

1. **Install Foundry:**
   If you haven't installed Foundry yet, run:
   curl -L https://foundry.paradigm.xyz | bash
   foundryup

2. **Clone the Repository:**
   git clone https://github.com/RumeysaKaraismailoglu/Geno-Consent.git
   cd Geno-Consent

3. **Run Performance Metrics:**
   To execute the gas consumption and latency benchmarks:
   forge test --match-test test_PerformanceMetrics -vvv

4. **Run Throughput Stress Test:**
   forge test --match-test test_Throughput -vvv

## Authors
* **Rümeysa Karaismailoğlu** - Istanbul University, Department of Informatics
* **Emre Akadal** - Istanbul University, Department of Management Information Systems
