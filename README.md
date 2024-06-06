# NGINX Reverse Proxy with SSL

Automated installation of a simple nginx web app https://github.com/dockersamples/linux_tweet_app with automatic Let's Encrypt certificate generation.

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

### Variables and secrets

`HOSTNAME` - DNS name for the instance. Used by Terraform for instance name and by Ansible for host inventory name and DNS name for certificate.
`TF_API_TOKEN` - Terraform Cloud token. TFC is used as a backend.
`VULTR_API_KEY` - used by Terraform to provision Vultr instance.
`SSH_PRIVATE_KEY` - used by Ansible to connect to the instance. Corresponds to the `vulture_ssh_key.ansible` in TF.
`ACME_KEY_PASSPHRASE` - passphrase to generate the ACME account key with.
