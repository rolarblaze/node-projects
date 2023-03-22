data "aws_iam_policy_document" "ecs_task_exec_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }

  }
}

#create an IAM role
resource "aws_iam_role" "ecs_task_exec_role" {
  name = "${project_name}-ecs-task-exec-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = data.aws_iam_policy_document.ecs_task_exec_role_policy.json

  tags = {
    tag-key = "tag-value"
  }
}

# attach the ecs execution policy to the role
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ecs_task_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}