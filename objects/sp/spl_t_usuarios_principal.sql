DROP PROCEDURE IF EXISTS spl_t_usuarios_principal_listar;

DELIMITER $$
CREATE PROCEDURE spl_t_usuarios_principal_listar(
    IN p_desc_email VARCHAR(150)
)
BEGIN

	DECLARE v_countRol INT;
	DECLARE v_idUsuario INT; 
    
    DROP TABLE IF EXISTS tmp_result;
    CREATE TEMPORARY TABLE tmp_result
	ENGINE = MEMORY
	AS
	SELECT
		id_usuario,
		desc_email,
		id_estado
	FROM t_usuarios
	WHERE desc_email = p_desc_email
	  AND id_estado = 1;
      
  SET v_idUsuario=(SELECT id_usuario FROM tmp_result);
  SET v_countRol =(SELECT count(1) FROM t_usuario_rol WHERE id_usuario=v_idUsuario and id_estado=1);  
  
  SELECT TMR.*,v_countRol AS cant_roles FROM tmp_result AS TMR; 
    
END$$
DELIMITER ;
