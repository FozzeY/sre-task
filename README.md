# NGINX Reverse Proxy with SSL
![Terraform workflow](https://github.com/FozzeY/sre-task/actions/workflows/terraform.yml/badge.svg)
![Ansible workflow](https://github.com/FozzeY/sre-task/actions/workflows/ansible.yml/badge.svg)

Automated installation of a [simple nginx web app](https://github.com/dockersamples/linux_tweet_app) with nginx reverse proxy and automatic Let's Encrypt certificate generation.

Hosted at https://imelnikov.xyz/.

The installation is split into two Github Actions workflows:

## Terraform

Runs Terraform code in the `terraform` directory to deploy a Vultr Ubuntu instance with a predefined SSH key.

## Ansible

Runs Ansible code in the `ansible` directory to perform the following on `HOSTNAME` host:
- Install Docker
- Request ACME challenge for `HOSTNAME` and `www.HOSTNAME`
- Validate using HTTP-01 on nginx proxy
- Install certificates to nginx proxy
- Configure proxy to route requests to the app
- Run docker-compose file which builds the app and starts it with the proxy

### Variables and secrets

`HOSTNAME` - DNS name for the instance. Used by Terraform for instance name and by Ansible for host inventory name and DNS name for certificate. Set to `imelnikov.xyz`.

`TF_API_TOKEN` - Terraform Cloud token. TFC is used as a backend.

`VULTR_API_KEY` - used by Terraform to provision Vultr instance.

`SSH_PRIVATE_KEY` - used by Ansible to connect to the instance. Corresponds to the `vulture_ssh_key.ansible` in TF.

`ACME_KEY_PASSPHRASE` - passphrase to generate the ACME account key with.
