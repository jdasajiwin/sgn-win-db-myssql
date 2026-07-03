# Tareas Pendientes - Base de Datos

Estado referenciado contra `schema/schema_erflow.sql`, `data/seed_erflow.sql` y `objects/sp/` (julio 2026).

## Críticas (Bloqueantes)

- [ ] Crear SP de CRUD para `t_rango_numeracion` y `t_numero_telefonico`
- [ ] Crear SP de consulta/edición para `t_portabilidad_numero`

## Importantes (Alta prioridad)

- [ ] Crear vistas para reportes comunes (portabilidad, números por rango)
- [ ] Implementar respaldos automáticos diarios
- [ ] SP para permisos por usuario (`spl_usuario_permisos_listar` recibe `p_id_rol`, no `p_id_usuario`)
- [ ] Seed de datos de prueba para `t_rango_numeracion`, `t_numero_telefonico` y `t_portabilidad_numero`

## Mejoras (Media prioridad)

- [ ] Particionamiento para `t_numero_telefonico` y `t_trazabilidad_eventos`
- [ ] Política de retención/archivado de trazabilidad
- [ ] Comentarios SQL (`COMMENT`) en tablas y columnas críticas
- [ ] Procedimientos de mantenimiento (`OPTIMIZE TABLE`, estadísticas)

## Enhancements (Baja prioridad)

- [ ] Migrar datos históricos a tablas de archivo
- [ ] Dashboards de monitoreo de crecimiento de datos
- [ ] Ajuste fino de índices según uso en producción

---

## Completado recientemente

- [x] Tablas maestras y transaccionales base en `schema_erflow.sql`
- [x] Sistema de roles, permisos, menús y asignaciones en seed
- [x] 26 Stored Procedures documentados en `objects/sp/`
- [x] Índices de búsqueda en `t_numero_telefonico`, `t_rango_numeracion` y `t_portabilidad_numero`
- [x] Tabla `t_portabilidad_numero` con FKs a catálogos de portabilidad

---

## Notas

- Seguir estándares en [05-ESPECIFICACIONES.md](./05-ESPECIFICACIONES.md)
- Actualizar [03-DICCIONARIO-DATOS.md](./03-DICCIONARIO-DATOS.md) ante cualquier cambio de schema
- Sincronizar cambios con migrations de Laravel en Backend
