# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `app/src/application/services/OrderService.ts` — La logica del reto vive aqui: la seleccion por fase solo encontraba pegamento.
- `app/src/infrastructure/repositories/DynamoOrderRepository.ts` — La practica caia en codigo que el entry no alcanza: este archivo alcanzable pasa a ser el ejercicio.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `app` | `app/` | practice, chapter | server | Node | Express, DynamoDB |
| `infra` | `infra/` | support | infra | Terraform (AWS) | Terraform |
| `infra-local` | (raiz) | support | infra | Compose local | DynamoDB |

## Orden de arranque

1. `docker compose up -d` (en la raiz) — levanta la infraestructura local.
2. `cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/dynamodb init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/dynamodb validate` — componente `infra` (support).
3. `cd app && npm install --no-audit --no-fund && npm run build` — componente `app` (practice, chapter).

### Contratos entre componentes

- `app` expone http (api: http://localhost:3000):
  - `POST /orders`
  - `GET /orders/:id`
  - `PUT /orders/:id`
  - `DELETE /orders/:id`

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `app/src/application/services/OrderService.ts` — `OrderRepository.delete`: Se invoca `delete` sobre `OrderRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

## Como saber que terminaste

```bash
(cd app && npm install --no-audit --no-fund && npm run build) && (cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/dynamodb init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/dynamodb validate) && docker compose config -q
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Backend, Especialidad Desarrollador, Tecnología Node, Advanced L2

### Brecha de conocimiento
CRUD de ordenes en DynamoDB expuesto por una API REST, Implementa operaciones CRUD de ordenes sobre una tabla DynamoDB expuestas por una API REST

### Misión / candidato
Persistir y consultar ordenes

### Reto
- Tema: CRUD de ordenes sobre DynamoDB
- Seniority: advanced-l2
- Tipo: practical
- Título: Implementación de operaciones CRUD de órdenes en DynamoDB
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración inicial y creación de la tabla DynamoDB — objetivo: Configurar el entorno de desarrollo y crear la tabla DynamoDB para almacenar las órdenes. — entregable (NO resolver): Tabla DynamoDB creada y configurada con las columnas necesarias.
- Fase 2: Implementación de las operaciones CRUD en la API REST — objetivo: Implementar las operaciones CRUD (Crear, Leer, Actualizar, Eliminar) en la API REST. — entregable (NO resolver): API REST con las operaciones CRUD implementadas y funcionales.
- Fase 3: Pruebas y optimización de las operaciones CRUD — objetivo: Realizar pruebas y optimizar las operaciones CRUD implementadas. — entregable (NO resolver): Operaciones CRUD optimizadas y funcionales, con pruebas realizadas.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: app/package.json ===
{
  "name": "reto-express",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "build": "tsc -p tsconfig.json",
    "test": "jest"
  },
  "dependencies": {
    "@aws-sdk/client-dynamodb": "3.1169.0",
    "@aws-sdk/lib-dynamodb": "3.1169.0",
    "@types/jest": "30.0.0",
    "@types/supertest": "7.2.1",
    "@types/uuid": "11.0.0",
    "class-transformer": "0.5.1",
    "class-validator": "0.15.1",
    "express": "4.22.3",
    "jest": "30.5.2",
    "reflect-metadata": "0.2.2",
    "ts-jest": "29.4.15",
    "uuid": "14.0.3"
  },
  "devDependencies": {
    "@types/express": "4.17.25",
    "@types/node": "22.20.5",
    "typescript": "5.7.3"
  },
  "jest": {
    "preset": "ts-jest",
    "testEnvironment": "node"
  }
}

// === ARCHIVO: app/tsconfig.json ===
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "commonjs",
    "moduleResolution": "node",
    "outDir": "dist",
    "strict": true,
    "strictPropertyInitialization": false,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "resolveJsonModule": true,
    "forceConsistentCasingInFileNames": true,
    "experimentalDecorators": true,
    "emitDecoratorMetadata": true,
    "types": [
      "node"
    ]
  },
  "include": [
    "src"
  ],
  "exclude": [
    "node_modules",
    "dist",
    "_pendiente",
    "tests",
    "test",
    "src/**/*.test.ts",
    "src/**/*.spec.ts"
  ]
}

