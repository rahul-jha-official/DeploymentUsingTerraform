# Deployment using Terraform

**How to install terraform ?**</br></br>
First we need to install 3rd party tool "chocolatey"
- Open Powershell as an Administrator
- Run **Get-ExecutionPolicy**. If it returns Restricted, then run **Set-ExecutionPolicy AllSigned** or **Set-ExecutionPolicy Bypass -Scope** Process.
- Then run **Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))**
- If you don't see any errors, you are ready to use Chocolatey! Type **choco** or **choco -?** now, or see Getting Started for usage instructions.

Now run the command **choco install terraform** to install terraform.</br></br>

**Prerequesite:**</br>
- Install Azure CLI. Run the below command: 
  $ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -Uri https://aka.ms/installazurecliwindowsx64 -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; Remove-Item .\AzureCLI.msi
- VS Code with the following extensions:
  - Terraform
  - Azure Terraform
 
**Important Links**</br>
- https://github.com/HoussemDellai/terraform-course/
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

**Terraform Basics**</br>
Terraform is an open-source infrastructure as code (IaC) tool developed by HashiCorp. It is used for defining and provisioning infrastructure resources in a declarative and automated manner. Terraform allows you to describe your desired infrastructure configuration in code, typically using a domain-specific language (DSL) called HashiCorp Configuration Language (HCL). With Terraform, you can define resources such as virtual machines, networks, storage, databases, and more, as well as their configurations and relationships.</br>
Here are some key features and concepts associated with Terraform:
- **Declarative Syntax:** Terraform uses a declarative approach, where you define the desired state of your infrastructure in code, rather than writing step-by-step procedural scripts.
- **Resource Providers:** Terraform supports a wide range of providers, including those for popular cloud platforms like AWS, Azure, Google Cloud, as well as providers for on-premises infrastructure, databases, and other services.
- **Dependency Management:** Terraform automatically manages resource dependencies, ensuring that resources are provisioned and configured in the correct order.
- **Plan and Apply:** You can use Terraform to generate a "plan" that shows what changes will be made to your infrastructure before actually applying those changes. This helps prevent accidental or unexpected modifications.
- **State Management:** Terraform keeps track of the current state of your infrastructure in a state file. This file is used to compare the desired state (defined in your code) with the current state and determine what changes need to be made.
- **Modularity and Reusability:** Terraform configurations can be organized into modules, allowing you to reuse and share infrastructure code across projects.
- **Version Control:** Terraform configurations are typically stored in version control systems (e.g., Git), enabling collaboration and change tracking.
- **Extensibility:** Terraform is extensible through its plugin system, which allows you to create custom providers or provisioners if needed.

Terraform has gained widespread popularity in the DevOps and infrastructure automation communities because it provides a consistent and version-controlled way to manage and scale infrastructure, making it easier to implement Infrastructure as Code (IaC) practices.

![Terraform Basic](https://github.com/rahul-jha-official/DeploymentUsingTerraform/assets/138975150/ad0b4681-ac68-4118-81c0-6beb505b3a48)


# Terraform Commands
![image](https://github.com/rahul-jha-official/DeploymentUsingTerraform/assets/138975150/6a4aabe9-8c81-4706-98f6-2ffed510e699)


**Terraform Variables**</br>
Create a separate file for variables. By convention we can name "variables.tf"
> Syntax for declaring & Initializing a variable</br>

    variable "VARIABLE_NAME" {
      default     = "VARIABLE_VALUE"
      type        = "TYPE_OF_VARIABLE"
      description = "DESCRIPTION_FOR_VARIABLE"
    }

> Syntax for using variable</br>
  
    var.VARIABLE_NAME

**Overriding variables** </br>
> Declare a variable in variables.tf file

    variable "VARIABLE_NAME" {
      type        = "TYPE_OF_VARIABLE"
      description = "DESCRIPTION_FOR_VARIABLE"
    }
> Create a separate file for overriding a variable "terraform.tfvars"

    VARIABLE_NAME = "VARIABLE_VALUE"

**Output variables** </br>
Output variables are those whose value we can get after resource has been deployed. For example: Resource ID. 

Create a different file for Output variables.

> Syntax for output variable
    
    output "VARIABLE_NAME" {
      value = resource_name.thing_to_be_fetched
    }

# Terraform Execution Plan
**What heappens when we run terraform plan ?**</br>
When we run the following command, the plan file is compared with state file "terraform.tfstate". Initially plan file is not visible. To see the file we have to output that file. To output the file:

    terraform plan -out "plan_file_name"

After comparision the changes are listed.

The terraform.tfstate file will be containing current state, version, terraform version, output variables, resource configuration etc.

# Terraform State
While working locally a state file is generated. While working among a team we do not need separate state file thus we need to centralize the state file and also lock the state file when one is working on the terraform changes.

We can use azure storage container to store state file. For that we can create terraform backend.

    terraform {
      backend "azurerm" {
        resource_group_name = "RESOURCE_GROUP_NAME"
        storage_account_name = "STORAGE_ACCOUNT_NAME"
        container_name = "CONTAINER_NAME"
        key = "terraform.tfstate"
      }
    }

# Variables
Variables in Terraform are a great way to define centrally controlled reusable values. The information in Terraform variables is saved independently from the deployment plans, which makes the values easy to read and edit from a single file. </br>

**Types of Variable**</br>
- Input variables
- Output variables
- Local variables </br>

**Input variables**</br>
[Input variables](https://developer.hashicorp.com/terraform/language/values/variables) are usually defined by stating a name, type and default value. However, the type and default values are not strictly necessary. Terraform can deduct the type of the variable from the default or input value.</br>

Variables can be predetermined in a file or included in the command-line options. As such, the simplest variable is just a name while the type and value are selected based on the input.

> variable "variable_name" {}

> terraform apply -var variable_name="value"

**Types of Input Variables**
- number
- bool
- string
- map
- list
- object

**Arguments**</br>
Terraform CLI defines the following optional arguments for variable declarations:
- default - A default value which then makes the variable optional.
- type - This argument specifies what value types are accepted for the variable.
- description - This specifies the input variable's documentation.
- validation - A block to define validation rules, usually in addition to type constraints.
- sensitive - Limits Terraform UI output when the variable is used in configuration.
- nullable - Specify if the variable can be null within the module.

      variable "StringVar" {
        default = "Hello"
        type = string
        sensitive = false
        description = "This is of type string"    
        validation {
          condition = length(var.StringVar) > 3 && substr(var.StringVar,0,0) == "rg-"
          #condition = can(regex("^rg-",var.StringVar))
          error_message = "The condition fails"
        }
      }

**Output Variables**</br>
Output variables provide a convenient way to get useful information about your infrastructure. As you might have noticed, much of the server details are calculated at deployment and only become available afterwards. Using output variables you can extract any server-specific values including the calculated details.

Configuring output variables is really quite simple. All you need to do is define a name for the output and what value it should represent. For example, you could have Terraform show your server’s IP address after deployment with the output variable below.

      output "public_ip" {
        value = upcloud_server.server_name.network_interface[0].ip_address
      }

