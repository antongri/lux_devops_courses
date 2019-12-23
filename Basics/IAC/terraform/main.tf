provider "google-beta" {
  credentials = file("terraform.json")
  project     = var.project_name
  region      = var.region
}

module "gke" {
  version                    = "6.1.1"
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.project_id
  name                       = var.k8s_name
  kubernetes_version         = "1.14"
  regional                   = false
  region                     = var.region
  zones                      = var.zones
  network                    = var.network
  subnetwork                 = var.subnetwork
  ip_range_pods              = var.ip_range_pods
  ip_range_services          = var.ip_range_services
  create_service_account     = false
  service_account            = var.compute_engine_service_account
  skip_provisioners          = var.skip_provisioners
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = true
  grant_registry_access      = true

  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "n1-standard-2"
      min_count          = 1
      max_count          = 6
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = var.compute_engine_service_account
      preemptible        = true
      initial_node_count = 5
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}

# resource "null_resource" "local_exec" {
#     provisioner "local-exec" {
#     command = "sh deploy.sh"
#     depends_on = 
#   }
# }

