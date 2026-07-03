# Diccionario de Datos

Documentación alineada a `schema/schema_erflow.sql` y `data/seed_erflow.sql`.

**Convenciones del schema actual:**
- PK con prefijo `id_`
- FK con nombre `id_<entidad>` (no usa prefijo `fk_` en columnas)
- Constraints FK: `fk_<tabla_referenciada>_<tabla_origen>`
- Auditoría en `m_*` y `t_*`: `desc_usuario_crea`, `desc_usuario_modf`, `fec_creacion`, `fec_modf`
- Activación/inactivación en catálogos: `flg_activo` (BIT)

---

## Tablas maestras (`m_*`)

### m_roles
Roles del sistema.

| Columna | Tipo | Restricción |
|---------|------|-------------|
| id_rol | INT | PK, AUTO_INCREMENT |
| cod_rol | VARCHAR(12) | NOT NULL, UNIQUE |
| desc_rol | VARCHAR(150) | NOT NULL |
| num_nivel_jerarquia | TINYINT | NOT NULL |
| desc_usuario_crea / desc_usuario_modf | VARCHAR(50) | Auditoría |
| fec_creacion / fec_modf | DATETIME | Auditoría |
| flg_activo | BIT | DEFAULT 1 |

**Valores seed**: 1=SuperAdmin, 2=Admin TI, 3=Gestor de telefonía, 4=Supervisor NOC, 5=Operador NOC

### m_permisos
Permisos granulares por módulo y acción.

| Columna | Tipo | Restricción |
|---------|------|-------------|
| id_permiso | INT | PK, AUTO_INCREMENT |
| cod_permiso | VARCHAR(50) | NOT NULL, UNIQUE |
| desc_modulo | VARCHAR(100) | NOT NULL |
| desc_submodulo | VARCHAR(100) | NULL |
| desc_accion | VARCHAR(100) | NOT NULL |
| desc_permiso | VARCHAR(255) | NULL |
| flg_activo | BIT | DEFAULT 1 |

**Ejemplos**: `usuario.consultar`, `portabilidad.editar`, `rango_numeracion.agregar`

### m_menus / m_opciones
Navegación de la aplicación. `m_opciones` tiene PK compuesta `(id_opcion, id_menu)`.

| m_menus | m_opciones |
|---------|------------|
| id_menu, cod_menu, cod_sub_menu, id_menu_padre, desc_menu, desc_ruta | id_menu (FK), id_opcion, cod_menu, desc_opcion, desc_ruta |

### m_roles_permisos / m_menus_permisos / m_roles_menus / m_roles_opciones
Tablas de relación rol-permiso, menú-permiso, rol-menú y rol-opción.

### m_estado_usuario / m_acceso_usuario
Catálogos de estado y acceso de usuarios.

| m_estado_usuario | m_acceso_usuario |
|------------------|------------------|
| id_estado_usuario, desc_estado | id_acceso_usuario, desc_acceso |

**Seed**: Activo/Inactivo; Permitido/Bloqueado

### m_departamento
Departamentos con datos de ubigeo y cobertura telefónica.

| Columna | Tipo | Restricción |
|---------|------|-------------|
| id_departamento | INT | PK |
| desc_departamento | VARCHAR(150) | NOT NULL |
| cod_ubigeo_departamento | CHAR(10) | NOT NULL |
| cod_tel_departamento | CHAR(10) | NOT NULL |
| cobertura_departamento | CHAR(10) | NOT NULL |

### m_operador
Operadores de telecomunicaciones (ABDCP).

| Columna | Tipo | Restricción |
|---------|------|-------------|
| id_operador | SMALLINT | PK |
| desc_operador | VARCHAR(150) | NOT NULL |
| cod_enrutador | VARCHAR(20) | NULL |

### m_estado_numero
Estados del número telefónico.

**Valores seed**: No habilitado, Disponible, Pre-reserva, Bloqueado, Pendiente portabilidad, En uso, Baja, Bloqueado port in, Port out

### m_estado_portabilidad
Estados de solicitud de portabilidad.

**Valores seed**: Pendiente, Programado, Portado, Rechazado

### m_motivo_rechazo / m_motivo_cambio
Motivos de rechazo de portabilidad y de cambio de estado de número.

### m_tipo_documento
Tipos de documento de identidad.

**Valores seed**: DNI, CE, RUC, Pasaporte, Carnet de identidad personal

### m_tipo_servicio / m_tipo_zona
Catálogos para rangos: Fijo/Móvil; Rural/Urbano.

### m_proveedor_numeracion / m_comercializador
Proveedores y comercializadores de numeración.

### m_estado_rango / m_estado_proceso
Estados del rango (Habilitado/No habilitado) y del proceso batch (Pendiente, Procesando, Completado, Error).

### m_plan_telefonia
Planes de telefonía con tarifa y saldo inicial.

