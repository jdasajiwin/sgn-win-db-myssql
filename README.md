# 🗄️ Base de Datos - Sistema de Gestión de Numeración (SGN)

Base de datos MySQL con arquitectura robusta, trazabilidad completa y Stored Procedures para acceso desde Backend.

> 📚 **[Ver documentación completa](./docs/00-INDICE.md)** | 📊 **[Diccionario de datos](./docs/03-DICCIONARIO-DATOS.md)** | 🔧 **[Stored Procedures](./docs/04-STORED-PROCEDURES.md)** | 🔐 **[Roles y Permisos](./docs/06-ROLES-PERMISOS.md)**

## 🎯 Características principales

- ✅ Arquitectura por capas (maestros, transaccionales)
- ✅ Auditoría completa en todas las tablas (usuario_crea, usuario_modf, fec_*)
- ✅ Sistema de roles y permisos granular
- ✅ 26 Stored Procedures para operaciones
- ✅ Integridad referencial con Foreign Keys
- ✅ Índices optimizados para búsquedas
- ✅ Compatibilidad MySQL 8.0+

## 📋 Estructura de tablas

### Maestros (m_*)
Catálogos base del sistema: roles, departamentos, operadores, estados, menús, permisos, etc.

### Transaccionales (t_*)
Datos operacionales: usuarios, rangos de numeración, números telefónicos, portabilidad, trazabilidad.


## 🚀 Instalación rápida

### 1. Crear base de datos
```bash
mysql -u root -p
> CREATE DATABASE win_sgn_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
> EXIT;
```

### 2. Cargar schema
```bash
mysql -u root -p win_sgn_db < schema/schema_erflow.sql
```

### 3. Cargar datos de prueba
```bash
mysql -u root -p win_sgn_db < data/seed_erflow.sql
```

### 4. Cargar Stored Procedures
```bash
cd objects/sp
cat *.sql > deploy_sp.sql
mysql -u root -p win_sgn_db < objects/sp/deploy_sp.sql
```

### 5. Verificar instalación
```bash
mysql -u root -p win_sgn_db
> CALL spl_m_roles_listar();  -- Debe retornar roles
> CALL spl_departamento();    -- Debe retornar departamentos
```

## Diagrama E-R principal

```
m_roles ──→ m_roles_permisos ──→ m_permisos
   │
   └──→ t_usuario_rol ←── t_usuarios
              │
              └──→ t_trazabilidad_eventos ←── m_eventos

t_rango_numeracion ──→ t_numero_telefonico
        │                      │
        ├── m_comercializador  ├── m_estado_numero
        └── m_departamento     └── t_historial_numero

t_portabilidad_numero ──→ m_estado_portabilidad
                          m_operador / m_motivo_rechazo
```

## 🔐 Seguridad

- **Acceso**: Solo via Stored Procedures desde Backend (Laravel)
- **Roles**: 5 niveles (SuperAdmin, Admin TI, Gestor Telefonía, Supervisor NOC, Operador NOC)
- **Permisos**: Granulares por módulo/acción
- **Auditoría**: Trazabilidad de cambios automática

## 📈 Tablas principales

| Tabla | Registros (aprox.) | Descripción |
|-------|:------------------:|-------------|
| t_usuarios | 10-20 | Usuarios del sistema |
| m_roles | 5 | Roles (SuperAdmin, Admin TI, etc.) |
| t_rango_numeracion | 10-50 | Rangos de números disponibles |
| t_numero_telefonico | 1M-10M+ | Números individuales |
| t_trazabilidad_eventos | Ilimitado | Registro de cambios |
| m_departamento | 20-50 | Departamentos org. |
| m_comercializador | 10-20 | Comercializadores |

## 🔧 Stored Procedures (muestra)

| Categoría | Cantidad | Ejemplos |
|-----------|:--------:|----------|
| Usuarios | 8 | spl_t_usuarios_listar, spl_t_usuarios_crear_admin, etc. |
| Roles/Menús | 5 | spl_m_roles_listar, spl_m_roles_menus_listar |
| Trazabilidad | 2 | spi_trazabilidad, spl_trazabilidad |
| Catálogos | 10 | spl_departamento, spl_comercializador, spl_estado_rango, etc. |
| Autenticación | 2 | sps_t_usuarios_autenticacion, sps_t_usuarios_by_username |

> Ver [Stored Procedures completo](./docs/04-STORED-PROCEDURES.md)

## 💾 Conexión desde Backend

### Laravel (PHP)
```php
// Ejecutar SP que retorna datos
$rows = $this->call('spl_proveedor_numeracion');

// Ejecutar SP con parámetros
$rows = $this->call('spl_t_usuarios_listar', [$username, $idRol, $idEstado, $idAcceso, $idUsuarioLogueado]);

// Registrar trazabilidad
$this->call(
    'spi_trazabilidad',
    [
        $data['id_usuario'],
        $data['id_menu'],
        $data['id_evento'],
        $data['detalle'] ?? null,
        $data['ip_origen'] ?? null,
        $data['creado_por_api'] ?? 0,
    ]
);
```

