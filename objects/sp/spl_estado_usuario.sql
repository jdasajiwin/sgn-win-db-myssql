DROP PROCEDURE  IF EXISTS  spl_estado_usuario;
DELIMITER $$
CREATE PROCEDURE spl_estado_usuario()
BEGIN
    SELECT
        id_estado_usuario,
        desc_estado
    FROM m_estado_usuario
	WHERE flg_activo = 1;
END$$
DELIMITER ;
