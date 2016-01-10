resource "aws_eip" "nat" {
  count             = "${length(split(",", var.public_subnets))}"

  vpc = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat" {
  count         = "${length(split(",", var.public_subnets))}"

  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(split(",", var.subnet_ids), count.index)}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table" "nat" {
  count  = "${length(split(",", var.public_subnets))}"

  vpc_id = "${var.vpc_id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.nat.*.id, count.index)}"
  }

  tags {
    Name        = "${var.name}"
    Environment = "${var.environment}"
    Service     = "nat"
  }

  lifecycle {
    create_before_destroy = true
  }
}
