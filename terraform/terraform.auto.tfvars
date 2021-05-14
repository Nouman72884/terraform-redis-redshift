aws_region = "us-east-1"

red_shift = {
  cluster_identifier  = "rd-shift-cluster"
  database_name       = "redshiftdatabase123"
  master_username     = "jude"
  master_password     = "Password123"
  node_type           = "dc1.large"
  cluster_type        = "single-node"
  number_of_nodes     = 1
  skip_final_snapshot = true
  publicly_accessible = false
  vpc_id              = "vpc-a0eeacda"
  private_subnet_ids  = ["subnet-e2e209ec","subnet-2a82b44d"]
}

redis = {
  vpc_id = "vpc-a0eeacda"
  replication_group_id = "devrediscluster"
  private_subnet_ids  = ["subnet-e2e209ec","subnet-2a82b44d"]
  vpc_id                     = "vpc-a0eeacda"
  cluster_size               = 1
  instance_type              = "cache.t2.micro"
  apply_immediately          = true
  engine_version             = "5.0.6"
  replicas_per_node_group  = 1
  num_node_groups    = 1
}

env = "dev"