#resource "aws_iam_policy" "cortex_auto_scale_policy" {
#  name        = "cortex_auto_scale_policy"
#  path        = "/"
#  description = "auto scale policy for cortex cluster"
#  policy = jsonencode({
#    Version = "2012-10-17"
#    Statement = [
#      {
#        "Effect": "Allow",
#        "Action": "*",
#        "Resource": "*"
#      }
#    ]
#  })
#}
#
#resource "aws_iam_role" "cortex_auto_scale_role" {
#  name = "cortex_auto_scale_role"
#  path = "/"
#  assume_role_policy = <<EOF
#{
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Effect": "Allow",
#            "Principal": {
#                "Service": "ec2.amazonaws.com"
#            },
#            "Action": "sts:AssumeRole"
#        }
#    ]
#}
#EOF
#}
#
#resource "aws_iam_role_policy_attachment" "cortex_auto_scale_role_attach" {
#  role       = aws_iam_role.cortex_auto_scale_role.name
#  policy_arn = aws_iam_policy.cortex_auto_scale_policy.arn
#}