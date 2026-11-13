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