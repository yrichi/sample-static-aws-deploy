# Terraform AWS Test Project

This project is a simple demonstration of using Terraform to provision and manage AWS resources, such as S3 buckets, static website hosting, and associated configurations.

## Features

- Creates an **S3 bucket** for hosting a static website.
- Configures **static website hosting** on the S3 bucket with an index and error document.
- Enables **public access** to the bucket with an appropriate policy.
- Uploads static files to the bucket from a local directory (`./src`).
- Demonstrates advanced Terraform features like variables, outputs, and lifecycle management.

---

## Project Structure

```plaintext
.
├── main.tf               # Main Terraform configuration file
├── variables.tf          # Definition of input variables
├── terraform.tfvars      # Variable values (environment-specific)
├── outputs.tf            # Outputs for the project
└── src/                  # Directory containing static files for upload
```

---

## Prerequisites

- **Terraform** ([Download Terraform](https://www.terraform.io/downloads))
- An **AWS account** with programmatic access configured
- An **IAM user** with sufficient permissions to create and manage S3 buckets

---

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Set up your AWS credentials:**
   Ensure your AWS credentials are properly configured. You can use:
    - AWS CLI (`aws configure`)
    - Environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`)

4. **Customize variables:**
   Update `terraform.tfvars` to set your desired values (e.g., bucket name, region):
   ```hcl
   aws_region       = "eu-west-3"
   bucket_name      = "test-sandbox-azerty-2"
   ```

5. **Plan the infrastructure:**
   ```bash
   terraform plan
   ```

6. **Apply the configuration:**
   ```bash
   terraform apply
   ```

7. **Access the website:**
   Once the deployment is complete, the static website endpoint will be displayed in the output.

---

## File Descriptions

### `main.tf`
- Contains the primary Terraform resources:
    - **S3 bucket** for static website hosting.
    - **Public access policy**.
    - **Website configuration**.
    - **Upload of static files**.

### `variables.tf`
- Defines input variables for customization (e.g., AWS region, bucket name, index document).

### `terraform.tfvars`
- Specifies values for the variables declared in `variables.tf`.

### `src/`
- Directory containing static files to be uploaded to the S3 bucket (e.g., `index.html`, `error.html`).

### `outputs.tf`
- Defines outputs for the project, such as the S3 website endpoint.

---

## Example Outputs

After applying the Terraform configuration, you will see outputs like this:

```plaintext
Outputs:

website_endpoint = "http://test-sandbox-azerty-2.s3-website.eu-west-3.amazonaws.com"
```

---

## Cleanup

To clean up the resources and avoid unnecessary charges, run:

```bash
terraform destroy
```

---

## Notes

- Ensure public access settings are carefully reviewed to prevent unintended exposure of sensitive data.
- Use a backend like S3 with DynamoDB for state management in production.

---

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.