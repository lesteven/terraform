#!/bin/bash

cd "$(dirname "$0")/.."

file=terraform.tfvars

if [ -f "$file" ]; then
    echo "$file already exists"
else
    echo "will create $file"
    cat <<EOF > "$file"
do_token = "digital ocean token"
ssh_pubkey = "public ssh key filename"
private_key = "private ssh key filename"
EOF
fi

