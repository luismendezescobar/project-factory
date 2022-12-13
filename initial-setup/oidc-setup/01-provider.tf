/*we used this article

*/
terraform {
  backend "gcs" {
    bucket  = "app-lovin-tf-states"
    prefix  = "tf-state-project-factory/tf-state-project-factory-oidc-setup"    
  }  
  
  required_version = "~> 1.3"  //terraform version required in the shell
  required_providers { 
    google = {
      source = "hashicorp/google"
      version = "~>4.43"       //this is the hashicorp modules version
    }
  }
}
provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}