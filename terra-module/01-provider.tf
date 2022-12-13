/*we used this article

https://github.com/terraform-google-modules/terraform-google-project-factory/blob/master/modules/gsuite_enabled/README.md
*/
terraform {
  backend "gcs" {
    bucket  = "app-lovin-tf-states"
    prefix  = "tf-state-project-factory/tf-state-project-factory"
  }  
    
  required_providers { 
    google = {
      source = "hashicorp/google"
      version = ">4.43,<=5"       //this is the hashicorp modules version
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

