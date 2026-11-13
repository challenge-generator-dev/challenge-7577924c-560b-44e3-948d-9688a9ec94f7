import { Order, CreateOrderRequest, UpdateOrderRequest, OrderStatus } from '../../domain/models/Order';
import { OrderRepository } from '../../domain/repositories/OrderRepository';

export class OrderService {
    constructor(private readonly orderRepository: OrderRepository) {}

    async createOrder(createOrderRequest: CreateOrderRequest): Promise<Order> {
        // TODO(reto): Implementar la lógica para crear una orden
        // 1. Validar los items de la orden (quantity > 0, price >= 0)
        // 2. Crear un objeto Order con estado PENDING y fecha actual
        // 3. Persistir la orden usando orderRepository.createOrder(orderData)
        // 4. Retornar la orden creada
        throw new Error('Method not implemented');
    }

    async getOrder(id: string): Promise<Order | null> {
        // TODO(reto): Implementar la lógica para obtener una orden por ID
        // 1. Validar que el ID no sea vacío
        // 2. Buscar la orden usando orderRepository.getOrder(id)
        // 3. Retornar la orden encontrada o null si no existe
        throw new Error('Method not implemented');
    }

    async updateOrder(id: string, updateOrderRequest: UpdateOrderRequest): Promise<Order | null> {
        // TODO(reto): Implementar la lógica para actualizar una orden
        // 1. Validar que el ID no sea vacío y que el nuevo estado sea válido
        // 2. Buscar la orden existente usando orderRepository.getOrder(id)
        // 3. Si no existe, retornar null
        // 4. Actualizar el estado de la orden
        // 5. Persistir los cambios usando orderRepository.updateOrder(id, updateOrderRequest)
        // 6. Retornar la orden actualizada
        throw new Error('Method not implemented');
    }

    async deleteOrder(id: string): Promise<boolean> {
        // TODO(reto): Implementar la lógica para eliminar una orden
        // 1. Validar que el ID no sea vacío
        // 2. Eliminar la orden usando orderRepository.delete(id)
        // 3. Retornar true si se eliminó, false si no existía
        throw new Error('Method not implemented');
    }
}