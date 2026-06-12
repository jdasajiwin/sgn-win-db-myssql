# DB-002 - Roles y Permisos

## Objetivo
Establecer los permisos de acceso a las funcionalidades de la aplicación en base a los roles matriculados en la BD:

### Creación de una tabla para manejar los permisos de acuerdo a las siguientes condiciones
- Crear una tabla permisos en base a las columnas Módulo/Submoódulo y Acción, donde se debe añadir un campo (codigo) para identificar el permiso Ej. Usuarios/Gestion de usuario -> Agregar = usuario.agregar
- Para números telefónicos, en el caso del rol **Operador NOC** se debe tener en cuenta el estados de cada número (t_numero_telefonico), los cuales se encuentran en la tabla m_estado_numero. Para este caso considerar alguna alternativa ya que la variación proviene del estado desde otra tabla.
- Crear una tabla para asociar roles con los permisos (m_roles_permisos)
- Crear una tabla para asociar roles con los menus (m_menus_permisos)
- Crear scripts correspondientes en archivos schema/schema_erflow.sql, data/seed_erflow.sql
- Crear sp en objects/sp/ para obtener los permisos de cada menu por rol del usuario que ingresa al sistema.
- Considerar crear FK e indices para las nuevas tablas.

| Módulo/Submódulo | Acción | SuperAdmin | Admin TI | Gestor de telefonía | Supervisor NOC | Operador NOC |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: |
| **Usuarios/Gestión de usuario** | Agregar | **X** | **X** | | | |
| | Consultar | **X** | **X** | **X** | | |
| | Editar | **X** | **X** | | | |
| | Exportar | **X** | **X** | **X** | **X** | |
| | Todas | **X** | **X** |  |  |  |
| **Usuarios/Trazabilidad de evento** | Consultar | **X** | **X** | **X** | **X** | |
|  | Exportar | **X** | **X** | **X** | **X** | |
|  | Todas | **X** | **X** | **X** | **X** | |
| **Rangos de numeración** | Agregar | **X** | | **X** | | |
|  | Exportar | **X** | | **X** | | |
|  | Consultar | **X** | | **X** | | |
|  | Habilitar | **X** | | **X** | | |
|  | Todas | **X** | | **X** | | |
| **Números telefónicos** | Consultar | **X** | | **X** | **X** | **X** |
| | Editar | **X** | | **X** | **X** | |
| | Editar (estados: Disponible, Bloqueado, Boqueado port in, Pendiente portabilidad, Pre-reserva) | **X** | | | | **X** |
| | Exportar | **X** | | **X** | **X** | |
| **Contingencia de activación Freeswitch** | Consultar | **X** | | | **X** | **X** |
| | Activar | **X** | | | **X** | **X** |
| **Gestión de Portabilidad** | Consultar | **X** | | **X** | **X** | **X** |
| | Editar | **X** | | **X** | **X** | **X** |
| | Exportar | **X** | | **X** | **X** | **X** |
| | Descargar Plantilla | **X** | | **X** | | |
| | Importar Plantilla | **X** | | **X** | | |
| **Mantenimientos** | Parámetros generales SGN (Días de reserva de baja, Días de pre-reserva, Cantidad mínima de rangos a generar) | **X** | | **X** | | |
| | Parámetros generales Freeswitch (Planes de telefonía) | **X** | | **X** | | |
| | Proveedores de numeración | **X** | | **X** | | |
| | Comercializadores | **X** | | **X** | | |
| | Operadores | **X** | | **X** | | |
| | Motivo de cambio del estado del número | **X** | | **X** | | |
| | Departamento | **X** | | **X** | | |
| | Estados del número telefónico | **X** | | **X** | | |