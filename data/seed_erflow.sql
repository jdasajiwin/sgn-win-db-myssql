-- Data de prueba (ordenada por dependencias FK)
-- Estructura navegacion (desde Inicio de sesion):
--   Usuarios (1) -> Gestion de usuario (2), Trazabilidad de eventos (3)
--   Gestion de rangos de numeracion (4)
--   Gestion de numeros telefonicos (5)
--   Gestion de Portabilidad (6)
--   Contingencia activacion freeswitch (7) -> Numeros WI NET (8), Numeros Portados (9)
--   Mantenimientos (10) -> Parametros SGN, Proveedores, Comercializador, Operadores,
--                          Motivo cambio estado, Parametros Freeswitch (11-16)
-- Rol admin (id_rol=1): todos los menus y opciones anteriores.
-- Usuario prueba: id_usuario = 1

START TRANSACTION;

-- 0) Tipo de estado (padre de m_estados)
INSERT INTO m_tipo_estado (id_tipo_estado, cod_tipo_estado, desc_tipo_estado, flc_activo)
VALUES
  (1, 'GEN', 'General', 1),
  (2, 'TPSRV', 'Tipo proveedor servicio', 1)
ON DUPLICATE KEY UPDATE
  cod_tipo_estado = VALUES(cod_tipo_estado),
  desc_tipo_estado = VALUES(desc_tipo_estado),
  flc_activo = VALUES(flc_activo);

-- 1) Catalogo de estados
INSERT INTO m_estados (id_estado, id_tipo_estado, cod_estado, desc_estado, flg_activo)
VALUES
  (0, 1, 'INA', 'Inactivo', 1),
  (1, 1, 'ACT', 'Activo', 1),
  (2, 2, 'FJX', 'Fijo', 1),
  (3, 2, 'MVL', 'Móvil', 1)  
ON DUPLICATE KEY UPDATE
  id_tipo_estado = VALUES(id_tipo_estado),
  cod_estado = VALUES(cod_estado),
  desc_estado = VALUES(desc_estado),
  flg_activo = VALUES(flg_activo);

