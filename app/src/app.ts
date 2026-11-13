import express, { Application, Request, Response, NextFunction } from 'express';
import { OrderController } from './infrastructure/controllers/OrderController';
import { validate } from 'class-validator';
import { plainToInstance } from 'class-transformer';
import { CreateOrderRequest, UpdateOrderRequest } from './domain/models/Order';

export const app: Application = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use((req: Request, res: Response, next: NextFunction) => {
    const start = Date.now();
    res.on('finish', () => {
        const duration = Date.now() - start;
        console.log(`${req.method} ${req.path} ${res.statusCode} - ${duration}ms`);
    });
    next();
});

app.post('/orders', async (req: Request, res: Response) => {
    try {
        const controller = req.app.get('orderController') as OrderController;
        await controller.createOrder(req, res);
    } catch (error) {
        console.error('Error en createOrder:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
});

app.get('/orders/:id', async (req: Request, res: Response) => {
    try {
        const controller = req.app.get('orderController') as OrderController;
        await controller.getOrder(req, res);
    } catch (error) {
        console.error('Error en getOrder:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
});

app.put('/orders/:id', async (req: Request, res: Response) => {
    try {
        const controller = req.app.get('orderController') as OrderController;
        await controller.updateOrder(req, res);
    } catch (error) {
        console.error('Error en updateOrder:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
});

app.delete('/orders/:id', async (req: Request, res: Response) => {
    try {
        const controller = req.app.get('orderController') as OrderController;
        await controller.deleteOrder(req, res);
    } catch (error) {
        console.error('Error en deleteOrder:', error);
        res.status(500).json({ error: 'Error interno del servidor' });
    }
});

app.get('/health', (req: Request, res: Response) => {
    res.status(200).json({ status: 'OK', timestamp: new Date().toISOString() });
});

app.use((req: Request, res: Response) => {
    res.status(404).json({ error: 'Ruta no encontrada' });
});

app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
    console.error('Error no manejado:', err);
    res.status(500).json({ error: 'Error interno del servidor' });
});

export function validateRequest<T>(dtoClass: new (...args: any[]) => T, body: any): Promise<T> {
    return new Promise((resolve, reject) => {
        const dto = plainToInstance(dtoClass, body as object);
        validate(dto).then((errors) => {
            if (errors.length > 0) {
                const messages = errors.map((err) => Object.values(err.constraints || {}).join(', '));
                reject(new Error(`Validación fallida: ${messages.join('; ')}`));
            } else {
                resolve(dto);
            }
        });
    });
}