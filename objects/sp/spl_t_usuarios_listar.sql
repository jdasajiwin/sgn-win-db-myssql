DROP PROCEDURE IF EXISTS spl_t_usuarios_listar;

DELIMITER $$
CREATE PROCEDURE spl_t_usuarios_listar(
    IN p_desc_usuario VARCHAR(150),
    IN p_id_rol INT,
    IN p_id_estado TINYINT,
    IN p_id_acceso TINYINT
)
BEGIN

    SELECT
        u.id_usuario,
        u.desc_usuario,
        u.desc_nombres,
        u.desc_apellidos,
        u.desc_email,
        u.desc_tipo_login,
        u.id_estado_usuario,
        CASE u.id_estado_usuario
            WHEN 1 THEN 'Activo'
            WHEN 2 THEN 'Bloqueado'
            ELSE NULL
        END AS desc_estado,
        (
            SELECT GROUP_CONCAT(DISTINCT r.desc_rol ORDER BY r.desc_rol SEPARATOR ', ')
            FROM t_usuario_rol ur
            INNER JOIN m_roles r
                ON r.id_rol = ur.id_rol
            WHERE ur.id_usuario = u.id_usuario
              AND ur.flg_activo = 1
              AND r.flg_activo = 1
        ) AS roles
    FROM t_usuarios u
    WHERE
        (
            p_desc_usuario IS NULL
            OR TRIM(p_desc_usuario) = ''
            OR u.desc_usuario LIKE CONCAT('%', TRIM(p_desc_usuario), '%')
        )
        AND (
            p_id_estado IS NULL
            OR u.id_estado_usuario = p_id_estado
        )
        AND (
            p_id_acceso IS NULL
            OR u.id_acceso_usuario = p_id_acceso
        )
        AND (
            p_id_rol IS NULL
            OR EXISTS (
                SELECT 1
                FROM t_usuario_rol ur
                WHERE ur.id_usuario = u.id_usuario
                  AND ur.id_rol = p_id_rol
                  AND ur.flg_activo = 1
            )
        )
        AND u.desc_tipo_login = 'AD'
    ORDER BY u.desc_usuario;

END$$
DELIMITER ;
