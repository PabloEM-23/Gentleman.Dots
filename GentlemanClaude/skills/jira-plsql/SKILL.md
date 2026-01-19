---
name: jira-plsql
description: >
  Crea tickets de Jira para desarrollo PL/SQL/Oracle siguiendo el estilo de Pablo.
  Trigger: PL/SQL, Oracle, packages, procedures, base de datos, DBA, fix producción.
license: Apache-2.0
metadata:
  author: pablo-mazzeo
  version: "1.0"
---

## When to Use

Usar este skill cuando el usuario mencione:
- PL/SQL, Oracle, procedures, packages, funciones
- Base de datos, BD, PROD, PREUAT, esquemas
- DBA, compilar, scripts, rollback
- Fix, hotfix, issue en producción
- PACK_*, PR_*, P_*, APP_ESDC81
- Pagos, Claro Drive, VTC, HUB

## Proyectos Conocidos

| Proyecto | Área | Descripción |
|----------|------|-------------|
| **PGS** | Pagos | Backend de pagos, transacciones |
| **CLGLO** | Cluster Global | Backend MX/CO/BR, VTC |
| **BSS** | Business Support | Claro Drive, soporte |
| **DBA** | Database Admin | Requests de compilación |
| **USR** | Usuarios | Sociabilización |
| **CDNN** | Cloud | Infraestructura cloud |

## Naming Conventions

### Packages
- Formato: `PACK_{MODULO}` o `PACK_{MODULO}_V{N}`
- Ejemplos: `PACK_VTC_V9`, `PACK_G3`, `PACK_HUB_NEW`, `PACK_CHANNEL`

### Procedures
- Formato: `PR_{ACCION}_{ENTIDAD}` o `P_{ACCION}_{ENTIDAD}`
- Ejemplos: `PR_INSERT_TX_PAQ`, `PR_GET_PAGO_DISPOSITIVO`, `P_VALIDATE_CHANNEL`

### Esquema Principal
- `APP_ESDC81` - Esquema de aplicación

---

## Templates por Tipo de Ticket

### 1. Desarrollo PL/SQL (Formato BDD)

**Usar para:** Nuevos procedures, packages, o modificaciones significativas.

**Título:** `[FEATURE] {Descripción corta del desarrollo}`

```markdown
h2. Característica: {Nombre descriptivo de la funcionalidad}

h3. Contexto
{Breve explicación del problema o necesidad que resuelve este desarrollo}

h3. Escenario 1: {Nombre del escenario - caso exitoso}
*Dado que* {precondición del sistema}
*Cuando* {acción que dispara el proceso}
*Entonces* {resultado esperado}
*Y* {condición adicional si aplica}

h3. Escenario 2: {Nombre del escenario - caso alternativo}
*Dado que* {precondición}
*Cuando* {acción}
*Entonces* {resultado}

h3. Escenario 3: {Nombre del escenario - caso de error}
*Dado que* {precondición}
*Cuando* {acción que genera error}
*Entonces* {manejo del error esperado}

h2. Especificación Técnica

h3. Package/Procedure
* *Package:* PACK_{nombre}
* *Procedure:* PR_{nombre}
* *Esquema:* APP_ESDC81

h3. Parámetros de Entrada
||Parámetro||Tipo||Descripción||
|p_param1|VARCHAR2|Descripción del parámetro|
|p_param2|NUMBER|Descripción del parámetro|

h3. Parámetros de Salida
||Parámetro||Tipo||Descripción||
|p_codigo|NUMBER|Código de respuesta (0=OK)|
|p_mensaje|VARCHAR2|Mensaje descriptivo|
|p_cursor|SYS_REFCURSOR|Cursor con resultados|

h3. Códigos de Respuesta
||Código||Descripción||
|0|Operación exitosa|
|-1|Error de validación|
|-2|Error de base de datos|
```

---

### 2. Request DBA

**Usar para:** Solicitar compilación de scripts en ambientes (PROD, PREUAT).

**Título:** `[DBA] Compilar {PACK_nombre} en {AMBIENTE}`

