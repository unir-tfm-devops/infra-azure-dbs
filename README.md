# Azure PostgreSQL Infrastructure with Terraform

This repository contains Terraform configurations for managing Azure PostgreSQL Flexible Server instances and databases. It provides a complete infrastructure setup for both test and production environments.

## 🏗️ Infrastructure Overview

This Terraform project manages:

- **Azure PostgreSQL Flexible Servers**: PostgreSQL 16 instances for test and production environments
- **Resource Groups**: Centralized resource management
- **Database Management**: Automated database and user creation using PostgreSQL provider
- **Multi-Environment Support**: Separate configurations for test and production
- **Firewall Rules**: Network access control for database instances

## 📁 Project Structure

```
infra-azure-dbs/
├── main.tf                 # PostgreSQL Flexible Server instances configuration
├── providers.tf            # Azure and PostgreSQL provider configurations
├── outputs.tf              # Output values for endpoints
├── databases-test.tf       # Test environment databases
├── databases-prod.tf       # Production environment databases
├── backend.tf              # Terraform backend configuration (Azure Storage)
└── modules/
    └── database/
        ├── main.tf         # Database and user creation logic
        ├── variables.tf    # Module input variables
        ├── outputs.tf      # Module output values
        └── versions.tf     # Module version constraints
```

## 🚀 Features

### PostgreSQL Flexible Servers
- **PostgreSQL 16** engine
- **B_Standard_B1ms** compute tier (suitable for development/testing)
- **32GB** allocated storage
- **Public network access** enabled for development purposes
- **Zone redundancy** configured for high availability
- **Password authentication** enabled

### Resource Management
- Dedicated resource group: `unir-tfm-postgres-dbs-rg`
- East US region deployment
- Proper tagging for resource identification

### Database Management
- Automated database creation with UTF8 encoding
- User/role creation with proper permissions
- Schema-level privileges management
- Support for multiple databases per environment

### Networking & Security
- Public network access enabled
- Firewall rules allowing access from all IPs (development only)
- SSL connections required
- Connection timeout configuration

## 🔧 Prerequisites

- **Terraform** >= 1.0
- **Azure CLI** configured with appropriate credentials
- **PostgreSQL provider** for Terraform
- **Azure Storage Account** for Terraform state management

## 📋 Requirements

### Azure Requirements
- Azure subscription with appropriate permissions for:
  - PostgreSQL Flexible Server creation and management
  - Resource group management
  - Storage account access (for Terraform state)
  - Network security group and firewall rule management

### Terraform Providers
- `hashicorp/azurerm` - Azure provider
- `cyrilgdn/postgresql` - PostgreSQL provider
- `hashicorp/time` - Time provider for wait conditions

## 🚀 Quick Start

### 1. Configure Azure Backend
Ensure your Azure Storage Account is configured for Terraform state:
```bash
# The backend is already configured in backend.tf
# Make sure the storage account exists and is accessible
```

### 2. Initialize Terraform
```bash
terraform init
```

### 3. Review the Plan
```bash
terraform plan
```

### 4. Apply the Configuration
```bash
terraform apply
```

### 5. Access Database Endpoints
After successful deployment, you can retrieve the database endpoints:
```bash
terraform output postgres_db_test_endpoint
terraform output postgres_db_prod_endpoint
```

## 🔐 Security Considerations

⚠️ **Important Security Notes:**

- **Public Network Access**: PostgreSQL servers are configured with `public_network_access_enabled = true` for development purposes
- **Firewall Rules**: Currently allows access from `0.0.0.0/0` to `255.255.255.255` (all IPs) - **NOT recommended for production**
- **Default Credentials**: Uses default PostgreSQL credentials - **change for production use**

### Production Security Recommendations

1. **Disable Public Access**: Set `public_network_access_enabled = false`
2. **Restrict Firewall Rules**: Limit IP ranges to specific CIDR blocks
3. **Use Azure Key Vault**: Store database credentials in Azure Key Vault
4. **Enable Encryption**: Enable Azure PostgreSQL encryption at rest
5. **Enable Monitoring**: Set up Azure Monitor and Log Analytics
6. **Use Strong Passwords**: Implement proper password policies
7. **Private Endpoints**: Use Azure Private Endpoints for secure connectivity

## 🔄 Module Usage

The `modules/database` module can be used to create additional databases:

```hcl
module "my_database" {
  source = "./modules/database"

  database_name = "my-app-db"
  username      = "my-app-user"
  password      = "secure-password"

  depends_on = [time_sleep.wait_for_db]

  providers = {
    postgresql = postgresql.test  # or postgresql.prod
  }
}
```

## 📊 Outputs

| Output | Description |
|--------|-------------|
| `postgres_db_test_endpoint` | Test PostgreSQL server endpoint |
| `postgres_db_prod_endpoint` | Production PostgreSQL server endpoint |

## 🧹 Cleanup

To destroy all resources:
```bash
terraform destroy
```

⚠️ **Warning**: This will permanently delete all PostgreSQL servers and their data.

## 🔧 Customization

### Server Configuration
Modify `main.tf` to adjust:
- Compute tier (`B_Standard_B1ms`)
- Storage size (`storage_mb`)
- Engine version
- Zone configuration

### Resource Management
Modify `main.tf` to adjust:
- Resource group name and location
- Server naming conventions
- Tags and metadata

### Database Creation
Modify `databases-test.tf` and `databases-prod.tf` to:
- Add new databases
- Change database names
- Modify user credentials

### Backend Configuration
Modify `backend.tf` to adjust:
- Storage account details
- Container name
- State file path

## 📝 Notes

- **Wait Time**: A 30-second wait is configured after PostgreSQL server creation to ensure instances are fully available
- **Dependencies**: Database modules depend on PostgreSQL servers being ready
- **Provider Aliases**: Separate PostgreSQL providers are used for test and production environments
- **State Management**: Terraform state is stored in Azure Storage for team collaboration

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with `terraform plan`
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