// === ARCHIVO: app/src/domain/models/Order.ts ===
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

// === ARCHIVO: app/src/domain/repositories/OrderRepository.ts ===
import { Order, CreateOrderRequest, UpdateOrderRequest } from '../models/Order';

export interface OrderRepository {
    createOrder(orderData: CreateOrderRequest): Promise<Order>;
    getOrder(id: string): Promise<Order | null>;
    updateOrder(id: string, orderData: UpdateOrderRequest): Promise<Order | null>;
    deleteOrder(id: string): Promise<void>;
}

// === ARCHIVO: app/src/infrastructure/controllers/OrderController.ts ===
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

// === ARCHIVO: app/src/infrastructure/repositories/DynamoOrderRepository.ts ===
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

// === ARCHIVO: app/src/application/services/OrderService.ts ===
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

// === ARCHIVO: app/src/infrastructure/config/dynamoConfig.ts ===
import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient } from '@aws-sdk/lib-dynamodb';

// TODO(reto): Configurar el cliente de DynamoDB usando variables de entorno
// 1. Leer las variables de entorno AWS_REGION, AWS_ACCESS_KEY_ID y AWS_SECRET_ACCESS_KEY
// 2. Crear una instancia de DynamoDBClient con la configuración adecuada
// 3. Crear y exportar una instancia de DynamoDBDocumentClient para operaciones simplificadas
// 4. Manejar errores de configuración (variables de entorno faltantes)

export const dynamoDBClient: DynamoDBClient = new DynamoDBClient({});
export const dynamoDBDocumentClient: DynamoDBDocumentClient = DynamoDBDocumentClient.from(dynamoDBClient);

// === ARCHIVO: app/src/main.ts ===
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

// === ARCHIVO: app/src/app.ts ===
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

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.100.0"
    }
  }
}

// === ARCHIVO: infra/providers.tf ===
provider "aws" {
  region = "us-east-1"
}

// === ARCHIVO: infra/modules/dynamodb/variables.tf ===
# Variables de entrada para el módulo DynamoDB
# Define los parámetros necesarios para crear y configurar una tabla DynamoDB

variable "table_name" {
  description = "Nombre de la tabla DynamoDB"
  type        = string
}

variable "billing_mode" {
  description = "Modo de facturación de la tabla DynamoDB (PROVISIONED o PAY_PER_REQUEST)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "read_capacity" {
  description = "Capacidad de lectura provisionada (solo aplicable si billing_mode es PROVISIONED)"
  type        = number
  default     = null
}

variable "write_capacity" {
  description = "Capacidad de escritura provisionada (solo aplicable si billing_mode es PROVISIONED)"
  type        = number
  default     = null
}

variable "hash_key" {
  description = "Nombre del atributo que será la clave hash (partition key)"
  type        = string
}

variable "hash_key_type" {
  description = "Tipo de dato de la clave hash (S para String, N para Number, B para Binary)"
  type        = string
  default     = "S"
}

variable "range_key" {
  description = "Nombre del atributo que será la clave de rango (sort key)"
  type        = string
  default     = null
}

variable "range_key_type" {
  description = "Tipo de dato de la clave de rango (S para String, N para Number, B para Binary)"
  type        = string
  default     = "S"
}

variable "attributes" {
  description = "Lista de atributos adicionales para la tabla DynamoDB"
  type = list(object({
    name = string
    type = string
  }))
  default = []
}

variable "global_secondary_indexes" {
  description = "Lista de índices secundarios globales para la tabla DynamoDB"
  type = list(object({
    name               = string
    hash_key           = string
    range_key          = string
    projection_type    = string
    read_capacity      = number
    write_capacity     = number
    non_key_attributes = list(string)
  }))
  default = []
}

variable "local_secondary_indexes" {
  description = "Lista de índices secundarios locales para la tabla DynamoDB"
  type = list(object({
    name               = string
    range_key          = string
    projection_type    = string
    non_key_attributes = list(string)
  }))
  default = []
}

variable "ttl_attribute_name" {
  description = "Nombre del atributo que se usará para TTL (Time To Live)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags para la tabla DynamoDB"
  type        = map(string)
  default     = {}
}

variable "stream_enabled" {
  description = "Habilita el stream de la tabla DynamoDB"
  type        = bool
  default     = false
}