### m_eventos / m_tipo_evento
Catálogo de eventos de trazabilidad. `m_eventos.tipo_evento` es ENUM('FORMULARIO','API','JOB','OTRO').

---

## Tablas transaccionales (`t_*`)

### t_usuarios
Usuarios del sistema (tabla principal, no existe `m_usuarios`).

| Columna | Tipo | Restricción |
|---------|------|-------------|
| id_usuario | INT | PK, AUTO_INCREMENT |
| desc_nombres | VARCHAR(255) | NOT NULL |
| desc_apellidos | VARCHAR(255) | NOT NULL |
| desc_usuario | VARCHAR(150) | NOT NULL, UNIQUE |
| desc_email | VARCHAR(150) | NOT NULL, UNIQUE |
| desc_password | VARCHAR(150) | NULL |
| desc_tipo_login | VARCHAR(50) | DEFAULT 'AD' |
| id_estado_usuario | TINYINT | FK → m_estado_usuario |
| id_acceso_usuario | TINYINT | FK → m_acceso_usuario |
| flg_activo | BIT | DEFAULT 1 |

### t_usuario_rol
Asignación usuario ↔ rol (N:N).

| Columna | Tipo | Restricción |
|---------|------|-------------|
| id_usuario_rol | INT | PK |
| id_rol | INT | FK → m_roles |
| id_usuario | INT | FK → t_usuarios |

### t_rango_numeracion
Rangos de numeración generados.

| Columna | Tipo | Restricción |
|---------|------|-------------|
| id_rango | BIGINT | PK |
| id_tipo_servicio | INT | FK → m_tipo_servicio |
| id_departamento | INT | FK → m_departamento |
| id_tipo_zona | INT | FK → m_tipo_zona |
| id_proveedor_numeracion | INT | FK → m_proveedor_numeracion |
| id_comercializador | INT | FK → m_comercializador |
| cant_numeros_generados | INT | NOT NULL |
| num_rango_inicial / num_rango_final | BIGINT | NOT NULL |
| fec_creacion_rango | DATETIME | NOT NULL |
| id_estado_rango | INT | FK → m_estado_rango |
| id_estado_proceso | INT | FK → m_estado_proceso, DEFAULT 1 |
| cant_total_generados / cant_total_error | INT | DEFAULT 0 |
| fec_inicio_proceso / fec_fin_proceso | DATETIME | NULL |
| id_usuario_creacion / id_usuario_modificacion | INT | FK → t_usuarios |

### t_numero_telefonico
Números telefónicos individuales.

| Columna | Tipo | Restricción |
|---------|------|-------------|
| id_numero_telefonico | BIGINT | PK |
| id_rango | BIGINT | FK → t_rango_numeracion |
| desc_numero_telefono | VARCHAR(20) | NOT NULL, UNIQUE |
| facil_recordacion | TINYINT(1) | DEFAULT 0 |
| cod_pedido | VARCHAR(100) | NULL |
| id_suscriptor / id_cliente_freeswitch | VARCHAR(100) | NULL |
| id_tipo_doc | SMALLINT | FK → m_tipo_documento |
| desc_numero_documento | VARCHAR(30) | NULL |
| id_operador_cedente / id_operador_receptor | SMALLINT | FK → m_operador |
| fec_activacion / fec_port_in / fec_port_out / fec_baja | DATETIME | NULL |
| num_dias_reserva | INT | NULL |
| id_motivo_cambio | SMALLINT | FK → m_motivo_cambio |
| id_estado_numero | SMALLINT | FK → m_estado_numero |
| id_plan_telefonia | SMALLINT | FK → m_plan_telefonia |
| id_usuario_creacion / id_usuario_modificacion | INT | NOT NULL |

### t_portabilidad_numero
Solicitudes de portabilidad numérica.

| Columna | Tipo | Restricción |
|---------|------|-------------|
| id_portabilidad_numero | BIGINT | PK — Id Solicitud |
| id_tipo_doc | SMALLINT | FK → m_tipo_documento |
| id_operador_cedente / id_operador_receptor | SMALLINT | FK → m_operador |
| id_estado_portabilidad | SMALLINT | FK → m_estado_portabilidad |
| id_motivo_rechazo | SMALLINT | FK → m_motivo_rechazo, NULL |
| id_cliente_freeswitch | VARCHAR(100) | NULL |
| desc_numero_documento | VARCHAR(30) | NOT NULL |
| desc_numero_telefonico | VARCHAR(20) | NOT NULL |
| fec_programacion_portabilidad | DATETIME | NOT NULL |
| fec_ejecucion_portabilidad | DATETIME | NULL |

### t_historial_numero
Historial de cambios de estado de un número (sin columnas de auditoría estándar).

| Columna | Tipo | Restricción |
|---------|------|-------------|
| id_historial | BIGINT | PK |
| id_numero_telefonico | BIGINT | FK → t_numero_telefonico |
| estado_anterior / estado_nuevo | INT | NULL |
| motivo | VARCHAR(255) | NULL |
| usuario | VARCHAR(100) | NULL |
| fecha | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

