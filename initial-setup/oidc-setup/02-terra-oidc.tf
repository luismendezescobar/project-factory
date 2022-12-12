#it's based on the below articles
#https://github.com/terraform-google-modules/terraform-google-github-actions-runners/tree/master/modules/gh-oidc
#https://github.com/marketplace/actions/authenticate-to-google-cloud

#First do the following commands in the shell
/*
gcloud services enable iam.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable iamcredentials.googleapis.com
gcloud services enable sts.googleapis.com
*/
#PROJECT_ID=playground-s-11-466b1a34
#gcloud iam service-accounts create "luis-service-account" \
#  --project "${PROJECT_ID}"
#gsutil mb gs://luis-10-24-2022
#echo "some file to see"> somefile.txt
#gsutil cp somefile.txt gs://luis-10-22-2022
#gcloud projects add-iam-policy-binding $PROJECT_ID \
#    --member serviceAccount:luis-service-account@$PROJECT_ID.iam.gserviceaccount.com \
#    --role roles/storage.admin

/* this module is going to create 3 elements:
1.google iam workload identity pool
2.google iam worload identity pool provider, this one is going to use the element of number 1
3.add the sa-pipeline-aim to the role roles/iam.workloadIdentityUser for the prinicpal set (run as area)
*/
module "gh_oidc" {
  source      = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id  = var.project_id
  pool_id     = "pool-for-iam-pipeline"
  provider_id = "iam-pipline-gh-provider"
  sa_mapping = {
    "sa-pipeline-iam" = {
      sa_name   = "projects/${var.project_id}/serviceAccounts/sa-pipeline-iam@devops-369900.iam.gserviceaccount.com"
      attribute = "attribute.repository/luismendezescobar/iam-permissions"
    }
  }
}

output "module_output" {
  value = module.gh_oidc
}

/*
module_output = {
  "pool_name" = "projects/78413760016/locations/global/workloadIdentityPools/pool-for-iam-pipeline"
  "provider_name" = "projects/78413760016/locations/global/workloadIdentityPools/pool-for-iam-pipeline/providers/iam-pipline-gh-provider"
}
*/