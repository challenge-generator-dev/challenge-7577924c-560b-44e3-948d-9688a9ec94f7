import { Order, CreateOrderRequest, UpdateOrderRequest } from '../models/Order';

export interface OrderRepository {
    createOrder(orderData: CreateOrderRequest): Promise<Order>;
    getOrder(id: string): Promise<Order | null>;
    updateOrder(id: string, orderData: UpdateOrderRequest): Promise<Order | null>;
    deleteOrder(id: string): Promise<void>;
}