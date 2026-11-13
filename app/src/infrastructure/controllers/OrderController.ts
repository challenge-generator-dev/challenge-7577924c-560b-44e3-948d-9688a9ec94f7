import { Request, Response } from 'express';
import { OrderService } from '../../application/services/OrderService';
import { CreateOrderRequest, UpdateOrderRequest, OrderStatus } from '../../domain/models/Order';
import { plainToClass } from 'class-transformer';
import { validate } from 'class-validator';

export { CreateOrderRequest, UpdateOrderRequest };

export class OrderController {
    constructor(private orderService: OrderService) {}

    async createOrder(req: Request, res: Response): Promise<void> {
        try {
            const orderData = plainToClass(CreateOrderRequest, req.body as CreateOrderRequest);
            const errors = await validate(orderData);
            if (errors.length > 0) {
                res.status(400).json({ errors });
                return;
            }

            const order = await this.orderService.createOrder(orderData);
            res.status(201).json(order);
        } catch (error) {
            res.status(500).json({ 
                message: 'Error creating order', 
                error: error instanceof Error ? error.message : String(error) 
            });
        }
    }

    async getOrder(req: Request, res: Response): Promise<void> {
        try {
            const { id } = req.params;
            const order = await this.orderService.getOrder(id);
            if (!order) {
                res.status(404).json({ message: 'Order not found' });
                return;
            }
            res.status(200).json(order);
        } catch (error) {
            res.status(500).json({ 
                message: 'Error retrieving order', 
                error: error instanceof Error ? error.message : String(error) 
            });
        }
    }

    async updateOrder(req: Request, res: Response): Promise<void> {
        try {
            const { id } = req.params;
            const orderData = plainToClass(UpdateOrderRequest, req.body as UpdateOrderRequest);
            const errors = await validate(orderData);
            if (errors.length > 0) {
                res.status(400).json({ errors });
                return;
            }

            const order = await this.orderService.updateOrder(id, orderData);
            if (!order) {
                res.status(404).json({ message: 'Order not found' });
                return;
            }
            res.status(200).json(order);
        } catch (error) {
            res.status(500).json({ 
                message: 'Error updating order', 
                error: error instanceof Error ? error.message : String(error) 
            });
        }
    }

    async deleteOrder(req: Request, res: Response): Promise<void> {
        try {
            const { id } = req.params;
            await this.orderService.deleteOrder(id);
            res.status(204).send();
        } catch (error) {
            res.status(500).json({ 
                message: 'Error deleting order', 
                error: error instanceof Error ? error.message : String(error) 
            });
        }
    }
}