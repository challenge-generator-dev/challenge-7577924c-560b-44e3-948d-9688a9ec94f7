# ==============================================================================
# Módulo Terraform para la creación y configuración de tablas DynamoDB
# ==============================================================================
# Proporciona una interfaz reutilizable para definir tablas DynamoDB con
# claves primarias, índices secundarios y configuraciones de rendimiento.
# Este módulo crea una tabla DynamoDB con todas las configuraciones necesarias
# incluyendo cifrado, streams, TTL y capacidades de throughput.
# ==============================================================================

resource "aws_dynamodb_table" "this" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  hash_key       = var.hash_key
  range_key      = var.range_key
  read_capacity  = var.billing_mode == "PROVISIONED" ? var.read_capacity : null
  write_capacity = var.billing_mode == "PROVISIONED" ? var.write_capacity : null
  stream_enabled = var.stream_enabled
  stream_view_type = var.stream_enabled ? var.stream_view_type : null

  dynamic "attribute" {
    for_each = concat(
      [{ name = var.hash_key, type = var.hash_key_type }],
      var.range_key != null ? [{ name = var.range_key, type = var.range_key_type }] : [],
      var.attributes
    )
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes
    content {
      name               = global_secondary_index.value.name
      hash_key           = global_secondary_index.value.hash_key
      range_key          = global_secondary_index.value.range_key
      projection_type    = global_secondary_index.value.projection_type
      read_capacity      = global_secondary_index.value.read_capacity
      write_capacity     = global_secondary_index.value.write_capacity
      non_key_attributes = global_secondary_index.value.non_key_attributes
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_indexes
    content {
      name               = local_secondary_index.value.name
      range_key          = local_secondary_index.value.range_key
      projection_type    = local_secondary_index.value.projection_type
      non_key_attributes = local_secondary_index.value.non_key_attributes
    }
  }

  dynamic "ttl" {
    for_each = var.ttl_attribute_name != null ? [var.ttl_attribute_name] : []
    content {
      attribute_name = ttl.value
      enabled        = true
    }
  }

  dynamic "server_side_encryption" {
    for_each = var.server_side_encryption_enabled ? [1] : []
    content {
      enabled     = true
      kms_key_arn = var.server_side_encryption_kms_key_arn
    }
  }

  tags = var.tags

  point_in_time_recovery {
    enabled = true
  }
}