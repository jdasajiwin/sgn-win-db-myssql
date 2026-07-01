DROP PROCEDURE IF EXISTS sps_t_usuarios_autenticacion;

DELIMITER $$
CREATE PROCEDURE sps_t_usuarios_autenticacion(
    IN p_desc_email VARCHAR(150)
)
BEGIN

	SELECT
		desc_usuario,
		desc_nombres,
		desc_apellidos,
		desc_email,
		desc_password,
		id_estado_usuario,
		id_acceso_usuario,
		flg_activo
	FROM t_usuarios
	WHERE desc_email = p_desc_email
	  AND flg_activo = 1;
    
END$$
DELIMITER ;
