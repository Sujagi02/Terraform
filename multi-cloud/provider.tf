provider "aws" {
	profile = "default"
	region = "ap-south-1"
}

provider "google" {
	project = "Tf-multi-cloud"
	region = "ap-south-1"
	credentials = file("/Users/sujag/Downloads/credentials.json")
}