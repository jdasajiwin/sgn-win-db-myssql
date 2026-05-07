-- Data de prueba (ordenada por dependencias FK)
-- Mapeo funcional:
--   Menu:    Gestion de usuarios         -> id_menu = 1
--   Opcion:  numbering-range/add-range   -> (id_menu = 1, id_opcion = 1)
--   Rol:     admin                      -> id_rol = 1
--   Usuario: 1                          -> id_usuario = 1

START TRANSACTION;

-- 1) Catalogo de estados (debe ir primero por FKs)
INSERT INTO m_estados (id_estado, desc_estado, flg_activo)
VALUES
  (0, 'Inactivo', b'1'),
  (1, 'Activo', b'1')
ON DUPLICATE KEY UPDATE
  desc_estado = VALUES(desc_estado),
  flg_activo = VALUES(flg_activo);

-- 2) Catalogos base
INSERT INTO m_menus (
  id_menu, id_sub_menu, desc_menu, desc_ruta, id_estado
)
VALUES
  (1, null, 'Gestion de usuarios', '/gestion-usuarios', 1),
  (2, null, 'Trazabilidad de eventos', '/trazabilidad', 1),
  (3, null, 'Rangos de numeracion', '/rango-numeracion', 1),
  (4, null, 'Numeros telefonicos', '/asignar-numero', 1),
  (5, null, 'Portabilidad', '/portabilidad', 1),
  (6, null, 'Contingencia de activacion Freeswitch', '/contingencia', 1),
  (7, 6, 'Numeros WI NET', '/contingencia/winet', 1),
  (8, 6, 'Numeros portados', '/contingencia/numeros-portados', 1)
ON DUPLICATE KEY UPDATE
  id_sub_menu = VALUES(id_sub_menu),
  desc_menu = VALUES(desc_menu),
  desc_ruta = VALUES(desc_ruta),
  id_estado = VALUES(id_estado);

INSERT INTO m_opciones (
  id_opcion, id_menu, desc_opcion, desc_ruta, id_estado
)
VALUES
  (1, 1, 'Gestion de usuarios', '/gestion-usuarios', 1),
  (2, 2, 'Trazabilidad de eventos', '/trazabilidad', 1),
  (3, 3, 'Rangos de numeracion', '/rango-numeracion', 1),
  (4, 4, 'Numeros telefonicos', '/asignar-numero', 1),
  (5, 5, 'Portabilidad', '/portabilidad', 1),
  (6, 6, 'Contingencia de activacion Freeswitch', '/contingencia', 1),
  (7, 7, 'Numeros WI NET', '/contingencia/winet', 1),
  (8, 8, 'Numeros portados', '/contingencia/numeros-portados', 1)
ON DUPLICATE KEY UPDATE
  id_opcion = VALUES(id_opcion),
  id_menu = VALUES(id_menu),
  desc_opcion = VALUES(desc_opcion),
  desc_ruta = VALUES(desc_ruta),
  id_estado = VALUES(id_estado);

INSERT INTO m_roles (id_rol, desc_rol, id_estado)
VALUES (1, 'admin', 1)
ON DUPLICATE KEY UPDATE
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
SELECT 'm_menus' AS tabla, id_menu FROM m_menus WHERE id_menu = 1
UNION ALL
SELECT 'm_roles', id_rol FROM m_roles WHERE id_rol = 1
UNION ALL
SELECT 't_usuarios', id_usuario FROM t_usuarios WHERE id_usuario = 1;
