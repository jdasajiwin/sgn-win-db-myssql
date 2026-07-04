# Especificaciones y Estándares de BD

Este documento describe el **estándar objetivo** (`Estándares de base de datos v 2.0 2.pdf`) y las **diferencias del schema actual** (`schema/schema_erflow.sql`).

Ubicación en el compartido de los scripts para la generación de la data:  
```
\\10.24.100.13\DEV_Upload\WINET-PRY-2026-0002 IMPLEMENTACIÓN DEL SISTEMA DE GESTIÓN DE NÚMEROS (SGN)\BD\SGN
```

---

## Nomenclatura

### Tablas

| Tipo | Prefijo | Ejemplo |
|------|---------|---------|
| Maestro | `m_` | `m_operador` |
| Transaccional | `t_` | `t_numero_telefonico` |

### Columnas

| Tipo | Prefijo | Ejemplo en schema |
|------|---------|-------------------|
| PK | `id_` | `id_usuario` |
| FK | `id_<entidad>` | `id_operador_cedente` (estándar objetivo: también acepta `fk_`) |
| Descripción | `desc_` | `desc_numero_telefono` |
| Fecha | `fec_` | `fec_programacion_portabilidad` |
| Cantidad | `cant_` | `cant_numeros_generados` |
| Número | `num_` | `num_rango_inicial` |
| Código externo | `cod_` | `cod_permiso`, `cod_menu` (permitidos como identificadores de negocio) |
| Bandera | `flg_` | `flg_activo` |

### Stored Procedures

| Prefijo | Uso |
|---------|-----|
| `spl_` | Lectura / listados |
| `spi_` | Inserción |
| `spu_` | Actualización |
| `spd_` | Eliminación |
| `sps_` | Procedimientos especiales |

---

## Estándar objetivo vs schema actual

| Regla (prompt.txt) | Schema actual |
|--------------------|---------------|
| `id_estado` FK → `m_estados` en toda `t_*` | No implementado; se usa `flg_activo` en `m_*` y catálogos específicos (`id_estado_usuario`, `id_estado_numero`, etc.) |
| Tabla `m_estados` obligatoria | No está en `schema_erflow.sql` (algunos SP legacy la referencian) |
| Solo `m_estados` usa `flg_activo` | Varios `m_*` y `t_usuarios` usan `flg_activo` |
| FK columnas con prefijo `fk_` | Columnas nombradas `id_<entidad>` |
| Sin `nom_app*` en auditoría | `t_rango_numeracion` tiene `nom_app`, `nom_app_modf` (legacy) |

Al crear tablas nuevas, preferir el estándar objetivo cuando no entre en conflicto con tablas existentes.

---

## Integridad referencial

### Convención de constraints

```
fk_<tabla_referenciada>_<tabla_origen>
FOREIGN KEY (id_...) REFERENCES <tabla>(id_...)
ON DELETE RESTRICT
ON UPDATE CASCADE
```

**Ejemplo real**:
```sql
CONSTRAINT fk_m_operador_t_portabilidad_numero_cedente
  FOREIGN KEY (id_operador_cedente) REFERENCES m_operador(id_operador)
  ON DELETE RESTRICT ON UPDATE CASCADE
```

---

## Auditoría

### Columnas estándar (obligatorias en `m_*` y `t_*` nuevas)

```sql
desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT (CURRENT_USER()),
desc_usuario_modf VARCHAR(50) NOT NULL DEFAULT (CURRENT_USER()),
fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
fec_modf DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
```

### No permitido en auditoría

- `desc_host_*`, `nom_app*`, columnas de terminal/aplicación duplicadas

---

## Orden de columnas

1. PK (`id_*`)
2. FK (excepto `id_estado` genérico)
3. Campos funcionales (`desc_*`, `fec_*`, `num_*`, etc.)
4. `id_estado` (si aplica al estándar objetivo)
5. Auditoría

---

## Seed (`data/seed_erflow.sql`)

1. **Idempotente**: usar `ON DUPLICATE KEY UPDATE` donde corresponda
2. **Orden**: respetar dependencias FK (catálogos → roles/menús → usuarios → relaciones)
3. **Auditoría**: incluir columnas de auditoría en inserts de `t_*`
4. **Transacción**: el seed usa `START TRANSACTION` / `COMMIT`

---

## Sincronización obligatoria de cambios

Todo cambio de modelo debe reflejarse en:

- `schema/schema_erflow.sql`
- `data/seed_erflow.sql` (si aplica)
- Documentación en `docs/03-DICCIONARIO-DATOS.md`

---

## Índices

Crear índices en columnas de búsqueda frecuente. Convención: `ix_<tabla>_<columna(s)>`.

**Índices actuales relevantes**:
- `t_numero_telefonico`: estado, rango, operadores, tipo doc
- `t_rango_numeracion`: servicio, departamento, zona, proveedor, comercializador, rango numérico
- `t_portabilidad_numero`: fec_programacion_portabilidad, id_estado_portabilidad, id_operador_cedente

---

## Validación antes de desplegar

```bash
mysql -u root -p win_sgn_db < schema/schema_erflow.sql
mysql -u root -p win_sgn_db < data/seed_erflow.sql
mysql -u root -p win_sgn_db < objects/sp/deploy.sql

mysql -u root -p win_sgn_db -e "CALL spl_m_roles_listar(1);"
mysql -u root -p win_sgn_db -e "CALL spl_departamento();"
```

**Checklist de cambios**:
- [ ] Actualizar `schema/schema_erflow.sql`
- [ ] Actualizar seed si hay datos de catálogo
- [ ] Crear/actualizar SP en `objects/sp/`
- [ ] Actualizar `docs/03-DICCIONARIO-DATOS.md`
- [ ] Actualizar `docs/04-STORED-PROCEDURES.md`
- [ ] Coordinar migration en Backend Laravel

---

## Referencias

- Estándar interno: `Estándares de base de datos v 2.0 2`
- Schema: `schema/schema_erflow.sql`
- Seed: `data/seed_erflow.sql`
- SP: `objects/sp/*sql`
