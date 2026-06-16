DROP PROCEDURE IF EXISTS spl_t_usuarios_listar;

DELIMITER $$
CREATE PROCEDURE spl_t_usuarios_listar(
    IN p_desc_usuario VARCHAR(150),
    IN p_id_rol INT,
    IN p_id_estado TINYINT,
    IN p_id_acceso TINYINT,
    IN p_id_usuario_logueado INT
)
BEGIN
    DECLARE v_nivel_logueado INT;

    -- Nivel jerárquico del usuario logueado
    SELECT MIN(r.num_nivel_jerarquia)
    INTO v_nivel_logueado
    FROM t_usuario_rol ur
    INNER JOIN m_roles r ON r.id_rol = ur.id_rol
    WHERE ur.id_usuario = p_id_usuario_logueado
      AND ur.flg_activo = 1
      AND r.flg_activo = 1;

    -- Consulta principal
    SELECT
        u.id_usuario,
        u.desc_usuario,
        u.desc_nombres,
        u.desc_apellidos,
        u.desc_email,
        u.desc_tipo_login,
        u.id_estado_usuario,
        u.id_acceso_usuario,
        eu.desc_estado,
        au.desc_acceso,
        rc.roles
    FROM t_usuarios u
    INNER JOIN m_estado_usuario eu ON eu.id_estado_usuario = u.id_estado_usuario AND eu.flg_activo = 1
    INNER JOIN m_acceso_usuario au ON au.id_acceso_usuario = u.id_acceso_usuario AND au.flg_activo = 1
    INNER JOIN (
        SELECT ur.id_usuario, MIN(r.num_nivel_jerarquia) AS nivel_usuario
        FROM t_usuario_rol ur
        INNER JOIN m_roles r ON r.id_rol = ur.id_rol
        WHERE ur.flg_activo = 1 AND r.flg_activo = 1
        GROUP BY ur.id_usuario
    ) j ON j.id_usuario = u.id_usuario
    LEFT JOIN (
        SELECT ur.id_usuario,
               GROUP_CONCAT(DISTINCT r.desc_rol ORDER BY r.desc_rol SEPARATOR ', ') AS roles
        FROM t_usuario_rol ur
        INNER JOIN m_roles r ON r.id_rol = ur.id_rol
        WHERE ur.flg_activo = 1 AND r.flg_activo = 1
        GROUP BY ur.id_usuario
    ) rc ON rc.id_usuario = u.id_usuario
    WHERE (COALESCE(TRIM(p_desc_usuario), '') = '' OR u.desc_usuario LIKE CONCAT('%', TRIM(p_desc_usuario), '%'))
      AND (p_id_estado IS NULL OR u.id_estado_usuario = p_id_estado)
      AND (p_id_acceso IS NULL OR u.id_acceso_usuario = p_id_acceso)
      AND (p_id_rol IS NULL OR EXISTS (
            SELECT 1 FROM t_usuario_rol ur
            WHERE ur.id_usuario = u.id_usuario
              AND ur.id_rol = p_id_rol
              AND ur.flg_activo = 1
          ))
      AND (v_nivel_logueado = 10 OR j.nivel_usuario > v_nivel_logueado)
    ORDER BY u.desc_usuario;
END$$
DELIMITER ;
