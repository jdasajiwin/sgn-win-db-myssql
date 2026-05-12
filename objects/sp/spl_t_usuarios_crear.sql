DROP PROCEDURE IF EXISTS spl_t_usuarios_crear;

-- Alta de usuario: solo parametriza datos de negocio; id_usuario por AUTO_INCREMENT;
-- desc_usuario_crea y fec_creacion por defecto de tabla; desc_usuario_modf y fec_modf quedan NULL.
-- Requiere t_usuarios con desc_usuario_modf y fec_modf aceptando NULL (ver schema_erflow.sql).

DELIMITER $$
CREATE PROCEDURE spl_t_usuarios_crear(
    IN p_desc_usuario VARCHAR(150),
    IN p_desc_nombres VARCHAR(255),
    IN p_desc_apellidos VARCHAR(255),
    IN p_desc_email VARCHAR(150),
    IN p_id_estado TINYINT
)
BEGIN

	 INSERT INTO t_usuarios (
			desc_usuario
			,desc_nombres
			,desc_apellidos
			,desc_email
			,id_estado
		)
	 VALUES (
			p_desc_usuario
			,p_desc_nombres
			,p_desc_apellidos
			,p_desc_email
			,p_id_estado
		);

	 SELECT LAST_INSERT_ID() AS id_usuario;

END$$
DELIMITER ;