variable "stream_view_type" {
  description = "Tipo de vista del stream (KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES)"
  type        = string
  default     = null
}

variable "server_side_encryption_enabled" {
  description = "Habilita el cifrado del lado del servidor"
  type        = bool
  default     = true
}

variable "server_side_encryption_kms_key_arn" {
  description = "ARN de la clave KMS para el cifrado del lado del servidor"
  type        = string
  default     = null
}

// === ARCHIVO: infra/modules/dynamodb/outputs.tf ===
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

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
# Variables de configuración para el entorno de desarrollo
# Estas variables personalizan la tabla DynamoDB y los recursos asociados

# Configuración de la tabla DynamoDB para almacenar órdenes
table_name               = "dev-orders-table"
billing_mode             = "PAY_PER_REQUEST"
hash_key                 = "orderId"
hash_key_type            = "S"
range_key                = "createdAt"
range_key_type           = "S"

# Atributos adicionales necesarios para la tabla de órdenes
attributes = [
  {
    name = "customerId"
    type = "S"
  },
  {
    name = "status"
    type = "S"
  }
]

# Índices secundarios globales para consultas eficientes
global_secondary_indexes = [
  {
    name               = "customerId-index"
    hash_key           = "customerId"
    range_key          = "createdAt"
    projection_type    = "ALL"
    read_capacity      = 5
    write_capacity     = 5
    non_key_attributes = ["orderId", "status", "totalAmount"]
  },
  {
    name               = "status-index"
    hash_key           = "status"
    range_key          = "createdAt"
    projection_type    = "ALL"
    read_capacity      = 5
    write_capacity     = 5
    non_key_attributes = ["orderId", "customerId", "totalAmount"]
  }
]

# Configuración de TTL para limpieza automática de órdenes antiguas
ttl_attribute_name = "expiresAt"

# Configuración de streams para captura de cambios
stream_enabled    = true
stream_view_type  = "NEW_AND_OLD_IMAGES"

# Cifrado del lado del servidor
server_side_encryption_enabled = true
# La clave KMS se configurará automáticamente si no se especifica

# Etiquetas para organización y gestión de recursos
tags = {
  Environment = "dev"
  Project     = "orders-management"
  ManagedBy   = "terraform"
  CostCenter  = "engineering"
  Owner       = "platform-team"
  Purpose     = "e-commerce-orders"
}

# Configuración de capacidad para índices (solo si se usa PROVISIONED)
read_capacity  = 10
write_capacity = 10

// === ARCHIVO: infra/environments/dev/main.tf ===
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

// === ARCHIVO: infra/environments/dev/variables.tf ===
# ==============================================================================
# Variables específicas del entorno de desarrollo
# ==============================================================================
# Define los parámetros configurables para la infraestructura del entorno dev
# Estas variables permiten personalizar la infraestructura sin modificar el código
# ==============================================================================

# ------------------------------------------------------------------------------
# Variables de configuración global
# ------------------------------------------------------------------------------

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Nombre del entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "environment_suffix" {
  description = "Sufijo único para recursos que requieren nombres globales únicos"
  type        = string
  default     = "001"
}

# ------------------------------------------------------------------------------
# Variables de la tabla DynamoDB
# ------------------------------------------------------------------------------

variable "table_name" {
  description = "Nombre de la tabla DynamoDB para almacenar órdenes"
  type        = string
  default     = "dev-orders-table"
}

variable "billing_mode" {
  description = "Modo de facturación de la tabla DynamoDB (PROVISIONED o PAY_PER_REQUEST)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "read_capacity" {
  description = "Capacidad de lectura provisionada para la tabla yGSIs"
  type        = number
  default     = 5
}

variable "write_capacity" {
  description = "Capacidad de escritura provisionada para la tabla yGSIs"
  type        = number
  default     = 5
}

variable "hash_key" {
  description = "Nombre del atributo de clave hash (partition key)"
  type        = string
  default     = "orderId"
}

variable "hash_key_type" {
  description = "Tipo de dato de la clave hash (S=String, N=Number, B=Binary)"
  type        = string
  default     = "S"
}

variable "range_key" {
  description = "Nombre del atributo de clave de rango (sort key)"
  type        = string
  default     = "createdAt"
}

