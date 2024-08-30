locals {
  public_subnet = {
    for key, config in var.subnet_config : key => config if config.public
  }
}


# -------------------------------------- igw -------------------------------------- #
# Create only one if there's at least one public subnet
resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id
  count = length(local.public_subnet) > 0 ? 1 : 0
}


# -------------------------------------- route table -------------------------------------- #
# Create ONLY one if there's at least one public subnet
resource "aws_route_table" "main" {
  vpc_id = var.vpc_id
  count = length(local.public_subnet) > 0 ? 1 : 0

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main[0].id
  }
}

# associate with public subnets
resource "aws_route_table_association" "main" {
  for_each = local.public_subnet

  subnet_id =  var.subnets[each.key].id
  route_table_id = aws_route_table.main[0].id
}
