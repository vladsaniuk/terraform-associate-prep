bucket = "vlad-sanyuk-tfstate-bucket-dev"
key    = "terraform/count-index.tfstate"
region = "us-east-1"
encrypt = true
dynamodb_table = "state_lock"