DROP PROCEDURE  IF EXISTS  spl_proveedor_numeracion;
DELIMITER $$
CREATE PROCEDURE spl_proveedor_numeracion()
BEGIN
    SELECT
        id_proveedor_numeracion,
        desc_proveedor_numeracion
    FROM m_proveedor_numeracion;
END$$
DELIMITER ;