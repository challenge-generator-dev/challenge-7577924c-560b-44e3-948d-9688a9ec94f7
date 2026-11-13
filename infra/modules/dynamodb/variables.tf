# Variables de entrada para el módulo DynamoDB
# Define los parámetros necesarios para crear y configurar una tabla DynamoDB

variable "table_name" {
  description = "Nombre de la tabla DynamoDB"
  type        = string
}

variable "billing_mode" {
  description = "Modo de facturación de la tabla DynamoDB (PROVISIONED o PAY_PER_REQUEST)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "read_capacity" {
  description = "Capacidad de lectura provisionada (solo aplicable si billing_mode es PROVISIONED)"
  type        = number
  default     = null
}

variable "write_capacity" {
  description = "Capacidad de escritura provisionada (solo aplicable si billing_mode es PROVISIONED)"
  type        = number
  default     = null
}

variable "hash_key" {
  description = "Nombre del atributo que será la clave hash (partition key)"
  type        = string
}

variable "hash_key_type" {
  description = "Tipo de dato de la clave hash (S para String, N para Number, B para Binary)"
  type        = string
  default     = "S"
}

variable "range_key" {
  description = "Nombre del atributo que será la clave de rango (sort key)"
  type        = string
  default     = null
}

variable "range_key_type" {
  description = "Tipo de dato de la clave de rango (S para String, N para Number, B para Binary)"
  type        = string
  default     = "S"
}

variable "attributes" {
  description = "Lista de atributos adicionales para la tabla DynamoDB"
  type = list(object({
    name = string
    type = string
  }))
  default = []
}

variable "global_secondary_indexes" {
  description = "Lista de índices secundarios globales para la tabla DynamoDB"
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
  description = "Lista de índices secundarios locales para la tabla DynamoDB"
  type = list(object({
    name               = string
    range_key          = string
    projection_type    = string
    non_key_attributes = list(string)
  }))
  default = []
}

variable "ttl_attribute_name" {
  description = "Nombre del atributo que se usará para TTL (Time To Live)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags para la tabla DynamoDB"
  type        = map(string)
  default     = {}
}

variable "stream_enabled" {
  description = "Habilita el stream de la tabla DynamoDB"
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "Tipo de vista del stream (KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES)"
  type        = string
  default     = null
}

variable "server_side_encryption_enabled" {
  description = "Habilita el cifrado del lado del servidor"
  type        = bool
  default     = true
}

variable "server_side_encryption_kms_key_arn" {
  description = "ARN de la clave KMS para el cifrado del lado del servidor"
  type        = string
  default     = null
}