variable "range_key_type" {
  description = "Tipo de dato de la clave de rango (S=String, N=Number, B=Binary)"
  type        = string
  default     = "S"
}

variable "attributes" {
  description = "Lista de atributos adicionales para la tabla DynamoDB"
  type = list(object({
    name = string
    type = string
  }))
  default = [
    {
      name = "customerId"
      type = "S"
    },
    {
      name = "status"
      type = "S"
    }
  ]
}

variable "global_secondary_indexes" {
  description = "Lista de índices secundarios globales para consultas eficientes"
  type = list(object({
    name               = string
    hash_key           = string
    range_key          = string
    projection_type    = string
    read_capacity      = number
    write_capacity     = number
    non_key_attributes = list(string)
  }))
  default = []
}

variable "local_secondary_indexes" {
  description = "Lista de índices secundarios locales"
  type = list(object({
    name               = string
    range_key          = string
    projection_type    = string
    non_key_attributes = list(string)
  }))
  default = []
}

variable "ttl_attribute_name" {
  description = "Nombre del atributo para Time To Live"
  type        = string
  default     = "expiresAt"
}

variable "stream_enabled" {
  description = "Habilita el stream de DynamoDB para captura de cambios"
  type        = bool
  default     = true
}

variable "stream_view_type" {
  description = "Tipo de vista del stream (KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES)"
  type        = string
  default     = "NEW_AND_OLD_IMAGES"
}

variable "server_side_encryption_enabled" {
  description = "Habilita el cifrado del lado del servidor"
  type        = bool
  default     = true
}

variable "server_side_encryption_kms_key_arn" {
  description = "ARN de la clave KMS para cifrado (null para usar la managed key de AWS)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Etiquetas para todos los recursos del entorno"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "orders-management"
    ManagedBy   = "terraform"
  }
}

// === ARCHIVO: infra/environments/dev/outputs.tf ===
# ==============================================================================
# Salidas del entorno de desarrollo
# ==============================================================================
# Este archivo define los outputs del módulo de entorno de desarrollo.
# Expone los valores de los recursos creados para que puedan ser consumidos
# por otros módulos o por la aplicación que utiliza esta infraestructura.
#
# Los outputs permiten:
# - Referenciar recursos creados desde otros proyectos Terraform
# - Obtener información de conexión para la aplicación
# - Validar que la infraestructura se desplegó correctamente
# ==============================================================================

# ------------------------------------------------------------------------------
# Salidas de la tabla DynamoDB
# ------------------------------------------------------------------------------

output "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB de órdenes creada en el entorno de desarrollo"
  value       = module.dynamodb_orders.table_name
  sensitive   = false
}

output "dynamodb_table_arn" {
  description = "ARN completo de la tabla DynamoDB de órdenes"
  value       = module.dynamodb_orders.table_arn
  sensitive   = false
}

output "dynamodb_table_id" {
  description = "ID interno de la tabla DynamoDB"
  value       = module.dynamodb_orders.table_id
  sensitive   = false
}

output "dynamodb_hash_key" {
  description = "Nombre del atributo de clave hash (partition key) de la tabla de órdenes"
  value       = module.dynamodb_orders.hash_key
  sensitive   = false
}

output "dynamodb_range_key" {
  description = "Nombre del atributo de clave de rango (sort key) de la tabla de órdenes"
  value       = module.dynamodb_orders.range_key
  sensitive   = false
}

# ------------------------------------------------------------------------------
# Salidas de configuración regional
# ------------------------------------------------------------------------------

output "aws_region" {
  description = "Región de AWS donde se desplegó la infraestructura del entorno de desarrollo"
  value       = var.aws_region
  sensitive   = false
}

output "environment_name" {
  description = "Nombre del entorno de despliegue"
  value       = var.environment
  sensitive   = false
}

# ------------------------------------------------------------------------------
# Salidas para conexión de la aplicación
# ------------------------------------------------------------------------------

output "connection_info" {
  description = "Información de conexión para la aplicación"
  value = {
    region          = var.aws_region
    table_name      = module.dynamodb_orders.table_name
    table_arn       = module.dynamodb_orders.table_arn
    endpoint_url    = "dynamodb.${var.aws_region}.amazonaws.com"
    environment     = var.environment
  }
  sensitive = false
}

