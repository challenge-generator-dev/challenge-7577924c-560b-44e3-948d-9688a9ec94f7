# Salidas del módulo DynamoDB
# Expone atributos importantes de la tabla DynamoDB creada

output "table_arn" {
  description = "ARN de la tabla DynamoDB"
  value       = aws_dynamodb_table.this.arn
}

output "table_name" {
  description = "Nombre de la tabla DynamoDB"
  value       = aws_dynamodb_table.this.name
}

output "table_id" {
  description = "ID de la tabla DynamoDB"
  value       = aws_dynamodb_table.this.id
}

output "stream_arn" {
  description = "ARN del stream de la tabla DynamoDB (si está habilitado)"
  value       = aws_dynamodb_table.this.stream_arn
}

output "stream_label" {
  description = "Etiqueta del stream de la tabla DynamoDB (si está habilitado)"
  value       = aws_dynamodb_table.this.stream_label
}

output "hash_key" {
  description = "Nombre de la clave hash (partition key) de la tabla"
  value       = var.hash_key
}

output "range_key" {
  description = "Nombre de la clave de rango (sort key) de la tabla (si existe)"
  value       = var.range_key
}