DROP PROCEDURE  IF EXISTS  spl_tipo_zona;
DELIMITER $$
CREATE PROCEDURE spl_tipo_zona()
BEGIN
    SELECT
        id_tipo_zona,
        nombre_tipo_zona
    FROM m_tipo_zona;
END$$
DELIMITER ;