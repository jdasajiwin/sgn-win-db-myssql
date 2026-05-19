DROP PROCEDURE  IF EXISTS  spl_comercializador;
DELIMITER $$
CREATE PROCEDURE spl_comercializador()
BEGIN
    SELECT
        id_comercializador,
        nombre_comercializador
    FROM m_comercializador;
END$$
DELIMITER ;