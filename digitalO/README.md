## Digital Ocean Automation

~~~~
cd ./digitalO
./scripts/init.sh
~~~~
change dir into digitalO

run the init script to generate the terraform.tfvars file

modify the file <br/>
* insert your own digital ocean token  
* ssh private key filename  
* ssh public key filename  
* eg.  
	* do_token = "xyzabc123"  
    * ssh_pubkey = "example.pub"  
    * private_key = "example"  

## Instructions on how to create an access token
https://www.digitalocean.com/docs/api/create-personal-access-token/

## Creating an ssh key
https://www.digitalocean.com/docs/droplets/how-to/add-ssh-keys/create-with-openssh/

### Aside
I have also included a script that will create an ssh key for you
~~~~
./scripts/makeKey.sh
~~~~
It will ask for a passphrase and key name for your ssh key and will place it in the ~/.ssh directory.