## 📚 Documentación

- **[Diccionario de datos](./docs/03-DICCIONARIO-DATOS.md)** - Estructura completa de tablas y campos
- **[Stored Procedures](./docs/04-STORED-PROCEDURES.md)** - Documentación de cada SP
- **[Especificaciones](./docs/05-ESPECIFICACIONES.md)** - Estándares y convenciones (OBLIGATORIO LEER)
- **[Roles y Permisos](./docs/06-ROLES-PERMISOS.md)** - Matriz de acceso por rol
- **[Pendientes](./docs/01-PENDIENTES.md)** - Tareas del backlog
- **[Roadmap](./docs/02-ROADMAP.md)** - Plan de desarrollo

## 🛠️ Mantenimiento

### Respaldar base de datos
```bash
mysqldump -u root -p win_sgn_db > sgn_db_backup_$(date +%Y%m%d).sql
```

### Restaurar respaldo
```bash
mysql -u root -p win_sgn_db < sgn_db_backup_20240115.sql
```

### Ver tamaño
```bash
SELECT table_name, ROUND(((data_length + index_length) / 1024 / 1024), 2) AS "Size (MB)"
FROM information_schema.tables
WHERE table_schema = "win_sgn_db"
ORDER BY (data_length + index_length) DESC;
```

### Limpiar trazabilidad antigua (⚠️ cuidado)
```bash
DELETE FROM t_trazabilidad_eventos WHERE fec_registro < DATE_SUB(NOW(), INTERVAL 1 YEAR);
OPTIMIZE TABLE t_trazabilidad_eventos;
```

## 🔗 Conexión con Backend

- **Backend**: [Winet-SGN-Back-Dev](../../Winet-SGN-Back-Dev/README.md)
- **Framework**: Laravel 11
- **Patrón**: Repository + Service
- **Acceso**: Solo via Stored Procedures

## ⚡ Performance

### Índices optimizados
```
- ix_t_numero_telefonico_id_estado_numero: Búsqueda estado de número
- ix_t_numero_telefonico_id_rango: Búsqueda por ID rango
- ix_t_numero_telefonico_id_tipo_doc: Búsqueda por tipo de documento
- ix_t_numero_telefonico_id_operador_cedente: Búsqueda por Operador cedente
- ix_t_numero_telefonico_id_operador_receptor: Búsqueda por Operador receptor
- ix_t_numero_telefonico_id_motivo_cambio: Búsqueda por motivo de cambio
- ix_t_rango_numeracion_num_rango_inicial_num_rango_final: Búsqueda rango inicial y rango final
- ix_t_rango_numeracion_id_tipo_servicio: Búsqueda tipo de servicio
- ix_t_rango_numeracion_id_departamento: Búsqueda por departamento
- ix_t_rango_numeracion_id_tipo_zona: Búsqueda por tipo de zona
- ix_t_rango_numeracion_id_proveedor_numeracion: Búsqueda por proveedor de numeración
- ix_t_rango_numeracion_id_comercializador: Búsqueda por comercializador
- ix_t_rango_numeracion_id_estado_rango: Búsqueda estado rango
- ix_t_rango_numeracion_id_tipo_servicio_departamento_tipo_zona: Búsqueda por departamento y zona
- ix_t_portabilidad_numero_fec_programacion_portabilidad: Búsqueda Fecha programación de portabilidad
- ix_t_portabilidad_numero_id_estado_portabilidad: Búsqueda por estado de portabilidad
- ix_t_portabilidad_numero_id_operador_cedente: Búsqueda por operador cedente
```

### Recomendaciones
- Paginar listados grandes (usar LIMIT/OFFSET)
- Usar índices en búsquedas frecuentes
- Analizar performance con EXPLAIN
- Considerar particionamiento para `t_numero_telefonico`

## 🚨 Validaciones importantes

- ✅ La **PK** es requerida en TODAS las tablas
- ✅ Las **FKs** deben estar definidas explícitamente
- ✅ Las tablas **t_*** tienen auditoría obligatoria
- ✅ Nomenclatura en **snake_case** minúsculas
- ✅ Usar **ON DUPLICATE KEY UPDATE** en seeds

## 📞 Soporte

Para cambios en schema:
1. Crear migration en Backend
2. Documentar en Diccionario de datos
3. Actualizar SP si aplica
4. Sincronizar con Equipo Backend

## 📝 Cambio log reciente

- [X] Estructura base de tablas (2024-Q1)
- [X] Stored Procedures principales (2024-Q1)
- [X] Sistema de roles y permisos (En progreso)
- [X] Cambio portabilidad
- [ ] Tablas de contingencia freeswitch (Por definir)

---

**Última actualización**: 02/07/2026  
**Versión schema**: 1.0  
**Compatible con**: MySQL 8.0+, Laravel 11+
