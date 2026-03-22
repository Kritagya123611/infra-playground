resource "local_file" "user_files" {
  for_each = toset(var.users)

  filename = "${var.prefix}_${each.value}_v${var.file_version}.txt"

  content = <<EOF
User: ${each.value}
Environment: ${var.environment}
Version: ${var.file_version}
EOF
}