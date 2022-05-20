This module is a variant of:
```
modules/aws/lambda/standard
```
to be used when we don't want an IAM role to be created (because it has been previously created).

In this module, the IAM role is passed as a parameter (var.execution_role)