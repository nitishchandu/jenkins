module "jenkins-vm" {
    source = "gcs::https://www.googleapis.com/storage/v1/roi-materials/terraform"
    project_id= "roidtc-june22-u111"
    ip_address = "103.42.248.65"
    
}