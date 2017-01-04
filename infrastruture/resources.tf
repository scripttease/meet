resource "aws_ecr_repository" "container_repository" {
  name = "meet-${var.env}"
}
