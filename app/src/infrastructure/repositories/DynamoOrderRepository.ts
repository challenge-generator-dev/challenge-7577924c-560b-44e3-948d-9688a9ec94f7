// TODO(reto): archivo stubbeado; implementa los cuerpos.
import { OrderRepository } from '../../domain/repositories/OrderRepository';
import { Order, CreateOrderRequest, UpdateOrderRequest, OrderStatus, OrderItem } from '../../domain/models/Order';
import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient, PutCommand, GetCommand, UpdateCommand, DeleteCommand } from '@aws-sdk/lib-dynamodb';
import { v4 as uuidv4 } from 'uuid';

export class DynamoOrderRepository implements OrderRepository {
    private readonly tableName: string;
    private readonly client: DynamoDBDocumentClient;

    constructor(client: DynamoDBClient, tableName: string) {
        this.client = DynamoDBDocumentClient.from(client);
        this.tableName = tableName;
    }

    async createOrder(orderData: CreateOrderRequest): Promise<Order> {
      throw new Error('TODO(reto): createOrder');
    }

    async getOrder(id: string): Promise<Order | null> {
      throw new Error('TODO(reto): getOrder');
    }

    async updateOrder(id: string, orderData: UpdateOrderRequest): Promise<Order | null> {
      throw new Error('TODO(reto): updateOrder');
    }

    async deleteOrder(id: string): Promise<void> {
      throw new Error('TODO(reto): deleteOrder');
    }
}