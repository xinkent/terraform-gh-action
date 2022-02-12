terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  project = "xinkent-cloudrun-sample"
  region  = "asia-northeast1"
  zone    = "asia-northeast1-b"
}

resource "google_pubsub_topic" "sample_topic" {
  name = "sample-topic"
}

resource "google_cloud_scheduler_job" "sample_job" {
  name        = "sample-job"
  description = "sample job"
  schedule    = "*/10 * * * *"

  pubsub_target {
    # topic.id is the topic's full resource name.
    topic_name = google_pubsub_topic.sample_topic.id
    data       = base64encode("test")
  }
}


