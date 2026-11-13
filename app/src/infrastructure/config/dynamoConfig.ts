import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient } from '@aws-sdk/lib-dynamodb';

// TODO(reto): Configurar el cliente de DynamoDB usando variables de entorno
// 1. Leer las variables de entorno AWS_REGION, AWS_ACCESS_KEY_ID y AWS_SECRET_ACCESS_KEY
// 2. Crear una instancia de DynamoDBClient con la configuración adecuada
// 3. Crear y exportar una instancia de DynamoDBDocumentClient para operaciones simplificadas
// 4. Manejar errores de configuración (variables de entorno faltantes)

export const dynamoDBClient: DynamoDBClient = new DynamoDBClient({});
export const dynamoDBDocumentClient: DynamoDBDocumentClient = DynamoDBDocumentClient.from(dynamoDBClient);