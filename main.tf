# Example demonstrating a simple resource.

resource "null_resource" "example" {
  triggers = {
    always_run = timestamp()
  }
}