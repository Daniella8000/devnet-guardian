# DevNet Guardian 🏥🔒

## Overview

DevNet Guardian is a cutting-edge, blockchain-powered health record management platform that provides patients with complete sovereignty over their medical data. Built on the Stacks blockchain, this decentralized solution ensures secure, permissioned, and transparent access to sensitive healthcare information.

### Key Features

- 🔐 Patient-Controlled Access
- 🏥 Granular Healthcare Provider Permissions
- 📋 Immutable Audit Logging
- 🔍 Privacy-Preserving Record Management

## Problem Statement

Current healthcare record systems suffer from:
- Centralized control
- Limited patient agency
- Fragmented data access
- Lack of transparent audit trails

DevNet Guardian solves these challenges by providing a decentralized, secure, and patient-centric approach to medical record management.

## Technical Architecture

### Smart Contract Components
- User Registry
- Medical Document Management
- Access Control Mechanism
- Comprehensive Audit Logging

### Access Control Model
- Multi-tier permission system
- Granular record-level access
- Expirable provider permissions

## Getting Started

### Prerequisites
- Clarinet
- Stacks Blockchain
- TypeScript

### Installation
```bash
git clone https://github.com/yourusername/devnet-guardian.git
cd devnet-guardian
clarinet contract check
```

### Running Tests
```bash
clarinet test
```

## Contract Documentation

### Health Guardian Contract

The primary contract (`health-guardian.clar`) handles core functionality:

#### Key Functions

**Patient Operations**
- Register user profile
- Grant/revoke provider access
- Manage record permissions

**Provider Operations**
- Create medical documents
- Update medical records
- Request access to patient records

**Administrative Operations**
- Verify healthcare providers
- Manage system administrators
- Audit access logs

## Development

### Testing Strategy

The contract includes comprehensive test scenarios:
1. User registration flows
2. Permission management
3. Document creation and updates
4. Access control verification
5. Audit logging validation

## Security Considerations
- Role-based access control
- Cryptographic permission validation
- Immutable audit trails
- No off-chain data storage

### Known Limitations
- Maximum 20 specific records per permission
- Manual provider verification
- Encryption handled externally

## License
MIT License

## Contributing
Please read CONTRIBUTING.md for details on our code of conduct and the process for submitting pull requests.