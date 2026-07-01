DROP PROCEDURE IF EXISTS sps_t_usuarios_by_username;

DELIMITER $$
CREATE PROCEDURE sps_t_usuarios_by_username(
    IN p_desc_username VARCHAR(150)
)
BEGIN

	SELECT
		id_usuario,
		desc_usuario,
		desc_email,
		id_estado_usuario,
		id_acceso_usuario
	FROM t_usuarios
	WHERE desc_usuario = p_desc_username
	  AND flg_activo = 1;
    
END$$
DELIMITER ;