# ------------------------------------------------------------------------------
# Salidas de resumen de recursos
# ------------------------------------------------------------------------------

output "resources_summary" {
  description = "Resumen de los recursos creados en el entorno de desarrollo"
  value = {
    dynamodb_table_created = true
    table_name             = module.dynamodb_orders.table_name
    environment            = var.environment
    region                 = var.aws_region
  }
  sensitive = false
}

# ------------------------------------------------------------------------------
# Salidas para validación
# ------------------------------------------------------------------------------

output "validation_outputs" {
  description = "Outputs utilizados para validar el despliegue correcto de la infraestructura"
  value = {
    table_exists    = module.dynamodb_orders.table_name != ""
    table_arn_valid = can(regex("^arn:aws:dynamodb:", module.dynamodb_orders.table_arn))
    region_matches  = can(regex(var.aws_region, module.dynamodb_orders.table_arn))
  }
  sensitive = false
}

// === ARCHIVO: infra/README.md ===
# Módulo de Infraestructura - Entorno de Desarrollo

## Descripción General

Este módulo define la infraestructura del entorno de desarrollo para el sistema de gestión de órdenes sobre DynamoDB. El módulo utiliza Terraform para aprovisionar y configurar los recursos de AWS necesarios para soportar las operaciones CRUD de la aplicación de comercio electrónico.

## Arquitectura de la Solución

La infraestructura se organiza en módulos reutilizables que siguen las mejores prácticas de Infrastructure as Code (IaC):

```
environments/dev/
├── main.tf          # Configuración principal del entorno
├── variables.tf     # Definición de variables de entrada
├── outputs.tf       # Definición de salidas del entorno
├── terraform.tfvars # Valores de variables específicos del entorno
└── README.md        # Este archivo

modules/
└── dynamodb/        # Módulo reutilizable para tablas DynamoDB
    ├── main.tf      # Definición del recurso DynamoDB
    ├── variables.tf # Variables del módulo
    └── outputs.tf   # Salidas del módulo
```

## Recursos Aprovisionados

### Tabla DynamoDB de Órdenes

El módulo aprovisiona una tabla DynamoDB diseñada para almacenar información de órdenes de comercio electrónico con las siguientes características:

- **Clave de partición (Hash Key)**: `order_id` - Identificador único de cada orden
- **Clave de ordenación (Sort Key)**: `created_at` - Timestamp de creación para ordenamiento
- **Modo de facturación**: PAY_PER_REQUEST (sob demanda) para optimizar costos en desarrollo
- **Cifrado**: Habilitado con clave KMS administrada por AWS
- **Streams**: Deshabilitados en entorno de desarrollo

### Configuración Regional

- **Región AWS**: us-east-1 (Norte de Virginia)
- **Entorno**: development

## Uso del Módulo

### Requisitos Previos

- Terraform >= 1.9.0 instalado
- Credenciales de AWS configuradas con permisos para crear recursos de DynamoDB
- Provider AWS version 5.x

### Configuración de Credenciales

El módulo utiliza el provider de AWS configurado en el archivo `providers.tf` del proyecto raíz. Asegúrate de tener tus credenciales configuradas mediante una de las siguientes opciones:

1. Variables de entorno:
   ```bash
   export AWS_ACCESS_KEY_ID="tu_access_key"
   export AWS_SECRET_ACCESS_KEY="tu_secret_key"
   ```

2. Perfil de credentials:
   ```bash
   export AWS_PROFILE="tu_perfil"
   ```

3. Credenciales compartidas en `~/.aws/credentials`

### Ejecución del Módulo

1. Navega al directorio del entorno:
   ```bash
   cd environments/dev
   ```

2. Inicializa Terraform:
   ```bash
   terraform init
   ```

3. Valida la configuración:
   ```bash
   terraform validate
   ```

4. Previsualiza los cambios:
   ```bash
   terraform plan
   ```

5. Aplica los cambios:
   ```bash
   terraform apply
   ```

6. Confirma la aplicación escribiendo `yes`

### Destrucción de Recursos

Para eliminar todos los recursos creados por este módulo:

```bash
terraform destroy
```

**Advertencia**: Esta operación eliminará permanentemente la tabla DynamoDB y todos sus datos.

