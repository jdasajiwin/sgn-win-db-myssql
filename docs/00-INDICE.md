# Documentación - Base de Datos MySQL

## Índice de contenidos

1. **[Pendientes](./01-PENDIENTES.md)** - Tareas pendientes de la BD
2. **[Roadmap](./02-ROADMAP.md)** - Plan de desarrollo
3. **[Diccionario de datos](./03-DICCIONARIO-DATOS.md)** - Estructura de tablas y campos
4. **[Stored Procedures](./04-STORED-PROCEDURES.md)** - Documentación de SP
5. **[Especificaciones](./05-ESPECIFICACIONES.md)** - Estándares y convenciones
6. **[Roles y Permisos](./06-ROLES-PERMISOS.md)** - Matriz de acceso por rol

---

## Resumen rápido

- **SGBD**: MySQL 8.0+
- **Base de datos**: `win_sgn_db`
- **Nombre**: SGN (Sistema de Gestión de Numeración)
- **Convención**: snake_case, prefijos `m_` (maestros) y `t_` (transaccionales)
- **Integración**: Stored Procedures desde Backend (Laravel)
- **Fuentes de verdad**: `schema/schema_erflow.sql`, `data/seed_erflow.sql`, `objects/sp/*.sql`

## Diagrama E-R simplificado

```
m_roles ──→ m_roles_permisos ──→ m_permisos ←── m_menus_permisos ── m_menus
   │                                    │
   └──→ t_usuario_rol ←── t_usuarios    └── (cod_permiso por módulo/acción)
              │
              └──→ t_trazabilidad_eventos ←── m_eventos

t_rango_numeracion ──→ t_numero_telefonico ──→ t_historial_numero
        │                      │                      t_numero_adjunto
        ├── m_tipo_servicio
        ├── m_departamento
        ├── m_tipo_zona
        ├── m_proveedor_numeracion
        ├── m_comercializador
        └── m_estado_rango

t_portabilidad_numero ──→ m_estado_portabilidad
        │                 m_operador (cedente/receptor)
        │                 m_tipo_documento
        └──                 m_motivo_rechazo
```

## Tablas del schema actual

### Maestros (`m_*`) — 25 tablas

| Tabla | Descripción |
|-------|-------------|
| `m_acceso_usuario` | Tipos de acceso (Permitido, Bloqueado) |
| `m_comercializador` | Comercializadores |
| `m_departamento` | Departamentos con ubigeo y cobertura |
| `m_estado_numero` | Estados del número telefónico |
| `m_estado_portabilidad` | Estados de solicitud de portabilidad |
| `m_estado_proceso` | Estados de procesos batch |
| `m_estado_rango` | Estados del rango de numeración |
| `m_estado_usuario` | Estados del usuario (Activo/Inactivo) |
| `m_eventos` | Catálogo de eventos de trazabilidad |
| `m_menus` | Menús y submenús de navegación |
| `m_motivo_cambio` | Motivos de cambio de estado de número |
| `m_motivo_rechazo` | Motivos de rechazo de portabilidad |
| `m_operador` | Operadores de telecomunicaciones |
| `m_opciones` | Opciones de menú (PK compuesta con `id_menu`) |
| `m_permisos` | Permisos granulares (`cod_permiso`) |
| `m_plan_telefonia` | Planes de telefonía |
| `m_proveedor_numeracion` | Proveedores de numeración |
| `m_roles` | Roles del sistema (5 roles base) |
| `m_roles_menus` | Menús asignados por rol |
| `m_roles_opciones` | Opciones asignadas por rol |
| `m_roles_permisos` | Permisos asignados por rol |
| `m_menus_permisos` | Permisos requeridos por menú |
| `m_tipo_documento` | Tipos de documento (DNI, RUC, etc.) |
| `m_tipo_evento` | Tipos de evento (FORMULARIO, API, JOB) |
| `m_tipo_servicio` | Tipos de servicio (Fijo, Móvil) |
| `m_tipo_zona` | Tipos de zona (Rural, Urbano) |

### Transaccionales (`t_*`) — 9 tablas

| Tabla | Descripción |
|-------|-------------|
| `t_auditoria` | Registro de auditoría ligado a eventos |
| `t_historial_numero` | Historial de cambios de estado de número |
| `t_numero_adjunto` | Archivos adjuntos de número telefónico |
| `t_numero_telefonico` | Números telefónicos individuales |
| `t_portabilidad_numero` | Solicitudes de portabilidad numérica |
| `t_rango_numeracion` | Rangos de numeración generados |
| `t_trazabilidad_eventos` | Trazabilidad de acciones del sistema |
| `t_usuario_rol` | Asignación usuario ↔ rol |
| `t_usuarios` | Usuarios del sistema |

### Tablas auxiliares (aplicación)

| Tabla | Descripción |
|-------|-------------|
| `app_security_settings` | Configuración de seguridad de la app |
| `app_user_sessions` | Sesiones de usuario |

## Stored Procedures

26 procedimientos en `objects/sp/` (23 `spl_`, 2 `sps_`, 1 `spi_`). Ver [04-STORED-PROCEDURES.md](./04-STORED-PROCEDURES.md).

## Inicio rápido

Ver [Especificaciones](./05-ESPECIFICACIONES.md) para estándares de desarrollo.

Ver [Diccionario de datos](./03-DICCIONARIO-DATOS.md) para estructura detallada.
