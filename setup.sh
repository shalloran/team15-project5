#!/bin/bash

# Start Docker Compose
docker compose up -d # or docker-compose up -d depending upon your docker version / OS/ etc.

# Configure the server
docker exec server-container bash -c "
apt update && \
apt install -y nginx openssl && \
mkdir -p /etc/nginx/ca /etc/nginx/certs && \
openssl genpkey -algorithm RSA -out /etc/nginx/ca/ca.key && \
openssl req -x509 -new -nodes -key /etc/nginx/ca/ca.key -sha256 -days 365 -out /etc/nginx/ca/ca.crt -subj '/CN=MyCA' && \
openssl genpkey -algorithm RSA -out /etc/nginx/certs/server.key && \
openssl req -new -key /etc/nginx/certs/server.key -out /etc/nginx/certs/server.csr -subj '/CN=server-container' && \
openssl x509 -req -in /etc/nginx/certs/server.csr -CA /etc/nginx/ca/ca.crt -CAkey /etc/nginx/ca/ca.key -CAcreateserial -out /etc/nginx/certs/server.crt -days 365 -sha256 && \
sed -i '/listen 80 default_server;/a \
listen 443 ssl;\n\
ssl_certificate /etc/nginx/certs/server.crt;\n\
ssl_certificate_key /etc/nginx/certs/server.key;' /etc/nginx/sites-available/default && \
service nginx restart && \
openssl genpkey -algorithm RSA -out /etc/nginx/certs/client.key && \
openssl req -new -key /etc/nginx/certs/client.key -out /etc/nginx/certs/client.csr -subj '/CN=client-container' && \
openssl x509 -req -in /etc/nginx/certs/client.csr -CA /etc/nginx/ca/ca.crt -CAkey /etc/nginx/ca/ca.key -CAcreateserial -out /etc/nginx/certs/client.crt -days 365 -sha256 && \
cp /etc/nginx/certs/client.crt /shared && \
cp /etc/nginx/certs/client.key /shared
"

# Configure the client
docker exec client-container bash -c "
apt update && \
apt install -y curl tcpdump && \
mkdir -p /etc/ssl/certs /etc/ssl/private && \
cp /shared/client.crt /etc/ssl/certs/client.crt && \
cp /shared/client.key /etc/ssl/private/client.key
"

echo "Setup complete. Test the setup by running the following command:"
echo "docker exec client-container bash -c 'curl --cert /etc/ssl/certs/client.crt --key /etc/ssl/private/client.key -k https://server-container'"