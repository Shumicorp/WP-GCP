<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_health_check.health-check](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check) | resource |
| [google_compute_instance_template.wp-template](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_template) | resource |
| [google_compute_region_autoscaler.autoscaler](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_autoscaler) | resource |
| [google_compute_region_instance_group_manager.mig](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_instance_group_manager) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | n/a | `string` | n/a | yes |
| <a name="input_auto_healing_delay"></a> [auto\_healing\_delay](#input\_auto\_healing\_delay) | n/a | `number` | n/a | yes |
| <a name="input_autoscaler_max"></a> [autoscaler\_max](#input\_autoscaler\_max) | n/a | `number` | n/a | yes |
| <a name="input_autoscaler_min"></a> [autoscaler\_min](#input\_autoscaler\_min) | n/a | `number` | n/a | yes |
| <a name="input_distribution_policy_zones"></a> [distribution\_policy\_zones](#input\_distribution\_policy\_zones) | n/a | `list(any)` | `[]` | no |
| <a name="input_mig_machine_type"></a> [mig\_machine\_type](#input\_mig\_machine\_type) | n/a | `string` | n/a | yes |
| <a name="input_mig_port"></a> [mig\_port](#input\_mig\_port) | n/a | `number` | n/a | yes |
| <a name="input_mig_port_name"></a> [mig\_port\_name](#input\_mig\_port\_name) | n/a | `string` | n/a | yes |
| <a name="input_mig_region"></a> [mig\_region](#input\_mig\_region) | n/a | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_sa"></a> [sa](#input\_sa) | service account for API access | `string` | n/a | yes |
| <a name="input_startup_script"></a> [startup\_script](#input\_startup\_script) | n/a | `any` | n/a | yes |
| <a name="input_sub_net"></a> [sub\_net](#input\_sub\_net) | id private-subnetwork | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | n/a | yes |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | id vpc-network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_health_check"></a> [health\_check](#output\_health\_check) | n/a |
| <a name="output_mig_id"></a> [mig\_id](#output\_mig\_id) | n/a |
<!-- END_TF_DOCS -->