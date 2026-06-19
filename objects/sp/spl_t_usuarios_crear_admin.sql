DROP PROCEDURE IF EXISTS spl_t_usuarios_crear_admin;

DELIMITER $$
CREATE PROCEDURE spl_t_usuarios_crear_admin(
	IN p_desc_usuario VARCHAR(255),
	IN p_desc_nombres VARCHAR(255),
	IN p_desc_apellidos VARCHAR(255),
	IN p_desc_email VARCHAR(255),
	IN p_desc_password VARCHAR(255),
	IN p_desc_tipo_login VARCHAR(50),
	IN p_id_estado_usuario INT,
	IN p_id_acceso_usuario INT,
	IN p_id_rol INT
)
BEGIN
	DECLARE v_id_usuario BIGINT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;

	START TRANSACTION;

	INSERT INTO t_usuarios (
		desc_usuario,
		desc_nombres,
		desc_apellidos,
		desc_email,
		desc_password,
		desc_tipo_login,
		id_estado_usuario,
		id_acceso_usuario
	) VALUES (
		p_desc_usuario,
		p_desc_nombres,
		p_desc_apellidos,
		p_desc_email,
		p_desc_password,
		p_desc_tipo_login,
		p_id_estado_usuario,
		p_id_acceso_usuario
	);

	SET v_id_usuario = LAST_INSERT_ID();

	INSERT INTO t_usuario_rol (
		id_rol,
		id_usuario,
		flg_activo
	) VALUES (
		p_id_rol,
		v_id_usuario,
		p_id_estado_usuario
	);

	COMMIT;

	SELECT
		v_id_usuario AS id_usuario,
		'Usuario creado correctamente' AS mensaje;
END$$
DELIMITER ;
