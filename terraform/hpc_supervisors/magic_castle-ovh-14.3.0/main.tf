terraform {
  required_version = ">= 1.5.7"
}

variable "pool" {
  description = "Slurm pool of compute nodes"
  default = []
}

module "ovh" {
  source         = "./ovh"
  config_git_url = "https://github.com/ComputeCanada/puppet-magic_castle.git"
  config_version = "14.3.0"

  cluster_name = "starfish-cluster"
  domain       = "starfish.cloud"
  image        = "Rocky Linux 9"

  instances = {
    mgmt   = { type = "b2-7", tags = ["puppet", "mgmt", "nfs"], count = 1 }
    login  = { type = "b2-7", tags = ["login", "public", "proxy"], count = 1 }
    node   = { type = "b2-7", tags = ["node"], count = 1 }
  }

  # var.pool is managed by Slurm through Terraform REST API.
  # To let Slurm manage a type of nodes, add "pool" to its tag list.
  # When using Terraform CLI, this parameter is ignored.
  # Refer to Magic Castle Documentation - Enable Magic Castle Autoscaling
  pool = var.pool

  volumes = {
    nfs = {
      home     = { size = 10 }
      project  = { size = 50 }
      scratch  = { size = 50 }
    }
  }
  public_keys = [file("~/.ssh/id_rsa.pub")]

  nb_users     = 3
  # Shared password, randomly chosen if blank
  guest_passwd = "starfish"

}

output "accounts" {
  value = module.ovh.accounts
}

output "public_ip" {
  value = module.ovh.public_ip
}

## Uncomment to register your domain name with CloudFlare
# module "dns" {
#   source           = "./dns/cloudflare"
#   name             = module.ovh.cluster_name
#   domain           = module.ovh.domain
#   public_instances = module.ovh.public_instances
# }

## Uncomment to register your domain name with Google Cloud
# module "dns" {
#   source           = "./dns/gcloud"
#   project          = "your-project-id"
#   zone_name        = "you-zone-name"
#   name             = module.ovh.cluster_name
#   domain           = module.ovh.domain
#   public_instances = module.ovh.public_instances
# }

output "hostnames" {
  value = module.dns.hostnames
}