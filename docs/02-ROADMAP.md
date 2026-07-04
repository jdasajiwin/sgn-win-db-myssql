# Roadmap - Base de Datos

Estado alineado con el schema y seed actuales.

## Fase 1: Estructura Base — Completada

### T-001: Tablas maestras
- **Estado**: Completado
- **Tablas**: catálogos de operadores, departamentos, estados, menús, roles, permisos, etc.
- **Script**: `schema/schema_erflow.sql`

### T-002: Tablas transaccionales base
- **Estado**: Completado
- **Tablas**: `t_usuarios`, `t_usuario_rol`, `t_rango_numeracion`, `t_numero_telefonico`, `t_trazabilidad_eventos`
- **Script**: `schema/schema_erflow.sql`

### T-003: Stored Procedures base
- **Estado**: Completado (usuarios, catálogos, trazabilidad)
- **Cantidad**: 26 SP en `objects/sp/`

---

## Fase 2: Seguridad y Auditoría — En progreso

### T-004: Sistema de roles y permisos
- **Estado**: En progreso
- **Tablas**: `m_permisos`, `m_roles_permisos`, `m_menus_permisos`, `m_roles_menus`
- **Seed**: matriz de permisos por rol en `data/seed_erflow.sql`
- **Pendiente**:
  - [ ] SP de validación de permiso por usuario (`p_id_usuario` + `cod_permiso`)
  - [ ] Unificar `spl_usuario_permisos_listar` para consulta por usuario

### T-005: Auditoría y trazabilidad
- **Estado**: En progreso
- **Tablas**: `t_trazabilidad_eventos`, `t_auditoria`, `m_eventos`
- **SP**:
  - `spi_trazabilidad` — insertar evento
  - `spl_trazabilidad` — listar eventos con filtros
  - `spl_detalle_template` - plantilla de evento

---

## Fase 3: Gestión de Números — En progreso

### T-006: Rangos de numeración
- **Estado**: En progreso (tabla lista, SP parcial)
- **Tabla**: `t_rango_numeracion`
- **SP**: `spl_estado_rango` (solo catálogo de estados)
- **Pendiente**: SP de CRUD y generación de números

### T-007: Números telefónicos
- **Estado**: En progreso (tabla lista, SP parcial)
- **Tabla**: `t_numero_telefonico`, `t_historial_numero`, `t_numero_adjunto`
- **Pendiente**: SP de consulta, asignación y cambio de estado

### T-008: Estados de números
- **Estado**: Completado
- **Tabla**: `m_estado_numero`
- **Valores seed**: No habilitado, Disponible, Pre-reserva, Bloqueado, Pendiente portabilidad, En uso, Baja, Bloqueado port in, Port out

---

## Fase 4: Portabilidad — En progreso

### T-009: Portabilidad numérica
- **Estado**: En progreso (estructura creada)
- **Tabla**: `t_portabilidad_numero`
- **Catálogos**: `m_estado_portabilidad`, `m_motivo_rechazo`, `m_operador`, `m_tipo_documento`
- **Índices de búsqueda**: fecha programación, estado, operador cedente
- **Pendiente**:
  - [ ] SP de consulta con filtros
  - [ ] SP de importación/exportación de plantilla
  - [ ] Seed de datos de prueba

---

## Fase 5: Contingencia — Por definir

### T-010: Contingencia Freeswitch
- **Estado**: Por definir
- **Menús seed**: Contingencia (id_menu 7), Números WI NET (8), Números Portados (9)
- **Permisos seed**: `contingencia_freeswitch.consultar`, `contingencia_freeswitch.activar`
- **Pendiente**: tablas transaccionales de contingencia

---

## Fase 6: Optimización — Futura

### T-011: Índices y performance
- **Estado**: Parcialmente completado
- **Hecho**: índices en `t_numero_telefonico`, `t_rango_numeracion`, `t_portabilidad_numero`
- **Pendiente**: análisis EXPLAIN en producción, particionamiento

### T-012: Archivado de datos
- **Estado**: Por definir
- **Candidatos**: `t_trazabilidad_eventos`, `t_historial_numero`

---
