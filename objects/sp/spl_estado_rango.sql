DROP PROCEDURE  IF EXISTS  spl_estado_rango;
DELIMITER $$
CREATE PROCEDURE spl_estado_rango()
BEGIN
    SELECT
        id_estado_rango,
        desc_estado_rango
    FROM m_estado_rango;
END$$
DELIMITER ;