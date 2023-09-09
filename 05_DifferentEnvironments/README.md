# Deploy resource to different environment

Command for different environment
> dev

    terraform plan -out .\dev\dev.tfplan -state .\dev\dev.state -var-file .\dev\dev.tfvars

> qa

    terraform plan -out .\qa\qa.tfplan -state .\qa\qa.state -var-file .\qa\qa.tfvars

> stage

    terraform plan -out .\stage\stage.tfplan -state .\stage\stage.state -var-file .\stage\stage.tfvars

> prod

     terraform plan -out .\prod\prod.tfplan -state .\prod\prod.state -var-file .\prod\prod.tfvars
