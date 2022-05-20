# Terraform modules

[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

[![Terraform](https://datadog-prod.imgix.net/img/blog/managing-datadog-with-terraform/terraform_hero.png)](https://www.terraform.io/)

## Description

The idea behind this approach is to use modules as a single source and re-usable this modules across different AWS accounts and configurations.

## How to use it

There are two approach to use it:

- The first one is to copy the **folder modules** into your project and use it by pointing the source to your module.
  - Example: source = "../../../../../modules/sqs/standard"
- The second approach is to point your terraform stack to this branch.
  - Example: source = "git::ssh://git@github.com:JoaoBrandao/terraform.git//modules//aws//sqs//standard?ref=v1.21"

### Example of using terraform modules

**main.tf**

```
provider "aws" {
  region = var.region
}

######################################################
#                       SQS                          #
######################################################
module "sqs-queue-example" {
  source = "git::ssh://git@github.com:JoaoBrandao/terraform.git//modules//aws//sqs//standard?ref=v1.21"

  name                       = var.sqs_queue_name
  policy                     = data.aws_iam_policy_document.sqs-policy.json
  visibility_timeout_seconds = var.sqs_timeout
  tag_env                    = var.tag_env
  other_tags                 = var.other_tags
}
```

**data.tf**

```
######################################################
#                       SQS                          #
######################################################

sqs-ods-snowflake-policy.json
data "aws_caller_identity" "current" {
}

data "aws_iam_policy_document" "sqs-policy" {
  statement {
    effect = "Allow"

    // https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_identity-vs-resource.html
    actions = ["sqs:*"] // add all your permission! '*' its not a good practice.

    resources = ["arn:aws:sqs:${var.region}:${data.aws_caller_identity.current.account_id}:${var.sqs_queue_name}"]

    principals {
      identifiers = ["*"]
      type        = "AWS"
    }

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [module.sns-random.arn]
    }
  }
}


```

**variables.tf**

```
variable "region" {
  description = "AWS region where the stack is being launched"
  default     = "eu-central-1"
}

######################################################
#                       SQS                          #
######################################################

variable "sqs_queue_name" {
  description = "Some description for this sqs name"
  default     = "terraform-jb-example"
}

variable "sqs_timeout" {
  description = "The visibility timeout for the queue, in seconds. An integer from 0 to 43200 (12 hours)"
  default     = "900"
}

/* Tag used to define the environemnt */
variable "tag_env" {
  description = "The environment this resource is being launched"
  default     = "development"
}

/* Add as many tags as you need */
variable "other_tags" {
  description = "Tags used to identify resources that belong to this project's stack"
  type        = map(string)
  default = {
    ManagedBy    = "<your-name>"
    CreateDate   = "<current-date>"
    Description    = "<service description>"
    Tier           = "Application"
  }
}


```

**Suggestion to folder structure:**

```
iac
│   README.md
└───<cloud name>
│   └───<account_id>
│       └───<aws_region>
│            └───<iac>
│                └───<script_1>
│                │    │ data.tf
│                │    │ variables.tf
│                │    │ main.tf
│                └───<script_2>
│                    │ data.tf
│                    │ variables.tf
│                    │ main.tf
│
└───modules (if you want to have it locally)
    └───sqs
    │   ...
    └───sns
        ...
```

## Upgrate terraform version

You can upgrade your terraform stack using **tfswitch** and **terraform upgrade**.

- tfswitch allows you to change from the version x to y and vice-versa.
- terraform upgrade allows you to upgrade your current version to a specific version.

[tfswitch documentation](https://tfswitch.warrensbox.com/Install/)

[terraform upgrade](https://www.terraform.io/upgrade-guides/0-12.html)

## Contribution

Feel free to use it and change it if you need.
