resource "aws_redshift_cluster" "cluster" {
  cluster_identifier  = var.settings.cluster_identifier
  database_name       = var.settings.database_name
  master_username     = var.settings.master_username
  master_password     = var.settings.master_password
  node_type           = var.settings.node_type
  cluster_type        = var.settings.cluster_type
  iam_roles           = [var.iam_roles]
  skip_final_snapshot = var.settings.skip_final_snapshot
  vpc_security_group_ids = [aws_security_group.redshift_security_group.id]
  publicly_accessible    = var.settings.publicly_accessible
  number_of_nodes        = var.settings.number_of_nodes
  cluster_subnet_group_name = aws_redshift_subnet_group.subnet_group.name
  
}

resource "aws_redshift_subnet_group" "subnet_group" {
  name       = "${var.resource_prefix}-subnet-group"
  subnet_ids = var.settings.private_subnet_ids

  tags = {
    environment = "${var.resource_prefix}-subnet-group"
  }
}

resource "aws_security_group" "redshift_security_group" {
  vpc_id      = var.settings.vpc_id
  name        = "${var.resource_prefix}-redshift-sg"
  description = "security group that allows  ingress and  egress traffic to neptune cluster"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.resource_prefix}-redshift-sg"
  }
}