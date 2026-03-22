output "created_filenames" {
  value = [
    for file in local_file.user_files :
    file.filename
  ]
}