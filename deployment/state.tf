terraform {
  backend "s3" {
    bucket = "assignment1-tfstate"
    key    = "app-state"
    region = "us-east-1"
  }
}
