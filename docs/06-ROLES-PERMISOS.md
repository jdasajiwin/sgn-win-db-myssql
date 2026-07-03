# Matriz de Roles y Permisos

Alineado a `data/seed_erflow.sql` y `DB-002-ESPECIFICACIONES-ROLES-PERMISOS.md`.

## Roles del sistema

| id_rol | cod_rol | desc_rol | Nivel |
|:------:|---------|----------|:-----:|
| 1 | SUPERADMIN | SuperAdmin | 10 |
| 2 | ADMINTI | Admin TI | 20 |
| 3 | GESTORDETE | Gestor de telefonía | 30 |
| 4 | SUPERVISOR | Supervisor NOC | 40 |
| 5 | OPERADORN | Operador NOC | 50 |

---

## Leyenda de acceso

- ✅ Permitido (permiso en seed)
- ❌ No asignado en seed

---

## Usuarios / Gestión de usuario

| Acción | SuperAdmin | Admin TI | Gestor Telefonía | Supervisor NOC | Operador NOC |
|--------|:----------:|:--------:|:----------------:|:--------------:|:------------:|
| Agregar | ✅ | ✅ | ❌ | ❌ | ❌ |
| Consultar | ✅ | ✅ | ✅ | ❌ | ❌ |
| Editar | ✅ | ✅ | ❌ | ❌ | ❌ |
| Exportar | ✅ | ✅ | ✅ | ❌ | ❌ |

**Permisos**: `usuario.agregar`, `usuario.consultar`, `usuario.editar`, `usuario.exportar`, `usuario.todas`

**Menú**: id_menu = 2 (Gestión de usuario)

**SP**: `spl_t_usuarios_listar`, `spl_t_usuarios_crear_admin`, `spl_t_usuarios_actualizar_admin`

---

## Usuarios / Trazabilidad de evento

| Acción | SuperAdmin | Admin TI | Gestor Telefonía | Supervisor NOC | Operador NOC |
|--------|:----------:|:--------:|:----------------:|:--------------:|:------------:|
| Consultar | ✅ | ✅ | ✅ | ✅ | ❌ |
| Exportar | ✅ | ✅ | ✅ | ✅ | ❌ |

**Permisos**: `trazabilidad.consultar`, `trazabilidad.exportar`, `trazabilidad.todas`

**Menú**: id_menu = 3

**SP**: `spl_trazabilidad`, `spi_trazabilidad`

---

## Rangos de numeración

| Acción | SuperAdmin | Admin TI | Gestor Telefonía | Supervisor NOC | Operador NOC |
|--------|:----------:|:--------:|:----------------:|:--------------:|:------------:|
| Consultar | ✅ | ❌ | ✅ | ❌ | ❌ |
| Agregar | ✅ | ❌ | ✅ | ❌ | ❌ |
| Habilitar | ✅ | ❌ | ✅ | ❌ | ❌ |
| Exportar | ✅ | ❌ | ✅ | ❌ | ❌ |

**Permisos**: `rango_numeracion.consultar`, `rango_numeracion.agregar`, `rango_numeracion.habilitar`, `rango_numeracion.exportar`, `rango_numeracion.todas`

**Menú**: id_menu = 4

**SP**: `spl_estado_rango` (catálogo de estados)

---

## Números telefónicos

| Acción | SuperAdmin | Admin TI | Gestor Telefonía | Supervisor NOC | Operador NOC |
|--------|:----------:|:--------:|:----------------:|:--------------:|:------------:|
| Consultar | ✅ | ❌ | ✅ | ✅ | ✅ |
| Editar | ✅ | ❌ | ✅ | ✅ | ❌ |
| Editar estados especiales | ✅ | ❌ | ❌ | ❌ | ✅ |
| Exportar | ✅ | ❌ | ✅ | ✅ | ❌ |

**Estados editables por Operador NOC** (permiso `numero_telefonico.editar_estados_especiales`): Disponible, Bloqueado, Bloqueado port in, Pendiente portabilidad, Pre-reserva

**Permisos**: `numero_telefonico.consultar`, `numero_telefonico.editar`, `numero_telefonico.editar_estados_especiales`, `numero_telefonico.exportar`

**Menú**: id_menu = 5

---

## Contingencia de activación Freeswitch

| Acción | SuperAdmin | Admin TI | Gestor Telefonía | Supervisor NOC | Operador NOC |
|--------|:----------:|:--------:|:----------------:|:--------------:|:------------:|
| Consultar | ✅ | ❌ | ❌ | ✅ | ✅ |
| Activar | ✅ | ❌ | ❌ | ✅ | ✅ |

**Permisos**: `contingencia_freeswitch.consultar`, `contingencia_freeswitch.activar`

**Menús**: id_menu 7 (Contingencia), 8 (Números WI NET), 9 (Números Portados)

---

