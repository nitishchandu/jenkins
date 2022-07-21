module "jenkins-vm" {
    source = "gcs::https://www.googleapis.com/storage/v1/roi-materials/terraform"
    project_id= "poised-cortex-357007"
    ip_address = "34.82.122.23"
    
}
