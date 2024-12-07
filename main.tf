provider "aws" {
  region = var.aws_region
}

# Déclaration du bucket existant
resource "aws_s3_bucket" "test_sandbox" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.test_sandbox.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# Désactiver Block Public Access
resource "aws_s3_bucket_public_access_block" "test_sandbox_block" {
  bucket                  = aws_s3_bucket.test_sandbox.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Politique du bucket pour rendre les objets publics
resource "aws_s3_bucket_policy" "test_sandbox_policy" {
  depends_on = [aws_s3_bucket_public_access_block.test_sandbox_block]

  bucket = aws_s3_bucket.test_sandbox.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.test_sandbox.arn}/*"
      }
    ]
  })
}

output "file_src" {
  value = fileset(var.local_src_directory, "**")
}

# Téléverser des fichiers dans le bucket avec aws_s3_object
resource "aws_s3_object" "src" {
  for_each = fileset(var.local_src_directory, "**")

  bucket = aws_s3_bucket.test_sandbox.id
  key    = each.value
  source = "${var.local_src_directory}/${each.value}"

  # Détection automatique du type MIME
  content_type = lookup(
    var.content_type_mapping,
    regex("([^.]+)$", each.value)[0], # Récupère l'extension avec une regex
    "application/octet-stream"        # Type par défaut si l'extension n'est pas reconnue
  )

  etag = filemd5("${var.local_src_directory}/${each.value}")

  # Supprime les fichiers obsolètes dans le bucket
  lifecycle {
    prevent_destroy = false
  }
}
