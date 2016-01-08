output "route_table_ids" {
  value = "${join(",", aws_route_table.nat.*.id)}"
}