-- 2) Catalogos base
INSERT INTO m_menus (
  id_menu, cod_menu, cod_sub_menu, id_sub_menu, desc_menu, desc_ruta, id_estado
)
VALUES
  (1, LEFT(REGEXP_REPLACE(UPPER('Usuarios'), '[^A-Z0-9]', ''), 12), NULL, NULL, 'Usuarios', '/usuarios', 1),
  (2, LEFT(REGEXP_REPLACE(UPPER('Gestion de usuario'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Usuarios'), '[^A-Z0-9]', ''), 12), 1, 'Gestion de usuario', '/usuarios/gestion', 1),
  (3, LEFT(REGEXP_REPLACE(UPPER('Trazabilidad de eventos'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Usuarios'), '[^A-Z0-9]', ''), 12), 1, 'Trazabilidad de eventos', '/usuarios/trazabilidad', 1),
  (4, LEFT(REGEXP_REPLACE(UPPER('Gestion de rangos de numeracion'), '[^A-Z0-9]', ''), 12), NULL, NULL, 'Gestion de rangos de numeracion', '/rangos-numeracion', 1),
  (5, LEFT(REGEXP_REPLACE(UPPER('Gestion de numeros telefonicos'), '[^A-Z0-9]', ''), 12), NULL, NULL, 'Gestion de numeros telefonicos', '/numeros-telefonicos', 1),
  (6, LEFT(REGEXP_REPLACE(UPPER('Gestion de Portabilidad'), '[^A-Z0-9]', ''), 12), NULL, NULL, 'Gestion de Portabilidad', '/portabilidad', 1),
  (7, LEFT(REGEXP_REPLACE(UPPER('Contingencia de activacion freeswitch'), '[^A-Z0-9]', ''), 12), NULL, NULL, 'Contingencia de activacion freeswitch', '/contingencia', 1),
  (8, LEFT(REGEXP_REPLACE(UPPER('Numeros WI NET'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Contingencia de activacion freeswitch'), '[^A-Z0-9]', ''), 12), 7, 'Numeros WI NET', '/contingencia/winet', 1),
  (9, LEFT(REGEXP_REPLACE(UPPER('Numeros Portados'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Contingencia de activacion freeswitch'), '[^A-Z0-9]', ''), 12), 7, 'Numeros Portados', '/contingencia/numeros-portados', 1),
  (10, LEFT(REGEXP_REPLACE(UPPER('Mantenimientos'), '[^A-Z0-9]', ''), 12), NULL, NULL, 'Mantenimientos', '/mantenimientos', 1),
  (11, LEFT(REGEXP_REPLACE(UPPER('SGN parametros generales'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Mantenimientos'), '[^A-Z0-9]', ''), 12), 10, 'Parametros generales SGN', '/mantenimientos/parametros-sgn', 1),
  (12, LEFT(REGEXP_REPLACE(UPPER('Proveedores de numeracion'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Mantenimientos'), '[^A-Z0-9]', ''), 12), 10, 'Proveedores de numeracion', '/mantenimientos/proveedores-numeracion', 1),
  (13, LEFT(REGEXP_REPLACE(UPPER('Comercializador'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Mantenimientos'), '[^A-Z0-9]', ''), 12), 10, 'Comercializador', '/mantenimientos/comercializador', 1),
  (14, LEFT(REGEXP_REPLACE(UPPER('Operadores'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Mantenimientos'), '[^A-Z0-9]', ''), 12), 10, 'Operadores', '/mantenimientos/operadores', 1),
  (15, LEFT(REGEXP_REPLACE(UPPER('Motivo del cambio de estado'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Mantenimientos'), '[^A-Z0-9]', ''), 12), 10, 'Motivo del cambio de estado', '/mantenimientos/motivo-cambio-estado', 1),
  (16, LEFT(REGEXP_REPLACE(UPPER('Freeswitch parametros generales'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Mantenimientos'), '[^A-Z0-9]', ''), 12), 10, 'Parametros generales Freeswitch', '/mantenimientos/parametros-freeswitch', 1)
ON DUPLICATE KEY UPDATE
  cod_menu = VALUES(cod_menu),
  cod_sub_menu = VALUES(cod_sub_menu),
  id_sub_menu = VALUES(id_sub_menu),
  desc_menu = VALUES(desc_menu),
  desc_ruta = VALUES(desc_ruta),
  id_estado = VALUES(id_estado);

INSERT INTO m_opciones (
  id_menu, id_opcion, cod_menu, desc_opcion, desc_ruta, id_estado
)
VALUES
  (1, 1, LEFT(REGEXP_REPLACE(UPPER('Usuarios'), '[^A-Z0-9]', ''), 12), 'Usuarios', '/usuarios', 1),
  (2, 2, LEFT(REGEXP_REPLACE(UPPER('Gestion de usuario'), '[^A-Z0-9]', ''), 12), 'Gestion de usuario', '/usuarios/gestion', 1),
  (3, 3, LEFT(REGEXP_REPLACE(UPPER('Trazabilidad de eventos'), '[^A-Z0-9]', ''), 12), 'Trazabilidad de eventos', '/usuarios/trazabilidad', 1),
  (4, 4, LEFT(REGEXP_REPLACE(UPPER('Gestion de rangos de numeracion'), '[^A-Z0-9]', ''), 12), 'Gestion de rangos de numeracion', '/rangos-numeracion', 1),
  (5, 5, LEFT(REGEXP_REPLACE(UPPER('Gestion de numeros telefonicos'), '[^A-Z0-9]', ''), 12), 'Gestion de numeros telefonicos', '/numeros-telefonicos', 1),
  (6, 6, LEFT(REGEXP_REPLACE(UPPER('Gestion de Portabilidad'), '[^A-Z0-9]', ''), 12), 'Gestion de Portabilidad', '/portabilidad', 1),
  (7, 7, LEFT(REGEXP_REPLACE(UPPER('Contingencia de activacion freeswitch'), '[^A-Z0-9]', ''), 12), 'Contingencia de activacion freeswitch', '/contingencia', 1),
  (8, 8, LEFT(REGEXP_REPLACE(UPPER('Numeros WI NET'), '[^A-Z0-9]', ''), 12), 'Numeros WI NET', '/contingencia/winet', 1),
  (9, 9, LEFT(REGEXP_REPLACE(UPPER('Numeros Portados'), '[^A-Z0-9]', ''), 12), 'Numeros Portados', '/contingencia/numeros-portados', 1),
  (10, 10, LEFT(REGEXP_REPLACE(UPPER('Mantenimientos'), '[^A-Z0-9]', ''), 12), 'Mantenimientos', '/mantenimientos', 1),
  (11, 11, LEFT(REGEXP_REPLACE(UPPER('SGN parametros generales'), '[^A-Z0-9]', ''), 12), 'Parametros generales SGN', '/mantenimientos/parametros-sgn', 1),
  (12, 12, LEFT(REGEXP_REPLACE(UPPER('Proveedores de numeracion'), '[^A-Z0-9]', ''), 12), 'Proveedores de numeracion', '/mantenimientos/proveedores-numeracion', 1),
  (13, 13, LEFT(REGEXP_REPLACE(UPPER('Comercializador'), '[^A-Z0-9]', ''), 12), 'Comercializador', '/mantenimientos/comercializador', 1),
  (14, 14, LEFT(REGEXP_REPLACE(UPPER('Operadores'), '[^A-Z0-9]', ''), 12), 'Operadores', '/mantenimientos/operadores', 1),
  (15, 15, LEFT(REGEXP_REPLACE(UPPER('Motivo del cambio de estado'), '[^A-Z0-9]', ''), 12), 'Motivo del cambio de estado', '/mantenimientos/motivo-cambio-estado', 1),
  (16, 16, LEFT(REGEXP_REPLACE(UPPER('Freeswitch parametros generales'), '[^A-Z0-9]', ''), 12), 'Parametros generales Freeswitch', '/mantenimientos/parametros-freeswitch', 1)
ON DUPLICATE KEY UPDATE
  cod_menu = VALUES(cod_menu),
  desc_opcion = VALUES(desc_opcion),
  desc_ruta = VALUES(desc_ruta),
  id_estado = VALUES(id_estado);

INSERT INTO m_roles (id_rol, cod_rol, desc_rol, id_estado)
VALUES (1, LEFT(REGEXP_REPLACE(UPPER('admin'), '[^A-Z0-9]', ''), 12), 'admin', 1)
ON DUPLICATE KEY UPDATE
  cod_rol = VALUES(cod_rol),
  desc_rol = VALUES(desc_rol),
  id_estado = VALUES(id_estado);

INSERT INTO m_roles_menus (
  id_rol_menu, id_rol, id_menu, desc_usuario_crea, desc_usuario_modf, fec_modf, id_estado
)
VALUES
  (1, 1, 1, 'seed', 'seed', 0, 1),
  (2, 1, 2, 'seed', 'seed', 0, 1),
  (3, 1, 3, 'seed', 'seed', 0, 1),
  (4, 1, 4, 'seed', 'seed', 0, 1),
  (5, 1, 5, 'seed', 'seed', 0, 1),
  (6, 1, 6, 'seed', 'seed', 0, 1),
  (7, 1, 7, 'seed', 'seed', 0, 1),
  (8, 1, 8, 'seed', 'seed', 0, 1),
  (9, 1, 9, 'seed', 'seed', 0, 1),
  (10, 1, 10, 'seed', 'seed', 0, 1),
  (11, 1, 11, 'seed', 'seed', 0, 1),
  (12, 1, 12, 'seed', 'seed', 0, 1),
  (13, 1, 13, 'seed', 'seed', 0, 1),
  (14, 1, 14, 'seed', 'seed', 0, 1),
  (15, 1, 15, 'seed', 'seed', 0, 1),
  (16, 1, 16, 'seed', 'seed', 0, 1)
ON DUPLICATE KEY UPDATE
  id_rol = VALUES(id_rol),
  id_menu = VALUES(id_menu),
  desc_usuario_modf = VALUES(desc_usuario_modf),
  fec_modf = VALUES(fec_modf),
  id_estado = VALUES(id_estado);

DELETE FROM m_roles_opciones;

INSERT INTO m_roles_opciones (
  id_rol_opcion, id_rol, id_opcion, id_menu, desc_usuario_crea, desc_usuario_modf, fec_creacion, fec_modf
)
VALUES
  (1, 1, 1, 1, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (2, 1, 2, 2, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (3, 1, 3, 3, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (4, 1, 4, 4, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (5, 1, 5, 5, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (6, 1, 6, 6, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (7, 1, 7, 7, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (8, 1, 8, 8, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (9, 1, 9, 9, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (10, 1, 10, 10, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (11, 1, 11, 11, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (12, 1, 12, 12, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (13, 1, 13, 13, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (14, 1, 14, 14, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (15, 1, 15, 15, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (16, 1, 16, 16, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO t_usuarios (
  id_usuario, desc_usuario, desc_nombres, desc_apellidos, desc_email, id_estado,
  desc_usuario_crea, desc_usuario_modf, fec_creacion, fec_modf
)
VALUES (
  1, 'usuario principal', 'jhoel', 'salinas', 'jsdaniel_21@hotmail.com', 1,
  CURRENT_USER(), CURRENT_USER(), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
)
ON DUPLICATE KEY UPDATE
  desc_usuario = VALUES(desc_usuario),
  desc_nombres = VALUES(desc_nombres),
  desc_apellidos = VALUES(desc_apellidos),
  desc_email = VALUES(desc_email),
  id_estado = VALUES(id_estado),
  desc_usuario_modf = CURRENT_USER(),
  fec_modf = CURRENT_TIMESTAMP;


-- 3) Relacion usuario-rol
INSERT INTO t_usuario_rol (
  id_usuario_rol, id_rol, id_usuario, id_estado,
  desc_usuario_crea, desc_usuario_modf, fec_creacion, fec_modf
)
VALUES (
  1, 1, 1, 1,
  CURRENT_USER(), CURRENT_USER(), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
)
ON DUPLICATE KEY UPDATE
  id_rol = VALUES(id_rol),
  id_usuario = VALUES(id_usuario),
  id_estado = VALUES(id_estado),
  desc_usuario_modf = CURRENT_USER(),
  fec_modf = CURRENT_TIMESTAMP;

COMMIT;

-- Validacion rapida
SELECT 'm_tipo_estado' AS tabla, id_tipo_estado FROM m_tipo_estado WHERE id_tipo_estado IN (1, 2)
UNION ALL
SELECT 'm_estados', id_estado FROM m_estados WHERE id_estado = 1
UNION ALL
SELECT 'm_menus', id_menu FROM m_menus WHERE id_menu IN (1, 16)
UNION ALL
SELECT 'm_roles', id_rol FROM m_roles WHERE id_rol = 1
UNION ALL
SELECT 't_usuarios', id_usuario FROM t_usuarios WHERE id_usuario = 1;
