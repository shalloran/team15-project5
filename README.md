# Team 15 Project 5: PKI-TLS Automation

## Prerequisites
- Docker Desktop and Docker Compose installed. This works on MacOS, it should work on Linux but you may need to modify the setup script and your commands.

## Setup Instructions
1. Clone the repository or unzip the files.
2. Build the docker images: ```docker compose build```
3. Run the docker compose file: ```docker compose up -d```
4. Ensure that the setup script is executable and then run the setup script:
   ```bash
   chmod +x setup.sh && ./setup.sh
   ```
5. Test the setup:
    ```bash
    docker exec client-container curl --cert /shared/client.crt --key /shared/client.key -k https://server-container
    ```

## Contributing:
Please feel free to suggest improvements by submitting a pull request!