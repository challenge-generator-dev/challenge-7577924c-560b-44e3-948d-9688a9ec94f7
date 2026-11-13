# ==============================================================================
# Variables específicas del entorno de desarrollo
# ==============================================================================
# Define los parámetros configurables para la infraestructura del entorno dev
# Estas variables permiten personalizar la infraestructura sin modificar el código
# ==============================================================================

# ------------------------------------------------------------------------------
# Variables de configuración global
# ------------------------------------------------------------------------------

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Nombre del entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "environment_suffix" {
  description = "Sufijo único para recursos que requieren nombres globales únicos"
  type        = string
  default     = "001"
}

# ------------------------------------------------------------------------------
# Variables de la tabla DynamoDB
# ------------------------------------------------------------------------------

variable "table_name" {
  description = "Nombre de la tabla DynamoDB para almacenar órdenes"
  type        = string
  default     = "dev-orders-table"
}

variable "billing_mode" {
  description = "Modo de facturación de la tabla DynamoDB (PROVISIONED o PAY_PER_REQUEST)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "read_capacity" {
  description = "Capacidad de lectura provisionada para la tabla yGSIs"
  type        = number
  default     = 5
}

variable "write_capacity" {
  description = "Capacidad de escritura provisionada para la tabla yGSIs"
  type        = number
  default     = 5
}

variable "hash_key" {
  description = "Nombre del atributo de clave hash (partition key)"
  type        = string
  default     = "orderId"
}

variable "hash_key_type" {
  description = "Tipo de dato de la clave hash (S=String, N=Number, B=Binary)"
  type        = string
  default     = "S"
}

variable "range_key" {
  description = "Nombre del atributo de clave de rango (sort key)"
  type        = string
  default     = "createdAt"
}

variable "range_key_type" {
  description = "Tipo de dato de la clave de rango (S=String, N=Number, B=Binary)"
  type        = string
  default     = "S"
}

variable "attributes" {
  description = "Lista de atributos adicionales para la tabla DynamoDB"
  type = list(object({
    name = string
    type = string
  }))
  default = [
    {
      name = "customerId"
      type = "S"
    },
    {
      name = "status"
      type = "S"
    }
  ]
}

variable "global_secondary_indexes" {
  description = "Lista de índices secundarios globales para consultas eficientes"
  type = list(object({
    name               = string
    hash_key           = string
    range_key          = string
    projection_type    = string
    read_capacity      = number
    write_capacity     = number
    non_key_attributes = list(string)
  }))
  default = []
}

variable "local_secondary_indexes" {
  description = "Lista de índices secundarios locales"
  type = list(object({
    name               = string
    range_key          = string
    projection_type    = string
    non_key_attributes = list(string)
  }))
  default = []
}

variable "ttl_attribute_name" {
  description = "Nombre del atributo para Time To Live"
  type        = string
  default     = "expiresAt"
}

variable "stream_enabled" {
  description = "Habilita el stream de DynamoDB para captura de cambios"
  type        = bool
  default     = true
}

variable "stream_view_type" {
  description = "Tipo de vista del stream (KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES)"
  type        = string
  default     = "NEW_AND_OLD_IMAGES"
}

variable "server_side_encryption_enabled" {
  description = "Habilita el cifrado del lado del servidor"
  type        = bool
  default     = true
}

variable "server_side_encryption_kms_key_arn" {
  description = "ARN de la clave KMS para cifrado (null para usar la managed key de AWS)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Etiquetas para todos los recursos del entorno"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "orders-management"
    ManagedBy   = "terraform"
  }
}