import 'reflect-metadata';
import { app } from './app';
import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient } from '@aws-sdk/lib-dynamodb';
import { DynamoOrderRepository } from './infrastructure/repositories/DynamoOrderRepository';
import { OrderService } from './application/services/OrderService';
import { OrderController } from './infrastructure/controllers/OrderController';

const PORT = process.env.PORT ? parseInt(process.env.PORT, 10) : 3000;
const DYNAMO_TABLE = process.env.DYNAMO_TABLE || 'orders';
const DYNAMO_REGION = process.env.AWS_REGION || 'us-east-1';

const awsConfig: DynamoDBClientConfig = {
    region: DYNAMO_REGION,
    ...(process.env.AWS_ENDPOINT && { endpoint: process.env.AWS_ENDPOINT }),
    ...(process.env.AWS_ACCESS_KEY_ID && {
        credentials: {
            accessKeyId: process.env.AWS_ACCESS_KEY_ID,
            secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY || '',
        },
    }),
};

const dynamoClient = new DynamoDBClient(awsConfig);
const docClient = DynamoDBDocumentClient.from(dynamoClient, {
    marshallOptions: {
        removeUndefinedValues: true,
    },
});

const orderRepository = new DynamoOrderRepository(docClient, DYNAMO_TABLE);
const orderService = new OrderService(orderRepository);
const orderController = new OrderController(orderService);

app.set('orderController', orderController);

app.listen(PORT, () => {
    console.log(`Servidor iniciado en el puerto ${PORT}`);
    console.log(`Entorno: ${process.env.NODE_ENV || 'development'}`);
    console.log(`Tabla DynamoDB: ${DYNAMO_TABLE}`);
    console.log(`Región AWS: ${DYNAMO_REGION}`);
});

interface DynamoDBClientConfig {
    region: string;
    endpoint?: string;
    credentials?: {
        accessKeyId: string;
        secretAccessKey: string;
    };
}