# Stored Procedures

Documentación alineada a `objects/sp/*.sql` (26 procedimientos).

## Nomenclatura

| Prefijo | Uso previsto | Uso actual |
|---------|--------------|------------|
| `spl_` | SELECT / listados | Mayoría de procedimientos, incluyendo algunos INSERT/UPDATE |
| `spi_` | INSERT | `spi_trazabilidad` |
| `spu_` | UPDATE | *(ninguno implementado)* |
| `spd_` | DELETE | *(ninguno implementado)* |
| `sps_` | Consultas puntuales | Autenticación y búsqueda por username |

**Deploy**: Concatenar los archivos individuales y ejecutar objects/sp/deploy_sp.sql.
```bash
cd objects/sp
cat *.sql > deploy_sp.sql
mysql -u root -p win_sgn_db < objects/sp/deploy_sp.sql
```
---

## Resumen por módulo

| Módulo | Cantidad | Procedimientos |
|--------|:--------:|----------------|
| Usuarios | 8 | `spl_t_usuarios_listar`, `spi_t_usuarios_crear`, `spl_t_usuarios_crear_admin`, `spl_t_usuarios_actualizar_admin`, `spl_t_usuarios_principal_listar`, `sps_t_usuarios_autenticacion`, `sps_t_usuarios_by_username`, `spl_usuario_permisos_listar` |
| Roles y menús | 5 | `spl_m_roles_listar`, `spl_m_roles_combo_listar`, `spl_m_roles_admin_combo_listar`, `spl_m_roles_menus_listar`, `spl_modulos` |
| Trazabilidad | 2 | `spi_trazabilidad`, `spl_trazabilidad` |
| Catálogos | 10 | `spl_departamento`, `spl_comercializador`, `spl_proveedor_numeracion`, `spl_tipo_servicio`, `spl_tipo_zona`, `spl_estado_rango`, `spl_estado_usuario`, `spl_acceso_usuario`, `spl_detalle_template`, `spl_m_estados_combo_listar`, `spl_tipo_estado` |

---

## Usuarios

### spl_t_usuarios_listar
Lista usuarios con filtros, respetando jerarquía de roles del usuario logueado.

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| p_desc_usuario | VARCHAR(150) | Filtro por username |
| p_id_rol | INT | Filtro por rol |
| p_id_estado | TINYINT | Filtro por estado usuario |
| p_id_acceso | TINYINT | Filtro por acceso |
| p_id_usuario_logueado | INT | Usuario que consulta |

**Retorna**: id_usuario, desc_usuario, desc_nombres, desc_apellidos, desc_email, desc_tipo_login, id_estado_usuario, id_acceso_usuario, desc_estado, desc_acceso, id_rol, roles

**Archivo**: `objects/sp/spl_t_usuarios_listar.sql`

---

### spi_t_usuarios_crear
Crea usuario (solo datos de negocio; auditoría por defaults de tabla).

| Parámetro | Tipo |
|-----------|------|
| p_desc_usuario | VARCHAR(150) |
| p_desc_nombres / p_desc_apellidos | VARCHAR(255) |
| p_desc_email | VARCHAR(150) |
| p_password | VARCHAR(150) |
| p_desc_tipo_login | VARCHAR(150) |
| p_id_estado | TINYINT |

**Retorna**: id_usuario

**Archivo**: `objects/sp/spi_t_usuarios_crear.sql`

---

### spl_t_usuarios_crear_admin
Crea usuario y asigna rol en transacción.

| Parámetro | Tipo |
|-----------|------|
| p_desc_usuario, p_desc_nombres, p_desc_apellidos, p_desc_email | VARCHAR |
| p_desc_password | VARCHAR(255) |
| p_desc_tipo_login | VARCHAR(50) |
| p_id_estado_usuario, p_id_acceso_usuario, p_id_rol | INT |

**Retorna**: id_usuario, mensaje

**Archivo**: `objects/sp/spl_t_usuarios_crear_admin.sql`

---

### spl_t_usuarios_actualizar_admin
Actualiza usuario y rol en transacción.

| Parámetro | Tipo |
|-----------|------|
| p_id_usuario | INT |
| p_desc_usuario, p_desc_nombres, p_desc_apellidos, p_desc_email | VARCHAR(255) |
| p_id_estado_usuario, p_id_acceso_usuario, p_id_rol | INT |

**Retorna**: id_usuario, mensaje

**Archivo**: `objects/sp/spl_t_usuarios_actualizar_admin.sql`

---

### spl_t_usuarios_principal_listar
Obtiene usuario principal por email con conteo de roles activos.

| Parámetro | Tipo |
|-----------|------|
| p_desc_email | VARCHAR(150) |

**Retorna**: id_usuario, desc_email, id_estado_usuario, id_acceso_usuario, cant_roles

**Archivo**: `objects/sp/spl_t_usuarios_principal_listar.sql`

---

### sps_t_usuarios_autenticacion
Credenciales y estado para login por email.

| Parámetro | Tipo |
|-----------|------|
| p_desc_email | VARCHAR(150) |

