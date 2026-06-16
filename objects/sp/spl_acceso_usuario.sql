DROP PROCEDURE  IF EXISTS  spl_acceso_usuario;
DELIMITER $$
CREATE PROCEDURE spl_acceso_usuario()
BEGIN
    SELECT
        id_acceso_usuario,
        desc_acceso
    FROM m_acceso_usuario
	WHERE flg_activo = 1; 
END$$
DELIMITER ;
