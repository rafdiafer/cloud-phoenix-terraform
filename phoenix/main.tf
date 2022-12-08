provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

resource "aws_key_pair" "instance_key" {
  key_name   = var.aws_key_pair_name
  public_key = file(var.aws_public_key_path)
}

module "app" {
  source                              = "./modules/app"
  app_name                            = var.app_name
  environment                         = var.environment
  aws_region                          = var.aws_region
  cluster                             = module.containers_cluster.cluster
  min_size                            = var.min_size
  max_size                            = var.max_size
  ecr_image_url                       = var.ecr_image_url
  alb_target_group                    = module.containers_cluster.alb_target_group
  container_name                      = var.container_name
  container_port                      = var.container_port
  sns_subscription_email_address_list = var.sns_subscription_email_address_list
  resource_label                      = "${module.containers_cluster.resource_label}/${module.containers_cluster.resource_label_target}"

  depends_on = [module.networks.nat_gw, module.containers_cluster.cluster, module.containers_cluster.alb_target_group]
}

module "networks" {
  source      = "./modules/networks"
  app_name    = var.app_name
  environment = var.environment
  aws_az      = var.aws_az
  cidr_block  = var.cidr_block
}

module "bastion_host" {
  source                 = "./modules/bastion_host"
  app_name               = var.app_name
  aws_az                 = var.aws_az
  vpc_id                 = module.networks.vpc_id
  subnet_id              = module.networks.public_subnet_ids
  bastion_host_ami       = var.bastion_host_ami
  instance_type          = var.instance_type
  aws_key_pair_name      = var.aws_key_pair_name
  source_ip_bastion_host = var.source_ip_bastion_host

  depends_on = [module.networks.nat_gw]
}

module "containers_cluster" {
  source             = "./modules/containers_cluster"
  app_name           = var.app_name
  aws_region         = var.aws_region
  environment        = var.environment
  vpc_id             = module.networks.vpc_id
  instance_type      = var.instance_type
  aws_key_pair_name  = var.aws_key_pair_name
  min_size           = var.min_size
  max_size           = var.max_size
  private_subnet_ids = module.networks.private_subnet_ids
  public_subnet_ids  = module.networks.public_subnet_ids
  bastion_sg         = module.bastion_host.bastion_sg

  depends_on = [module.networks.nat_gw, module.bastion_host.bastion_sg]
}

module "db" {
  source                 = "./modules/db"
  app_name               = var.app_name
  aws_region             = var.aws_region
  vpc_id                 = module.networks.vpc_id
  subnet_id              = module.networks.private_subnet_ids
  aws_az                 = var.aws_az
  instance_type          = var.instance_type
  bastion_sg             = module.bastion_host.bastion_sg
  cidr_block             = var.cidr_block
  mongo_container_cpu    = var.mongo_container_cpu
  mongo_container_memory = var.mongo_container_memory
  mongo_version          = var.mongo_version
  mongo_username         = var.mongo_username
  mongo_root_pass        = var.mongo_root_pass
  mongo_user_pass        = var.mongo_user_pass
  ecs_security_group     = module.containers_cluster.ecs_security_group

  depends_on = [module.networks.nat_gw, module.containers_cluster.ecs_security_group]
}

module "pipeline" {
  source                   = "./modules/pipeline"
  app_name                 = var.app_name
  github_personal_token    = var.github_personal_token
  github_repo              = var.github_repo
  github_repo_name         = var.github_repo_name
  github_branch            = var.github_branch
  github_owner             = var.github_owner
  ecr_image_url            = var.ecr_image_url
  ssm_mongo_connection_url = module.db.ssm_mongo_connection_url

  depends_on = [module.db.ssm_mongo_connection_url]
}