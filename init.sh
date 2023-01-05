#/bin/bash
set -e

PROJECT_ID=$(gcloud config get-value project)
FULL_PR_KEYS_PATH=~/.ssh/id_rsa
SSH_USER=$(whoami)

echo "Bucket name(default if not stated):"
read BUCKET
if [ -z ${BUCKET} ]
  then
    BUCKET="terraform_state_bucket"
fi
TERRAFORM_BUCKET="${BUCKET}"

echo "Enabling required API's"
gcloud services enable \
  cloudresourcemanager.googleapis.com \
  --project ${PROJECT_ID}

gcloud services enable \
  iam.googleapis.com \
  --project ${PROJECT_ID}

gcloud services enable \
  admin.googleapis.com \
  --project ${PROJECT_ID}

gcloud services enable \
  compute.googleapis.com \
  --project ${PROJECT_ID}

gcloud services enable \
  cloudkms.googleapis.com \
  --project ${PROJECT_ID}

gcloud services enable \
  cloudbuild.googleapis.com \
  --project ${PROJECT_ID}

gcloud services enable \
  sqladmin.googleapis.com \
  --project ${PROJECT_ID}

gcloud services enable \
  servicenetworking.googleapis.com \
    --project=${PROJECT_ID}

gcloud services enable \
  container.googleapis.com \
    --project=${PROJECT_ID}

gcloud services enable \
  secretmanager.googleapis.com \
    --project=${PROJECT_ID}


FULL_PUB_KEYS_PATH="${FULL_PR_KEYS_PATH}.pub"
SSH_KEY_CONTENT=`cat  ${FULL_PUB_KEYS_PATH}`
echo "${SSH_USER}:${SSH_KEY_CONTENT}" > project_key.txt

gcloud compute project-info add-metadata --metadata-from-file=ssh-keys=project_key.txt
rm project_key.txt


gsutil mb -p ${PROJECT_ID} -c regional -l "europe-west1" gs://${TERRAFORM_BUCKET}
gsutil versioning set on gs://${TERRAFORM_BUCKET}


export TF_VAR_bucket=$TERRAFORM_BUCKET

terraform init -backend-config=bucket=$TF_VAR_bucket
terraform plan