## Outputs Disponibles

El módulo expone los siguientes outputs que pueden ser consumidos por otros módulos o por la aplicación:

| Output | Descripción |
|--------|-------------|
| `dynamodb_table_name` | Nombre de la tabla DynamoDB creada |
| `dynamodb_table_arn` | ARN completo de la tabla |
| `dynamodb_table_id` | ID interno de la tabla |
| `dynamodb_hash_key` | Nombre de la clave de partición |
| `dynamodb_range_key` | Nombre de la clave de ordenación |
| `aws_region` | Región de AWS donde se desplegó |
| `environment_name` | Nombre del entorno |
| `connection_info` | Objeto con información de conexión para la aplicación |
| `resources_summary` | Resumen de recursos creados |
| `validation_outputs` | Validaciones del despliegue |

## Conexión desde la Aplicación

Para conectar tu aplicación a la tabla DynamoDB aprovisionada, utiliza los outputs del módulo:

### Ejemplo de configuración de variables de entorno

```bash
export DYNAMODB_TABLE_NAME="ordenes-dev"
export AWS_REGION="us-east-1"
```

### Ejemplo de uso en código

```python
import boto3

# Obtener valores de outputs de Terraform
dynamodb = boto3.resource('dynamodb', region_name='us-east-1')
table = dynamodb.Table('ordenes-dev')

# Operaciones CRUD
table.put_item(Item={...})
table.get_item(Key={'order_id': '...'})
table.update_item(Key={...}, UpdateExpression=...)
table.delete_item(Key={...})
```

## Validación del Despliegue

Después de aplicar el módulo, puedes verificar que los recursos se crearon correctamente:

1. **Verificar en consola AWS**:
   - Navega a DynamoDB en la consola de AWS
   - Busca la tabla con nombre `ordenes-dev`

2. **Verificar con AWS CLI**:
   ```bash
   aws dynamodb describe-table --table-name ordenes-dev --region us-east-1
   ```

3. **Verificar con Terraform**:
   ```bash
   terraform output
   ```

## Consideraciones de Seguridad

- La tabla DynamoDB está cifrada con clave KMS administrada por AWS (AWS_MANAGED_KMS_KEY)
- El acceso a la tabla debe configurarse mediante políticas IAM apropiadas
- En producción, considera habilitar DynamoDB Streams para auditoría
- Las credenciales de AWS no deben incluirse en el código fuente

## Mantenimiento

### Actualización del Módulo

Para actualizar la configuración de la infraestructura:

1. Modifica los archivos de configuración necesarios
2. Ejecuta `terraform plan` para ver los cambios
3. Ejecuta `terraform apply` para aplicar los cambios

### Gestión de Estado

El estado de Terraform se almacena localmente en el directorio `.terraform/`. Para entornos de producción, considera usar backend remoto (S3 con DynamoDB para locking).

## Troubleshooting

### Error: "InvalidSignatureException"

Verifica que tus credenciales de AWS estén correctamente configuradas y no hayan expirado.

### Error: "ResourceNotFoundException"

La tabla puede no existir. Ejecuta `terraform apply` para crear los recursos.

### Error: "AccessDeniedException"

Tu usuario/rol de IAM no tiene permisos suficientes. Verifica los permisos de DynamoDB.

## Referencias

