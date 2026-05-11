-- Data de prueba (ordenada por dependencias FK)
-- Mapeo funcional:
--   Menu:    Gestion de usuarios         -> id_menu = 1
--   Opcion:  numbering-range/add-range   -> (id_menu = 1, id_opcion = 1)
--   Rol:     admin                      -> id_rol = 1
--   Usuario: 1                          -> id_usuario = 1

START TRANSACTION;

-- 0) Tipo de estado (padre de m_estados)
INSERT INTO m_tipo_estado (id_tipo_estado, cod_tipo_estado, desc_tipo_estado, flc_activo)
VALUES
  (1, 'GEN', 'General', 1),
  (2, 'TPSRV', 'Tipo proveedor servicio', 1),
  (3, 'TPZON', 'Tipo de Zona', 1),
  (4, 'TPROV', 'Tipo de proveedor numeración', 1),
  (5, 'TPCOM', 'Tipo de comercializador', 1),
  (6, 'TPESR', 'Estado Rango', 1),
  (7, 'TPFCR', 'Fácil recordación', 1),
  (8, 'TPDOC', 'Tipo de documento', 1),
  (9, 'TPSTN', 'Tipo estado de número', 1),
  (10, 'TPMVC', 'Motivo Cambio', 1)
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
  (3, 2, 'MVL', 'Móvil', 1),
  (4,3, 'RUR', 'Rural', 1),
  (5,3, 'URB', 'Urbano', 1),
  (6,4, 'WI', 'WI NET TELECOM', 1),
  (7,4, 'ON', 'ON', 1),
  (8,4, 'GTD', 'GTD', 1),
  (9,5, 'WIN', 'WIN', 1),
  (10,6, 'HAB', 'Habilitado', 1),
  (11,6, 'NOH', 'No habilitado', 1),
  (12,7, 'S', 'Sí', 1),
  (13,7, 'N', 'No', 1),
  (14,8, 'DNI', 'Documento Nacional de Identidad', 1),
  (15,8, 'CE', 'Carnet de Extranjería', 1),
  (16,8, 'RUC', 'Registro Único de Contribuyentes', 1),
  (17,8, 'PAS', 'Pasaporte', 1),
  (18,8, 'CIP', 'Carnet de Identidad Personal', 1),
  (19,9, 'NOH', 'No habilitado', 1),
  (20,9, 'DIS', 'Disponible', 1),
  (21,9, 'PRR', 'Pre-reserva', 1),
  (22,9, 'BLQ', 'Bloqueado', 1),
  (23,9, 'PPB', 'Pendiente portabilidad', 1),
  (24,9, 'EUS', 'En uso', 1),
  (25,9, 'BAJ', 'Baja', 1),
  (26,9, 'BLP', 'Bloqueado port in', 1),
  (27,9, 'POT', 'Port out', 1),
  (28,10, 'CAMTIT', 'Cambio de titularidad', 1),
  (29,10, 'INCAPI', 'Incidencia con las APIs', 1),
  (30,10, 'SOLVNO', 'A solicitud de VNO', 1),
  (31,10, 'SOLOSP', 'A solicitud de OSIPTEL', 1),
  (32,10, 'SOLIND', 'A solicitud de INDECOPI', 1),
  (33,10, 'CONTFRE', 'Contingencia Freeswitch', 1),
  (34,10, 'CAMNUM', 'Cambio de número', 1),
  (35,10,'CAMNUMPOR','Cambio de número por portabilidad' ,1)

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
  (1, LEFT(REGEXP_REPLACE(UPPER('Gestion de usuarios'), '[^A-Z0-9]', ''), 12), null, null, 'Gestion de usuarios', '/gestion-usuarios', 1),
  (2, LEFT(REGEXP_REPLACE(UPPER('Trazabilidad de eventos'), '[^A-Z0-9]', ''), 12), null, null, 'Trazabilidad de eventos', '/trazabilidad', 1),
  (3, LEFT(REGEXP_REPLACE(UPPER('Rangos de numeracion'), '[^A-Z0-9]', ''), 12), null, null, 'Rangos de numeracion', '/rango-numeracion', 1),
  (4, LEFT(REGEXP_REPLACE(UPPER('Numeros telefonicos'), '[^A-Z0-9]', ''), 12), null, null, 'Numeros telefonicos', '/asignar-numero', 1),
  (5, LEFT(REGEXP_REPLACE(UPPER('Portabilidad'), '[^A-Z0-9]', ''), 12), null, null, 'Portabilidad', '/portabilidad', 1),
  (6, LEFT(REGEXP_REPLACE(UPPER('Contingencia de activacion Freeswitch'), '[^A-Z0-9]', ''), 12), null, null, 'Contingencia de activacion Freeswitch', '/contingencia', 1),
  (7, LEFT(REGEXP_REPLACE(UPPER('Numeros WI NET'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Contingencia de activacion Freeswitch'), '[^A-Z0-9]', ''), 12), 6, 'Numeros WI NET', '/contingencia/winet', 1),
  (8, LEFT(REGEXP_REPLACE(UPPER('Numeros portados'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Contingencia de activacion Freeswitch'), '[^A-Z0-9]', ''), 12), 6, 'Numeros portados', '/contingencia/numeros-portados', 1)
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
  (1, 1, LEFT(REGEXP_REPLACE(UPPER('Gestion de usuarios'), '[^A-Z0-9]', ''), 12), 'Gestion de usuarios', '/gestion-usuarios', 1),
  (2, 2, LEFT(REGEXP_REPLACE(UPPER('Trazabilidad de eventos'), '[^A-Z0-9]', ''), 12), 'Trazabilidad de eventos', '/trazabilidad', 1),
  (3, 3, LEFT(REGEXP_REPLACE(UPPER('Rangos de numeracion'), '[^A-Z0-9]', ''), 12), 'Rangos de numeracion', '/rango-numeracion', 1),
  (4, 4, LEFT(REGEXP_REPLACE(UPPER('Numeros telefonicos'), '[^A-Z0-9]', ''), 12), 'Numeros telefonicos', '/asignar-numero', 1),
  (5, 5, LEFT(REGEXP_REPLACE(UPPER('Portabilidad'), '[^A-Z0-9]', ''), 12), 'Portabilidad', '/portabilidad', 1),
  (6, 6, LEFT(REGEXP_REPLACE(UPPER('Contingencia de activacion Freeswitch'), '[^A-Z0-9]', ''), 12), 'Contingencia de activacion Freeswitch', '/contingencia', 1),
  (7, 7, LEFT(REGEXP_REPLACE(UPPER('Numeros WI NET'), '[^A-Z0-9]', ''), 12), 'Numeros WI NET', '/contingencia/winet', 1),
  (8, 8, LEFT(REGEXP_REPLACE(UPPER('Numeros portados'), '[^A-Z0-9]', ''), 12), 'Numeros portados', '/contingencia/numeros-portados', 1)
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
  (8, 1, 8, 'seed', 'seed', 0, 1)
ON DUPLICATE KEY UPDATE
  id_rol = VALUES(id_rol),
  id_menu = VALUES(id_menu),
  desc_usuario_modf = VALUES(desc_usuario_modf),
  fec_modf = VALUES(fec_modf),
  id_estado = VALUES(id_estado);

-- Limpieza: m_roles_opciones ya no se puebla en seed
DELETE FROM m_roles_opciones;

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
SELECT 'm_menus', id_menu FROM m_menus WHERE id_menu = 1
UNION ALL
SELECT 'm_roles', id_rol FROM m_roles WHERE id_rol = 1
UNION ALL
SELECT 't_usuarios', id_usuario FROM t_usuarios WHERE id_usuario = 1;
