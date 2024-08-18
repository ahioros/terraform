# terraform-local and awscli-local

All examples are using terraform-local and awscli-local tools to run use localstack container or install it with pip.

## Localstack
Examples using localstack

## How to use

    Prerequisites:
        pre-commit: https://pre-commit.com
        localstack must be running:
     ```bash
        docker run -d --rm -it -p 4566:4566 -p 4510-4559:4510-4559 localstack/localstack
    ```

    1. Enter any example name above.
    2. Create and activate a Python virtual environment
    ```bash
        python3 -m venv venv
        source venv/bin/activate
    ```
    3. Install dependencies
    ```bash
        pip install awscli-local
        pip install terraform-local
    ```
    4. Run the example
    ```bash
        tflocal init
        tflocal plan
        tflocal apply
    ```
    5. Validate the bucket creation example
    ```bash
        awslocal s3 ls
    ```

## example-1

    * Create a S3 bucket in the us-east-1 region.
    * Create two ec2 instances in the same region.

## example-2

Working with Outputs

    * Create 1 VPC
    * Create 1 subnet
    * Create 1 ec2 instances in the subnet
    * show the ip address of the ec2 instances (ouputs)

## example-3

    * Create 1 VPC
    * Create 2 subnets (private and public)
    * Create security groups for each network
    * Create 1 internet gateway
    * Create 1 bastion server
    * Create 1 webserver
    * Create 1 mysqlserver

## example-4

    * Locals

## example-4-1

    * Create a VPC
    * Create 3 subnets using variable
        * Using locals
        * using foreach loop

## template

Here you can find a template for your project.
The requirements are listed in requirements.txt
A bash script for localstack restore.

 two differents terraform providers:
    - local backend
    - remote s3 backend

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
