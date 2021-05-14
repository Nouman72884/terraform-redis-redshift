#
# Security Group Resources
#
resource "aws_security_group" "default" {
  description = "${var.resource_prefix}-redis-security-group"
  vpc_id      = var.settings.vpc_id
  name        = "${var.resource_prefix}-redis-security-group"
  tags        = {
    Name = "${var.resource_prefix}-redis-security-group"
  }
}

resource "aws_security_group_rule" "egress" {
  description       = "${var.resource_prefix} Allow outbound traffic from cidr blocks"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
  type              = "egress"
}

resource "aws_security_group_rule" "ingress_cidr_blocks" {
  description       = "${var.resource_prefix} Allow inbound traffic from CIDR blocks"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
  type              = "ingress"
}

resource "aws_elasticache_subnet_group" "default" {
  name       = "${var.resource_prefix}-redis-subnet-group"
  subnet_ids = var.settings.private_subnet_ids
}

resource "aws_elasticache_replication_group" "default" {
  replication_group_id          = var.settings.replication_group_id
  replication_group_description = "${var.resource_prefix}-redis-replication-group"
  node_type                     = var.settings.instance_type
  number_cache_clusters         = var.settings.cluster_size
  port                          = 6379
  subnet_group_name             = aws_elasticache_subnet_group.default.name
  security_group_ids            = [aws_security_group.default.id]
  engine_version                = var.settings.engine_version
  apply_immediately             = var.settings.apply_immediately
  //cluster_mode {
   // replicas_per_node_group = var.settings.
    //num_node_groups         = var.settings.num_node_groups
  //}
  tags = {
    "Name" = "${var.resource_prefix}-redis"
  }
}
