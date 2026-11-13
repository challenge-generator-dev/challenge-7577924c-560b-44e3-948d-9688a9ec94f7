# Variables de configuración para el entorno de desarrollo
# Estas variables personalizan la tabla DynamoDB y los recursos asociados

# Configuración de la tabla DynamoDB para almacenar órdenes
table_name               = "dev-orders-table"
billing_mode             = "PAY_PER_REQUEST"
hash_key                 = "orderId"
hash_key_type            = "S"
range_key                = "createdAt"
range_key_type           = "S"

# Atributos adicionales necesarios para la tabla de órdenes
attributes = [
  {
    name = "customerId"
    type = "S"
  },
  {
    name = "status"
    type = "S"
  }
]

# Índices secundarios globales para consultas eficientes
global_secondary_indexes = [
  {
    name               = "customerId-index"
    hash_key           = "customerId"
    range_key          = "createdAt"
    projection_type    = "ALL"
    read_capacity      = 5
    write_capacity     = 5
    non_key_attributes = ["orderId", "status", "totalAmount"]
  },
  {
    name               = "status-index"
    hash_key           = "status"
    range_key          = "createdAt"
    projection_type    = "ALL"
    read_capacity      = 5
    write_capacity     = 5
    non_key_attributes = ["orderId", "customerId", "totalAmount"]
  }
]

# Configuración de TTL para limpieza automática de órdenes antiguas
ttl_attribute_name = "expiresAt"

# Configuración de streams para captura de cambios
stream_enabled    = true
stream_view_type  = "NEW_AND_OLD_IMAGES"

# Cifrado del lado del servidor
server_side_encryption_enabled = true
# La clave KMS se configurará automáticamente si no se especifica

# Etiquetas para organización y gestión de recursos
tags = {
  Environment = "dev"
  Project     = "orders-management"
  ManagedBy   = "terraform"
  CostCenter  = "engineering"
  Owner       = "platform-team"
  Purpose     = "e-commerce-orders"
}

# Configuración de capacidad para índices (solo si se usa PROVISIONED)
read_capacity  = 10
write_capacity = 10