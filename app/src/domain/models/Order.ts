import { IsEnum, IsNumber, IsString, IsUUID, ValidateNested } from 'class-validator';
import { Type } from 'class-transformer';

export enum OrderStatus {
    PENDING = 'PENDING',
    PAID = 'PAID',
    SHIPPED = 'SHIPPED',
    DELIVERED = 'DELIVERED',
    CANCELLED = 'CANCELLED'
}

export class OrderItem {
    @IsString()
    @IsUUID()
    productId: string;

    @IsNumber()
    quantity: number;

    @IsNumber()
    price: number;

    constructor(productId: string, quantity: number, price: number) {
        this.productId = productId;
        this.quantity = quantity;
        this.price = price;
    }
}

export class Order {
    @IsString()
    @IsUUID()
    id: string;

    @IsEnum(OrderStatus)
    status: OrderStatus;

    @IsNumber()
    totalPrice: number;

    @IsString()
    createdAt: string;

    @ValidateNested({ each: true })
    @Type(() => OrderItem)
    items: OrderItem[];

    constructor(id: string, status: OrderStatus, totalPrice: number, createdAt: string, items: OrderItem[]) {
        this.id = id;
        this.status = status;
        this.totalPrice = totalPrice;
        this.createdAt = createdAt;
        this.items = items;
    }
}

export class CreateOrderRequest {
    @ValidateNested({ each: true })
    @Type(() => OrderItem)
    items: OrderItem[];

    @IsNumber()
    totalPrice: number;

    constructor(items: OrderItem[], totalPrice: number) {
        this.items = items;
        this.totalPrice = totalPrice;
    }
}

export class UpdateOrderRequest {
    @IsEnum(OrderStatus)
    status: OrderStatus;

    constructor(status: OrderStatus) {
        this.status = status;
    }
}