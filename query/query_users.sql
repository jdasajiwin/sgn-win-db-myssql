SELECT * FROM m_tipo_estado;

SELECT * FROM t_usuarios;

SELECT * FROM m_roles;


SELECT * FROM t_usuario_rol;
SELECT * FROM m_roles_menus;

CALL spl_t_usuarios_principal_listar ('jsdaniel_21@hotmail.com');

-- Listado con filtros opcionales (NULL = sin filtro)
CALL spl_t_usuarios_listar(NULL, NULL, NULL);
CALL spl_t_usuarios_listar('fuyu', NULL, NULL);
CALL spl_t_usuarios_listar(NULL, 1, NULL);
CALL spl_t_usuarios_listar(NULL, NULL, 1);
CALL spl_t_usuarios_listar('romero', 1, 1);
CALL spl_m_roles_listar('1');
CALL spl_m_roles_menus_listar(2);