**Retorna**: desc_usuario, desc_nombres, desc_apellidos, desc_email, desc_password, id_estado_usuario, id_acceso_usuario, flg_activo

**Archivo**: `objects/sp/sps_t_usuarios_autenticacion.sql`

---

### sps_t_usuarios_by_username
Busca usuario activo por username.

| Parámetro | Tipo |
|-----------|------|
| p_desc_username | VARCHAR(150) |

**Retorna**: id_usuario, desc_usuario, desc_email, id_estado_usuario, id_acceso_usuario

**Archivo**: `objects/sp/sps_t_usuarios_by_username.sql`

---

### spl_usuario_permisos_listar
Lista permisos activos de un rol.

| Parámetro | Tipo | Nota |
|-----------|------|------|
| p_id_rol | INT | Recibe id de rol, no id de usuario |

**Retorna**: cod_permiso, desc_accion, desc_permiso

**Archivo**: `objects/sp/spl_usuario_permisos_listar.sql`

---

## Roles y menús

### spl_m_roles_listar
Roles activos asignados a un usuario.

| Parámetro | p_id_usuario INT |

**Retorna**: id_rol, cod_rol, desc_rol

---

### spl_m_roles_combo_listar / spl_m_roles_admin_combo_listar
Listados para combos. Admin combo limita a roles id 1 y 2.

**Retorna**: id_rol, cod_rol, desc_rol

---

### spl_m_roles_menus_listar
Menús asignados a un rol.

| Parámetro | p_id_rol INT |

**Retorna**: cod_menu, cod_sub_menu, desc_menu, desc_ruta

---

### spl_modulos
Menús de primer nivel (sin padre).

| Parámetro | p_cod_menu INT (opcional) |

**Retorna**: id_menu, cod_menu, desc_menu, fec_creacion, fec_modf, desc_usuario_crea, desc_usuario_modf

---

## Trazabilidad

### spi_trazabilidad
Inserta evento de trazabilidad.

| Parámetro | Tipo |
|-----------|------|
| p_id_usuario | INT |
| p_id_menu | INT |
| p_id_evento | INT |
| p_detalle | TEXT |
| p_ip_origen | VARCHAR(45) |
| p_creado_por_api | TINYINT(1) |

**Retorna**: sin result set

**Archivo**: `objects/sp/spi_trazabilidad.sql`

---

### spl_trazabilidad
Lista eventos con filtros opcionales.

| Parámetro | Tipo |
|-----------|------|
| p_fecha_desde / p_fecha_hasta | DATETIME |
| p_id_modulo | INT |
| p_usuario | VARCHAR(200) |

**Retorna**: id_trazabilidad, evento, detalle, fec_registro, ip_origen, creado_por_api, id_usuario, desc_nombres, desc_apellidos, usuario_completo, submodulo, modulo_principal

**Archivo**: `objects/sp/spl_trazabilidad.sql`

---

## Catálogos

| Procedimiento | Parámetros | Retorna |
|---------------|------------|---------|
| `spl_departamento` | — | id_departamento, desc_departamento, cod_ubigeo_departamento, cod_tel_departamento, cobertura_departamento |
| `spl_comercializador` | — | id_comercializador, desc_comercializador |
| `spl_proveedor_numeracion` | — | id_proveedor_numeracion, desc_proveedor_numeracion |
| `spl_tipo_servicio` | — | id_tipo_servicio, desc_tipo_servicio |
| `spl_tipo_zona` | — | id_tipo_zona, desc_tipo_zona |
| `spl_estado_rango` | — | id_estado_rango, desc_estado_rango |
| `spl_estado_usuario` | — | id_estado_usuario, desc_estado |
| `spl_acceso_usuario` | — | id_acceso_usuario, desc_acceso |
| `spl_detalle_template` | p_id_evento INT | detalle_template |
| `spl_m_estados_combo_listar` | p_cod_tipo_estado VARCHAR(12) | flg_activo, cod_estado, desc_estado, id_tipo_estado, cod_tipo_estado, desc_tipo_estado |
| `spl_tipo_estado` | p_id_estado INT | flg_activo, desc_estado |

> **Nota**: `spl_m_estados_combo_listar` y `spl_tipo_estado` referencian `m_estados`/`m_tipo_estado`, tablas no presentes en el schema actual.

---

## Ejemplo de uso (Laravel)

```php
// Listar usuarios
$users = DB::select('CALL spl_t_usuarios_listar(?, ?, ?, ?, ?)', [
    $username, $idRol, $idEstado, $idAcceso, $idUsuarioLogueado
]);

// Registrar trazabilidad
DB::statement('CALL spi_trazabilidad(?, ?, ?, ?, ?, ?)', [
    $userId, $menuId, $eventoId, $detalle, $ip, $creadoPorApi
]);

// Catálogo departamentos
$departamentos = DB::select('CALL spl_departamento()');
```

---

## Notas

- Todos los parámetros son `IN`; no hay parámetros `OUT`.
- Validar permisos en Backend antes de invocar SP.
- Backend es el único consumidor autorizado (no acceso directo desde Frontend).
- Documentar aquí cualquier SP nuevo que se agregue a `objects/sp/`.
