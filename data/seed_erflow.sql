-- Data de prueba (ordenada por dependencias FK)
-- Mapeo funcional:
--   Menu:    numbering-range            -> id_menu = 1
--   Opcion:  numbering-range/add-range  -> (id_menu = 1, id_opcion = 1)
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
VALUES (
  1, null, 'numbering-range', 'numbering-range', 1
)
ON DUPLICATE KEY UPDATE
  id_sub_menu = VALUES(id_sub_menu),
  desc_menu = VALUES(desc_menu),
  desc_ruta = VALUES(desc_ruta),
  id_estado = VALUES(id_estado);

INSERT INTO m_opciones (
  id_opcion, id_menu, desc_opcion, desc_ruta, id_estado
)
VALUES (
  1, 1, 'Numero de rango', 'numbering-range.add-range', 1
)
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

-- 2) Relacion rol-opcion
INSERT INTO m_roles_opciones (
  id_rol_opcion, id_menu, id_opcion, id_rol
)
VALUES (1, 1, 1, 1)
ON DUPLICATE KEY UPDATE
  id_menu = VALUES(id_menu),
  id_opcion = VALUES(id_opcion),
  id_rol = VALUES(id_rol);

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
