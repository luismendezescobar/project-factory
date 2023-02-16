locals {
    json_files = fileset("../files-projects","*.json")  
    json_data= { for file_name in local.json_files :
                replace(file_name, ".json", "")=>jsondecode(file("../files-projects/${file_name}"))} 

}

module "project-factory" {
  source   = "terraform-google-modules/project-factory/google"
  version  = "~> 14.1"
  for_each = local.json_data

  name                     = each.key
  random_project_id        = each.value.random_project_id
  random_project_id_length = each.value.random_project_id_length
  org_id                   = each.value.org_id
  billing_account          = each.value.billing_account
  svpc_host_project_id     = each.value.svpc_host_project_id
  folder_id                = each.value.folder_id  
  labels                   = each.value.labels
  auto_create_network      = each.value.auto_create_network
  shared_vpc_subnets       = each.value.shared_vpc_subnets
  activate_apis            = each.value.activate_apis    
  default_service_account  = each.value.default_service_account
  create_project_sa        = each.value.create_project_sa
  lien                     = each.value.lien
  project_id               = each.value.project_id
  budget_amount            = null

}

/*
GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud --impersonate-service-account=sa-project-factory@devops-369900.iam.gserviceaccount.com auth print-access-token)" terraform apply -var-file=02-terraform.tfvars
*/