## Gestión de Portabilidad

| Acción | SuperAdmin | Admin TI | Gestor Telefonía | Supervisor NOC | Operador NOC |
|--------|:----------:|:--------:|:----------------:|:--------------:|:------------:|
| Consultar | ✅ | ❌ | ✅ | ✅ | ✅ |
| Editar | ✅ | ❌ | ✅ | ✅ | ✅ |
| Exportar | ✅ | ❌ | ✅ | ✅ | ✅ |
| Descargar plantilla | ✅ | ❌ | ✅ | ❌ | ❌ |
| Importar plantilla | ✅ | ❌ | ✅ | ❌ | ❌ |

**Permisos**: `portabilidad.consultar`, `portabilidad.editar`, `portabilidad.exportar`, `portabilidad.descargar_plantilla`, `portabilidad.importar_plantilla`

**Menú**: id_menu = 6

**Tabla**: `t_portabilidad_numero`

---

## Mantenimientos

| Acción | SuperAdmin | Gestor Telefonía |
|--------|:----------:|:----------------:|
| Parámetros SGN | ✅ | ✅ |
| Parámetros Freeswitch | ✅ | ✅ |
| Proveedores numeración | ✅ | ✅ |
| Comercializadores | ✅ | ✅ |
| Operadores | ✅ | ✅ |
| Motivo cambio estado | ✅ | ✅ |
| Departamento | ✅ | ✅ |
| Estados del número | ✅ | ✅ |

**Permisos**: `mantenimiento.parametros_sgn`, `mantenimiento.parametros_freeswitch`, `mantenimiento.proveedores`, `mantenimiento.comercializadores`, `mantenimiento.operadores`, `mantenimiento.motivo_cambio_estado`, `mantenimiento.departamento`, `mantenimiento.estado_numero`

**Menú**: id_menu = 10

---

## Estructura de tablas (schema real)

### m_permisos

```sql
CREATE TABLE m_permisos (
  id_permiso INT PRIMARY KEY AUTO_INCREMENT,
  cod_permiso VARCHAR(50) NOT NULL UNIQUE,
  desc_modulo VARCHAR(100) NOT NULL,
  desc_submodulo VARCHAR(100) NULL,
  desc_accion VARCHAR(100) NOT NULL,
  desc_permiso VARCHAR(255) NULL,
  desc_usuario_crea VARCHAR(50) NOT NULL,
  desc_usuario_modf VARCHAR(50) NOT NULL,
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  flg_activo BIT NOT NULL DEFAULT 1
);
```

### m_roles_permisos

```sql
CREATE TABLE m_roles_permisos (
  id_rol_permiso INT PRIMARY KEY AUTO_INCREMENT,
  id_rol INT NOT NULL,
  id_permiso INT NOT NULL,
  UNIQUE KEY uq_m_roles_permisos_rol_permiso (id_rol, id_permiso),
  CONSTRAINT fk_m_roles_m_roles_permisos FOREIGN KEY (id_rol) REFERENCES m_roles(id_rol),
  CONSTRAINT fk_m_permisos_m_roles_permisos FOREIGN KEY (id_permiso) REFERENCES m_permisos(id_permiso)
);
```

### m_menus_permisos

Relaciona menús con los permisos requeridos para acceder.

---

## Asignación de permisos en seed

| Rol | Alcance |
|-----|---------|
| SuperAdmin (1) | Todos los permisos activos |
| Admin TI (2) | Usuarios y trazabilidad |
| Gestor telefonía (3) | Rangos, números, portabilidad, mantenimientos, consulta usuarios |
| Supervisor NOC (4) | Trazabilidad, números, contingencia, portabilidad (sin plantillas) |
| Operador NOC (5) | Números (consulta + estados especiales), contingencia, portabilidad |

---

## Validación en Backend

```php
// Obtener permisos del rol del usuario
$permisos = $this->call('spl_usuario_permisos_listar', [$idRol]);

// Los permisos se evalúan en el frontend
```

> **Nota**: `spl_usuario_permisos_listar` recibe `p_id_rol`. El Backend debe resolver el rol del usuario autenticado antes de invocarlo.

---

## Menús por rol (seed)

| Rol | Menús asignados (resumen) |
|-----|---------------------------|
| SuperAdmin | Todos (1–21) |
| Admin TI | Usuarios (1, 2, 3) |
| Gestor telefonía | Usuarios, rangos, números, portabilidad, mantenimientos |
| Supervisor NOC | Usuarios, números, portabilidad, contingencia |
| Operador NOC | Números, portabilidad, contingencia |

---

## Notas

- Los permisos se validan en cada request del Backend.
- Admin TI no tiene acceso a gestión de números ni portabilidad.
- Operador NOC tiene edición limitada de estados de número.
- Cualquier cambio en la matriz requiere actualizar `data/seed_erflow.sql` y este documento.
