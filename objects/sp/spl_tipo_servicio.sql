DROP PROCEDURE  IF EXISTS  spl_tipo_servicio;
DELIMITER $$
CREATE PROCEDURE spl_tipo_servicio()
BEGIN
    SELECT
        id_tipo_servicio,
        desc_tipo_servicio
    FROM m_tipo_servicio;
END$$
DELIMITER ;
