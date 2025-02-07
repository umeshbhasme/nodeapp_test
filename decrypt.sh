#!/bin/bash

# Path variables
CREDENTIALS_ENC="/home/mnagaraju/actions-runner/Testproject-inno/credentials.enc"
ENCRYPTION_KEY="/home/mnagaraju/actions-runner/Testproject-inno/encryption_key.txt"
CREDENTIALS="/home/mnagaraju/actions-runner/Testproject-inno/credentials.txt"

# Decrypt the credentials
openssl enc -aes-256-cbc -pbkdf2 -d -in $CREDENTIALS_ENC -out $CREDENTIALS -pass file:$ENCRYPTION_KEY

if [ $? -ne 0 ]; then
  echo "Decryption failed"
  exit 1
fi

echo "Decryption succeeded"
