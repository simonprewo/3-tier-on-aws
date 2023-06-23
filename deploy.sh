alias dockerrun='docker run --rm -ti --mount type=bind,source="$(pwd)",target=/root'

# Unencrypt Environment Access
dockerrun alpine /bin/sh -c "apk add openssl && openssl enc -aes256 -pbkdf2 -a -d -pass pass:$AES_KEY -in /root/.aws/credentials.enc -out /root/.aws/credentials"
dockerrun alpine /bin/sh -c "openssl enc -aes256 -pbkdf2 -a -d -pass pass:$AES_KEY -in /root/keys/key.enc -out /root/keys/key"

terraform apply -auto-approve
