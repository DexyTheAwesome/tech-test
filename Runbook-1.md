Runbook-1: Deploying Infrastructure to us-west1 region
This runbook provides step-by-step instructions to deploy the infrastructure to the us-west1 region using Terraform.

Prerequisites
- Terraform is installed on your machine.
- Google Cloud Platform account with appropriate permissions.

Steps
- Clone the repository containing the Terraform files.
`git clone <repository_url>`

- Navigate to the directory where the Terraform files are stored.
`cd <repository_name>/terraform`

- Initialize the Terraform workspace to download necessary plugins.
`terraform init`

- Configure the Terraform backend to store the state in a Google Cloud Storage bucket.
`terraform backend configure -backend-config="bucket=<bucket_name>" -backend-config="prefix=<prefix_name>"`

- Modify the terraform.tfvars file to include the necessary variables for the us-west1 region. For example, change the region variable to "us-west1".
`gcp_region = "us-west1"`

- Plan the infrastructure deployment to review the changes before applying them.
`terraform plan`

- Apply the changes to deploy the infrastructure to the us-west1 region.
`terraform apply`

- Confirm the deployment by checking the Google Cloud Console for the resources that were created.

Benefex Notes
It is important to review the plan before applying changes to ensure there are no unintended consequences.
The backend configuration should be modified to store state in a secure and accessible location.