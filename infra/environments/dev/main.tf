# Configuración principal del entorno de desarrollo
# Este archivo define los recursos de infraestructura para el entorno de desarrollo

# Módulo DynamoDB para almacenar las órdenes del sistema de e-commerce
# Se utiliza el módulo reutilizable definido en modules/dynamodb
module "dynamodb_orders" {
  source = "../../modules/dynamodb"

  # Nombre de la tabla - único en la cuenta y región
  table_name = var.table_name

  # Modo de facturación - PAY_PER_REQUEST para desarrollo (sin costos mínimos)
  billing_mode = var.billing_mode

  # Clave primaria de la tabla
  hash_key      = var.hash_key
  hash_key_type = var.hash_key_type
  range_key     = var.range_key
  range_key_type = var.range_key_type

  # Capacidad provisionada (solo aplica si billing_mode es PROVISIONED)
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity

  # Atributos adicionales para la tabla
  attributes = var.attributes

  # Índices secundarios globales para consultas por cliente y estado
  global_secondary_indexes = var.global_secondary_indexes

  # Índices secundarios locales (opcional)
  local_secondary_indexes = var.local_secondary_indexes

  # Configuración de TTL para expiración automática de registros
  ttl_attribute_name = var.ttl_attribute_name

  # Habilitar streams para captura de cambios en la tabla
  stream_enabled    = var.stream_enabled
  stream_view_type  = var.stream_view_type

  # Configuración de cifrado
  server_side_encryption_enabled         = var.server_side_encryption_enabled
  server_side_encryption_kms_key_arn     = var.server_side_encryption_kms_key_arn

  # Tags para identificación y gestión de costos
  tags = var.tags
}

# Recurso adicional: Bucket S3 para logs del entorno de desarrollo
resource "aws_s3_bucket" "logs" {
  bucket = "dev-orders-logs-${var.environment_suffix}"

  tags = merge(var.tags, {
    Purpose = "application-logs"
  })
}

# Configuración del bucket S3 para logs
resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Recurso adicional: Topic SNS para notificaciones de órdenes
resource "aws_sns_topic" "orders_notifications" {
  name = "dev-orders-notifications"

  tags = merge(var.tags, {
    Purpose = "order-events"
  })
}

# Política de acceso al topic SNS
resource "aws_sns_topic_policy" "orders_notifications" {
  arn = aws_sns_topic.orders_notifications.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "dynamodb.amazonaws.com"
        }
        Action = [
          "sns:Publish"
        ]
        Resource = aws_sns_topic.orders_notifications.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = module.dynamodb_orders.table_arn
          }
        }
      }
    ]
  })
}

# Recurso adicional: Cola SQS para procesamiento asíncrono de órdenes
resource "aws_sqs_queue" "orders_processing" {
  name                       = "dev-orders-processing-queue"
  message_retention_seconds  = 345600  # 4 días
  max_message_size           = 262144  # 256 KB
  delay_seconds              = 0
  receive_wait_time_seconds  = 20

  tags = merge(var.tags, {
    Purpose = "order-processing"
  })
}

# Configuración de dead letter queue para mensajes fallidos
resource "aws_sqs_queue" "orders_processing_dlq" {
  name = "dev-orders-processing-queue-dlq"

  tags = merge(var.tags, {
    Purpose = "order-processing-dlq"
  })
}

# Redirección de mensajes fallidos a la cola dead letter
resource "aws_sqs_queue_redrive_policy" "orders_processing" {
  queue_url       = aws_sqs_queue.orders_processing.id
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.orders_processing_dlq.arn
    maxReceiveCount     = 5
  })
}

# Outputs del entorno de desarrollo

output "dynamodb_table_stream_arn" {
  description = "ARN del stream de la tabla DynamoDB"
  value       = module.dynamodb_orders.stream_arn
}

output "logs_bucket_name" {
  description = "Nombre del bucket S3 para logs"
  value       = aws_s3_bucket.logs.id
}

output "orders_notifications_topic_arn" {
  description = "ARN del topic SNS para notificaciones de órdenes"
  value       = aws_sns_topic.orders_notifications.arn
}

output "orders_processing_queue_url" {
  description = "URL de la cola SQS para procesamiento de órdenes"
  value       = aws_sqs_queue.orders_processing.url
}

output "orders_processing_dlq_url" {
  description = "URL de la cola SQS dead letter"
  value       = aws_sqs_queue.orders_processing_dlq.url
}