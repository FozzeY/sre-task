# NGINX Reverse Proxy with SSL

Automated installation of a simple nginx web app https://github.com/dockersamples/linux_tweet_app with automatic Let's Encrypt certificate generation.

The URL is https://imelnikov.xyz.

The installation is split into two Github Actions workflows:

## Terraform

Runs Terraform code in the `terraform` directory to deploy a Vultr Ubuntu instance.

## Ansible

Runs Ansible code in the `ansible` directory to perform the following on `imelnikov.xyz` host:
- Install Docker
- Build the app image
- Request ACME challenge for `imelnikov.xyz` and `www.imelnikov.xyz`
- Validate using HTTP-01
- Install certificates