### t_numero_adjunto
Archivos adjuntos de número telefónico.

| Columna | Tipo | Restricción |
|---------|------|-------------|
| id_adjunto | BIGINT | PK |
| id_numero_telefonico | BIGINT | FK → t_numero_telefonico |
| desc_nombre_archivo / desc_ruta_archivo | VARCHAR | NULL |
| id_usuario_creacion | INT | NOT NULL |

### t_trazabilidad_eventos
Registro de eventos del sistema (sin auditoría estándar).

| Columna | Tipo | Restricción |
|---------|------|-------------|
| id_trazabilidad | BIGINT | PK |
| id_evento | INT | FK → m_eventos |
| id_usuario | INT | FK → t_usuarios |
| id_menu | INT | FK → m_menus |
| detalle | TEXT | NULL |
| fec_registro | DATETIME | DEFAULT CURRENT_TIMESTAMP |
| ip_origen | VARCHAR(45) | NULL |
| creado_por_api | BOOLEAN | DEFAULT FALSE |

### t_auditoria
Auditoría de acciones ligada a eventos.

| Columna | Tipo | Restricción |
|---------|------|-------------|
| id_auditoria | BIGINT | PK |
| id_evento | INT | FK → m_eventos |
| desc_modulo / desc_accion | VARCHAR | NOT NULL |
| desc_detalle_accion | TEXT | NOT NULL |
| usuario_accion | VARCHAR(100) | NULL |

---

## Tablas auxiliares

### app_security_settings / app_user_sessions
Tablas de soporte de la aplicación (MyISAM). Gestión de sesiones y configuración de seguridad.

---

## Índices definidos en schema

```sql
-- t_numero_telefonico
ix_t_numero_telefonico_id_estado_numero
ix_t_numero_telefonico_id_rango
ix_t_numero_telefonico_id_tipo_doc
ix_t_numero_telefonico_id_operador_cedente
ix_t_numero_telefonico_id_operador_receptor
ix_t_numero_telefonico_id_motivo_cambio
ix_t_numero_telefonico_desc_numero_telefono  -- UNIQUE

-- t_rango_numeracion
ix_t_rango_numeracion_num_rango_inicial_num_rango_final
ix_t_rango_numeracion_id_tipo_servicio
ix_t_rango_numeracion_id_departamento
ix_t_rango_numeracion_id_tipo_zona
ix_t_rango_numeracion_id_proveedor_numeracion
ix_t_rango_numeracion_id_comercializador
ix_t_rango_numeracion_id_estado_rango
ix_t_rango_numeracion_id_tipo_servicio_departamento_tipo_zona

-- t_portabilidad_numero (búsqueda)
ix_t_portabilidad_numero_fec_programacion_portabilidad
ix_t_portabilidad_numero_id_estado_portabilidad
ix_t_portabilidad_numero_id_operador_cedente

-- Otros
ix_t_historial_numero_id_numero_telefonico
ix_t_numero_adjunto_id_numero_telefonico
ix_t_trazabilidad_eventos_id_evento
ix_t_trazabilidad_eventos_id_usuario
ix_t_trazabilidad_eventos_fec_registro
```

---

## Relaciones principales (FK)

```
t_usuarios.id_estado_usuario        → m_estado_usuario
t_usuarios.id_acceso_usuario        → m_acceso_usuario
t_usuario_rol                       → m_roles, t_usuarios
t_rango_numeracion                  → m_tipo_servicio, m_departamento, m_tipo_zona,
                                      m_proveedor_numeracion, m_comercializador,
                                      m_estado_rango, m_estado_proceso, t_usuarios
t_numero_telefonico                 → t_rango_numeracion, m_estado_numero,
                                      m_plan_telefonia, m_tipo_documento, m_operador,
                                      m_motivo_cambio
t_portabilidad_numero               → m_tipo_documento, m_operador,
                                      m_estado_portabilidad, m_motivo_rechazo
t_trazabilidad_eventos              → m_eventos, t_usuarios, m_menus
m_opciones.id_menu                  → m_menus
m_roles_permisos                    → m_roles, m_permisos
m_menus_permisos                    → m_menus, m_permisos
```

---

## Notas de diseño

- No existe tabla `m_usuarios`; los usuarios viven en `t_usuarios`.
- El schema actual usa `flg_activo` en catálogos `m_*` en lugar de `id_estado` → `m_estados`.
- Algunos SP (`spl_m_estados_combo_listar`, `spl_tipo_estado`) referencian `m_estados`/`m_tipo_estado`, tablas no incluidas en `schema_erflow.sql`.
- `t_historial_numero`, `t_trazabilidad_eventos` y `t_numero_adjunto` no siguen el bloque completo de auditoría estándar.
