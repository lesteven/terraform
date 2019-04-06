#!/bin/bash

terraform init
printf 'yes' | terraform apply
