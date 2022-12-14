locals {
    json_files = fileset("../files-projects","*.json")  
    json_data= { for file_name in local.json_files :
                replace(file_name, ".json", "")=>jsondecode(file("../files-projects/${file_name}"))} 

}


module "project-factory" {
  source = "terraform-google-modules/project-factory/google"
  version = "~> 14.1"
  for_each = local.json_data

  name               = each.value.name
  random_project_id  = true
  random_project_id_length =4  
  org_id             = each.value.org_id
  billing_account    = each.value.billing_account
  auto_create_network = each.value.auto_create_network
  activate_apis       = []

  svpc_host_project_id= each.value.svpc_host_project_id
  shared_vpc_subnets = each.value.shared_vpc_subnets
  group_name         = each.value.group_name
  group_role         = each.value.group_role
  folder_id          = each.value.folder_id 
  create_project_sa  = each.value.create_project_sa
  default_service_account= each.value.default_service_account
}


output "output-value" {
  value = module.project-factory
}


/*
GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud --impersonate-service-account=sa-project-factory@devops-369900.iam.gserviceaccount.com auth print-access-token)" terraform apply -var-file=02-terraform.tfvars
*/