```markdown
h2. Request de Compilación

h3. Información General
* *Ambiente:* {PROD / PREUAT / DEV}
* *Esquema:* APP_ESDC81
* *Fecha requerida:* {fecha}
* *Urgencia:* {Alta / Media / Baja}

h3. Scripts a Compilar

h4. 1. SPEC del Package
{code:sql}
-- Pegar aquí el SPEC completo
CREATE OR REPLACE PACKAGE APP_ESDC81.PACK_NOMBRE AS
...
END PACK_NOMBRE;
/
{code}

h4. 2. BODY del Package
{code:sql}
-- Pegar aquí el BODY completo
CREATE OR REPLACE PACKAGE BODY APP_ESDC81.PACK_NOMBRE AS
...
END PACK_NOMBRE;
/
{code}

h3. Permisos y Sinónimos
{code:sql}
-- Grants necesarios
GRANT EXECUTE ON APP_ESDC81.PACK_NOMBRE TO {usuario};

-- Sinónimos si aplica
CREATE OR REPLACE PUBLIC SYNONYM PACK_NOMBRE FOR APP_ESDC81.PACK_NOMBRE;
{code}

h3. Script de Rollback
{code:sql}
-- Script para revertir en caso de problemas
-- Incluir versión anterior del package o DROP si es nuevo
{code}

h3. Validación Post-Compilación
{code:sql}
-- Query para validar que compiló correctamente
SELECT object_name, object_type, status
FROM all_objects
WHERE owner = 'APP_ESDC81'
AND object_name = 'PACK_NOMBRE';
{code}

h3. Ticket Relacionado
* Desarrollo: {PGS-XXXX o CLGLO-XXXX}
```

---

### 3. Fix/Hotfix Producción

**Usar para:** Correcciones urgentes en producción.

**Título:** `[HOTFIX] {Descripción del problema y solución}`

```markdown
h2. Descripción del Problema
{Explicación clara del error detectado en producción}

h3. Impacto
* *Severidad:* {Crítica / Alta / Media}
* *Usuarios afectados:* {descripción}
* *Desde cuándo:* {fecha/hora aproximada}

h2. Análisis de Causa Raíz
{Explicación técnica de por qué ocurre el error}

h2. Solución Propuesta

h3. Script de Fix
{code:sql}
-- Script a ejecutar en producción
{código SQL}
{code}

h3. Package/Procedure Afectado
* *Package:* PACK_{nombre}
* *Procedure:* PR_{nombre}
* *Línea aproximada:* {número}

h2. Script de Rollback
{code:sql}
-- En caso de que el fix genere problemas
{código de rollback}
{code}

h2. Validación
{code:sql}
-- Query para verificar que el fix funcionó
{código de validación}
{code}

h2. Pasos para Aplicar
# Backup de datos afectados (si aplica)
# Ejecutar script de fix
# Validar con query de verificación
# Monitorear logs por X minutos
```

---

### 4. Issue/Bug

**Usar para:** Reportar problemas detectados que requieren investigación.

**Título:** `[BUG] {Descripción del comportamiento inesperado}`

```markdown
h2. Descripción del Problema
{Descripción clara del comportamiento inesperado}

h3. Comportamiento Esperado
{Qué debería pasar}

h3. Comportamiento Actual
{Qué está pasando realmente}

h2. Información del Error

h3. Trace/Logs
{code}
-- Pegar aquí el trace o log del error
ORA-XXXXX: mensaje de error
at PACK_NOMBRE.PR_PROCEDURE line XX
{code}

h3. Datos de Prueba
* *ID de transacción:* {id}
* *Fecha/Hora:* {timestamp}
* *Usuario:* {usuario afectado}

h2. Contexto Técnico

h3. Package/Procedure Involucrado
* *Package:* PACK_{nombre}
* *Procedure:* PR_{nombre}
* *Esquema:* APP_ESDC81

h3. SQL Involucrado
{code:sql}
-- Query o procedimiento que genera el error
{código}
{code}

h2. Pasos para Reproducir
# Paso 1
# Paso 2
# Paso 3

h2. Análisis Inicial
{Hipótesis sobre la causa del problema}

h2. Ambiente
* *Ambiente:* {PROD / PREUAT}
* *Fecha detección:* {fecha}
* *Reportado por:* {nombre}
```

---

### 5. Soporte Región (Whitelist/IP)

**Usar para:** Solicitudes de whitelist de IP o soporte de región.

**Título:** `[SOPORTE] Whitelist IP - {Cliente/Región}`