- [Documentación de Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Documentación de DynamoDB](https://docs.aws.amazon.com/dynamodb/)
- [Mejores prácticas de Terraform](https://www.terraform.io/docs/cloud/guides/recommended-practices.html)

// === ARCHIVO: infra/modules/dynamodb/main.tf ===
# ==============================================================================
# Módulo Terraform para la creación y configuración de tablas DynamoDB
# ==============================================================================
# Proporciona una interfaz reutilizable para definir tablas DynamoDB con
# claves primarias, índices secundarios y configuraciones de rendimiento.
# Este módulo crea una tabla DynamoDB con todas las configuraciones necesarias
# incluyendo cifrado, streams, TTL y capacidades de throughput.
# ==============================================================================

resource "aws_dynamodb_table" "this" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  hash_key       = var.hash_key
  range_key      = var.range_key
  read_capacity  = var.billing_mode == "PROVISIONED" ? var.read_capacity : null
  write_capacity = var.billing_mode == "PROVISIONED" ? var.write_capacity : null
  stream_enabled = var.stream_enabled
  stream_view_type = var.stream_enabled ? var.stream_view_type : null

  dynamic "attribute" {
    for_each = concat(
      [{ name = var.hash_key, type = var.hash_key_type }],
      var.range_key != null ? [{ name = var.range_key, type = var.range_key_type }] : [],
      var.attributes
    )
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes
    content {
      name               = global_secondary_index.value.name
      hash_key           = global_secondary_index.value.hash_key
      range_key          = global_secondary_index.value.range_key
      projection_type    = global_secondary_index.value.projection_type
      read_capacity      = global_secondary_index.value.read_capacity
      write_capacity     = global_secondary_index.value.write_capacity
      non_key_attributes = global_secondary_index.value.non_key_attributes
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_indexes
    content {
      name               = local_secondary_index.value.name
      range_key          = local_secondary_index.value.range_key
      projection_type    = local_secondary_index.value.projection_type
      non_key_attributes = local_secondary_index.value.non_key_attributes
    }
  }

  dynamic "ttl" {
    for_each = var.ttl_attribute_name != null ? [var.ttl_attribute_name] : []
    content {
      attribute_name = ttl.value
      enabled        = true
    }
  }

  dynamic "server_side_encryption" {
    for_each = var.server_side_encryption_enabled ? [1] : []
    content {
      enabled     = true
      kms_key_arn = var.server_side_encryption_kms_key_arn
    }
  }

  tags = var.tags

  point_in_time_recovery {
    enabled = true
  }
}

// === ARCHIVO: docker-compose.yml ===
# Infraestructura local del reto. SOLO desarrollo: credenciales de ejemplo (local-dev-only), puertos en loopback.
# Levantar: docker compose up -d --wait
name: infra-local
services:
  dynamodb-local:
    image: "amazon/dynamodb-local:2.5.2"
    command: ["-jar","DynamoDBLocal.jar","-sharedDb","-inMemory"]
    ports:
      - "127.0.0.1:8000:8000"
    healthcheck:
      test: ["CMD-SHELL","bash -c ':> /dev/tcp/127.0.0.1/8000' || exit 1"]
      interval: 10s
      timeout: 5s
      retries: 10
      start_period: 5s


// === ARCHIVO: infra-local/README.md ===
# Infraestructura local

Servicios de soporte para el reto, definidos en `docker-compose.yml` (raiz del repo).

```bash
docker compose up -d --wait
```

| Servicio | Imagen | Puertos (host) |
|---|---|---|
| DynamoDB Local | `amazon/dynamodb-local:2.5.2` | 8000 |

Credenciales: solo de desarrollo local (`local-dev-only`, `local`). No son secretos ni deben reutilizarse.
Los scripts de `infra-local/` (tablas, topics) se ejecutan con el compose en estado healthy.


// === ARCHIVO: infra-local/dynamodb/create-tables.sh ===
#!/usr/bin/env bash
# Crea las tablas en DynamoDB Local (idempotente). Credenciales dummy: DynamoDB Local no valida firmas.
set -euo pipefail

export AWS_ACCESS_KEY_ID=local
export AWS_SECRET_ACCESS_KEY=local
export AWS_REGION=us-east-1
ENDPOINT="${DYNAMODB_ENDPOINT:-http://localhost:8000}"

create_table() {
  local name="$1" pk="$2" sk="${3:-}"
  if aws dynamodb describe-table --table-name "$name" --endpoint-url "$ENDPOINT" >/dev/null 2>&1; then
    echo "Tabla $name ya existe"
    return
  fi
  local attrs="AttributeName=$pk,AttributeType=S"
  local keys="AttributeName=$pk,KeyType=HASH"
  if [ -n "$sk" ]; then
    attrs="$attrs AttributeName=$sk,AttributeType=S"
    keys="$keys AttributeName=$sk,KeyType=RANGE"
  fi
  # shellcheck disable=SC2086
  aws dynamodb create-table --table-name "$name" --attribute-definitions $attrs --key-schema $keys \
    --billing-mode PAY_PER_REQUEST --endpoint-url "$ENDPOINT" >/dev/null
  echo "Tabla $name creada"
}

create_table "app-items" "id"

```
