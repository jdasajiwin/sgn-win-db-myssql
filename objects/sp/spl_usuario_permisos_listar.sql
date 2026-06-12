-- Stored Procedure para listar los permisos de un usuario
-- Obtiene todos los permisos asociados a los roles del usuario
DELIMITER //

DROP PROCEDURE IF EXISTS spl_usuario_permisos_listar //

CREATE PROCEDURE spl_usuario_permisos_listar(
    IN p_id_rol INT
)
BEGIN
    SELECT DISTINCT
        p.cod_permiso,
        p.desc_accion,
        p.desc_permiso,
    FROM m_roles_permisos rp
    INNER JOIN m_permisos p ON p.id_permiso = rp.id_permiso
    WHERE rp.id_rol = p_id_rol
        AND rp.flg_activo = 1
        AND p.flg_activo = 1
    ORDER BY p.desc_modulo, p.desc_submodulo, p.desc_accion;
END //

DELIMITER ;