```markdown
h2. Información del Cliente
* *Nombre:* {nombre del cliente}
* *País:* {MX / CO / BR / AR}
* *Región:* {estado/provincia}
* *Contacto:* {email o teléfono}

h2. Datos Técnicos
* *IP Pública:* {dirección IP}
* *Proveedor de Internet:* {ISP}
* *Tipo de conexión:* {Fibra / DSL / Móvil}

h2. Problema Reportado
{Descripción del problema que experimenta el cliente}

h2. Validaciones Realizadas
* [ ] IP verificada con cliente
* [ ] Ping/traceroute ejecutado
* [ ] Logs revisados
* [ ] No hay bloqueo por firewall interno

h2. Solicitud
{Descripción clara de lo que se necesita - whitelist, desbloqueo, etc.}

h2. Evidencia
{Capturas de pantalla o logs relevantes}
```

---

### 6. Reporte/Query

**Usar para:** Solicitudes de consultas o reportes de datos.

**Título:** `[QUERY] {Descripción del reporte solicitado}`

```markdown
h2. Descripción del Reporte
{Qué información se necesita y para qué}

h3. Solicitado por
* *Área:* {área solicitante}
* *Contacto:* {nombre}
* *Urgencia:* {Alta / Media / Baja}

h2. Query Propuesto
{code:sql}
-- Query para obtener la información
SELECT ...
FROM ...
WHERE ...
{code}

h2. Resultado Esperado
{Descripción de las columnas y formato del resultado}

h2. Ambiente
* *Base de datos:* {PROD / PREUAT}
* *Esquema:* APP_ESDC81

h2. Frecuencia
{Una vez / Diario / Semanal / Mensual}
```

---

### 7. Cambio Operativo

**Usar para:** Modificaciones de datos en producción (tarifas, configuraciones).

**Título:** `[CAMBIO] {Descripción del cambio operativo}`

```markdown
h2. Descripción del Cambio
{Qué se necesita modificar y por qué}

h3. Solicitado por
* *Área:* {área solicitante}
* *Aprobado por:* {nombre del aprobador}
* *Fecha requerida:* {fecha}

h2. Script de Cambio
{code:sql}
-- Script a ejecutar
UPDATE tabla SET campo = valor WHERE condicion;
COMMIT;
{code}

h2. Datos Afectados

h3. Antes del Cambio
{code:sql}
-- Query para ver estado actual
SELECT * FROM tabla WHERE condicion;
{code}

h3. Después del Cambio
{Descripción del estado esperado}

h2. Script de Rollback
{code:sql}
-- Para revertir el cambio si es necesario
UPDATE tabla SET campo = valor_anterior WHERE condicion;
COMMIT;
{code}

h2. Validación
{code:sql}
-- Query para confirmar el cambio
SELECT * FROM tabla WHERE condicion;
{code}
```

---

## Integración MCP Atlassian

### Crear Ticket de Desarrollo

```json
{
  "project_key": "PGS",
  "summary": "[FEATURE] Nuevo procedure para validar pagos",
  "issue_type": "Task",
  "description": "Ver template de Desarrollo PL/SQL"
}
```

### Crear Request DBA

```json
{
  "project_key": "DBA",
  "summary": "[DBA] Compilar PACK_VTC_V9 en PROD",
  "issue_type": "Task",
  "description": "Ver template de Request DBA"
}
```

### Agregar Comentario

Usar `mcp__atlassian__jira_add_comment` para:
- Actualizaciones de progreso
- Resultados de pruebas
- Scripts de rollback ejecutados
- Validaciones post-deploy

### Transiciones Comunes

```
To Do → In Progress: Iniciar desarrollo
In Progress → Code Review: Listo para revisión
Code Review → Done: Aprobado y desplegado
In Progress → Blocked: Esperando dependencia
```

---

## Checklist Pre-Creación

1. [ ] Identificar tipo de ticket correcto
2. [ ] Usar proyecto apropiado (PGS, CLGLO, BSS, DBA)
3. [ ] Incluir todos los campos del template
4. [ ] Código SQL formateado correctamente
5. [ ] Script de rollback incluido (si aplica)
6. [ ] Parámetros documentados (si es desarrollo)
7. [ ] Ambiente especificado (PROD/PREUAT)

## Keywords

plsql, oracle, procedure, package, pack, dba, compilar, produccion, prod, preuat, fix, hotfix, bug, issue, rollback, app_esdc81, pagos, vtc, hub, claro
