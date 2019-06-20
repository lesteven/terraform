#!/bin/bash


# certbot for https
# remove --test-cert for production
sudo certbot --agree-tos -m le_steven@outlook.com --no-eff-email \
    --test-cert --redirect \
    --nginx -d stevenle.xyz -d www.stevenle.xyz 
sudo certbot renew --dry-run
exit
# cleanup
# rm drone.config
