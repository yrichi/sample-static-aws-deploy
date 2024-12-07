variable "aws_region" {
  description = "Région AWS où déployer les ressources"
  type        = string
  default     = "eu-west-3"
}

variable "bucket_name" {
  description = "Nom du bucket S3 existant"
  type        = string
  default     = "test-sandbox-azerty-2"
}

variable "local_src_directory" {
  description = "Répertoire local contenant les fichiers à uploader"
  type        = string
  default     = "./src"
}

variable "content_type_mapping" {
  description = "Mapping des extensions de fichier vers leurs types MIME"
  type        = map(string)
  default     = {
    html = "text/html",
    css  = "text/css",
    js   = "application/javascript",
    png  = "image/png",
    jpg  = "image/jpeg",
    svg  = "image/svg+xml",
    json = "application/json"
  }
}