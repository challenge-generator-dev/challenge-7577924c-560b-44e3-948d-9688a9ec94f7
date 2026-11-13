# Implementación de operaciones CRUD de órdenes en DynamoDB

En este reto, el candidato debe implementar operaciones CRUD (Crear, Leer, Actualizar, Eliminar) de órdenes en una tabla DynamoDB. Estas operaciones serán expuestas a través de una API REST. El dominio es una plataforma de comercio electrónico donde los usuarios pueden realizar y gestionar sus órdenes. Los actores son Compradores y el Sistema de Gestión de Órdenes. La tabla DynamoDB almacenará información sobre las órdenes, incluyendo ID, estado, precio total y fecha de creación. El objetivo es persistir y consultar órdenes de manera eficiente y segura.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | CRUD de ordenes sobre DynamoDB |
| **Nivel** | advanced-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Node.js 18+, npm, VS Code o similar.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Ejecuta `npm install && npm run build` (o `npm start`). Si no hay errores, estás listo.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configuración inicial y creación de la tabla DynamoDB

**Objetivo:** Configurar el entorno de desarrollo y crear la tabla DynamoDB para almacenar las órdenes.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Configura el entorno de desarrollo utilizando las herramientas proporcionadas.
- Crea una tabla DynamoDB con las columnas necesarias para almacenar la información de las órdenes.

**Entregable:** Tabla DynamoDB creada y configurada con las columnas necesarias.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza Terraform para configurar la infraestructura como código.
- Define las columnas necesarias para almacenar la información de las órdenes.

</details>

### Fase 2: Implementación de las operaciones CRUD en la API REST

**Objetivo:** Implementar las operaciones CRUD (Crear, Leer, Actualizar, Eliminar) en la API REST.

**Tiempo estimado:** 4 horas

**Instrucciones:**

- Implementa las operaciones CRUD en la API REST para interactuar con la tabla DynamoDB.
- Asegúrate de que las operaciones CRUD sean eficientes y seguras.

**Entregable:** API REST con las operaciones CRUD implementadas y funcionales.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza las mejores prácticas para implementar las operaciones CRUD.
- Considera la eficiencia y seguridad en la implementación de las operaciones.

</details>

### Fase 3: Pruebas y optimización de las operaciones CRUD

**Objetivo:** Realizar pruebas y optimizar las operaciones CRUD implementadas.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Realiza pruebas exhaustivas de las operaciones CRUD para asegurar su funcionalidad y eficiencia.
- Identifica y optimiza cualquier punto de mejora en las operaciones CRUD.

**Entregable:** Operaciones CRUD optimizadas y funcionales, con pruebas realizadas.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza herramientas de prueba para realizar pruebas exhaustivas de las operaciones CRUD.
- Identifica y aplica optimizaciones para mejorar la eficiencia de las operaciones CRUD.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué son las operaciones CRUD y cómo se aplican en este reto?
- **paraQueSirve**: ¿Para qué sirven las operaciones CRUD en el contexto de este reto?
- **comoSeUsa**: ¿Cómo se utilizan las operaciones CRUD en la API REST implementada?
- **erroresComunes**: ¿Qué errores comunes pueden ocurrir al implementar las operaciones CRUD y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica la implementación de las operaciones CRUD en términos de eficiencia y seguridad?

## Criterios de Evaluacion

- Configuración inicial y creación de la tabla DynamoDB.
- Implementación de las operaciones CRUD en la API REST.
- Realización de pruebas y optimización de las operaciones CRUD.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

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

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd app && npm install --no-audit --no-fund && npm run build) && (cd infra && terraform init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/dynamodb init -backend=false && terraform validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/dynamodb validate) && docker compose config -q
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
