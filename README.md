# TLS/PKI Testing

This repository contains a Github Actions workflow for Project 5. It uses Docker containers and steps through TLS and mTLS testing.

## GitHub Actions Workflow
- prepare containers
- setup TLS
- test and capture TLS Traffic
- install Easy-RSA
- test and capture mTLS without a Client Certificate
- test and capture mTLS with a Client Certificate
- revoke a client certificate with Easy-RSA
- test and capture connection attempt using a revoked certificate
- issue a new client certificate
- test and capture with the new client certificate
- upload pcap files to artifacts
- cleanup

---

## How to Review GitHub Actions Results

### 1. Viewing Workflow Runs
- Go to the **Actions** tab in this repository.
- Select a workflow run (triggered by a `push` or `pull_request`).
- Expand individual steps to view detailed logs.

### 2. Downloading Artifacts
- At the bottom of the workflow run page, locate the **Artifacts** section.
- Click on the artifact (e.g., `tls-testing-pcaps`) to download a `.zip` file containing:
  - `.pcap` files for network traffic analysis.
  - These can be opened in tools like Wireshark to validate TLS and mTLS handshakes, certificates, and protocols.

---

## Next Steps
- review the uploaded .pcap files for validation of TLS and mTLS configurations
- answer project questions
- submit results