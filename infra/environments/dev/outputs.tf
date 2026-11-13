# ==============================================================================
# Salidas del entorno de desarrollo
# ==============================================================================
# Este archivo define los outputs del módulo de entorno de desarrollo.
# Expone los valores de los recursos creados para que puedan ser consumidos
# por otros módulos o por la aplicación que utiliza esta infraestructura.
#
# Los outputs permiten:
# - Referenciar recursos creados desde otros proyectos Terraform
# - Obtener información de conexión para la aplicación
# - Validar que la infraestructura se desplegó correctamente
# ==============================================================================

# ------------------------------------------------------------------------------
# Salidas de la tabla DynamoDB
# ------------------------------------------------------------------------------

output "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB de órdenes creada en el entorno de desarrollo"
  value       = module.dynamodb_orders.table_name
  sensitive   = false
}

output "dynamodb_table_arn" {
  description = "ARN completo de la tabla DynamoDB de órdenes"
  value       = module.dynamodb_orders.table_arn
  sensitive   = false
}

output "dynamodb_table_id" {
  description = "ID interno de la tabla DynamoDB"
  value       = module.dynamodb_orders.table_id
  sensitive   = false
}

output "dynamodb_hash_key" {
  description = "Nombre del atributo de clave hash (partition key) de la tabla de órdenes"
  value       = module.dynamodb_orders.hash_key
  sensitive   = false
}

output "dynamodb_range_key" {
  description = "Nombre del atributo de clave de rango (sort key) de la tabla de órdenes"
  value       = module.dynamodb_orders.range_key
  sensitive   = false
}

# ------------------------------------------------------------------------------
# Salidas de configuración regional
# ------------------------------------------------------------------------------

output "aws_region" {
  description = "Región de AWS donde se desplegó la infraestructura del entorno de desarrollo"
  value       = var.aws_region
  sensitive   = false
}

output "environment_name" {
  description = "Nombre del entorno de despliegue"
  value       = var.environment
  sensitive   = false
}

# ------------------------------------------------------------------------------
# Salidas para conexión de la aplicación
# ------------------------------------------------------------------------------

output "connection_info" {
  description = "Información de conexión para la aplicación"
  value = {
    region          = var.aws_region
    table_name      = module.dynamodb_orders.table_name
    table_arn       = module.dynamodb_orders.table_arn
    endpoint_url    = "dynamodb.${var.aws_region}.amazonaws.com"
    environment     = var.environment
  }
  sensitive = false
}

# ------------------------------------------------------------------------------
# Salidas de resumen de recursos
# ------------------------------------------------------------------------------

output "resources_summary" {
  description = "Resumen de los recursos creados en el entorno de desarrollo"
  value = {
    dynamodb_table_created = true
    table_name             = module.dynamodb_orders.table_name
    environment            = var.environment
    region                 = var.aws_region
  }
  sensitive = false
}

# ------------------------------------------------------------------------------
# Salidas para validación
# ------------------------------------------------------------------------------

output "validation_outputs" {
  description = "Outputs utilizados para validar el despliegue correcto de la infraestructura"
  value = {
    table_exists    = module.dynamodb_orders.table_name != ""
    table_arn_valid = can(regex("^arn:aws:dynamodb:", module.dynamodb_orders.table_arn))
    region_matches  = can(regex(var.aws_region, module.dynamodb_orders.table_arn))
  }
  sensitive = false
}