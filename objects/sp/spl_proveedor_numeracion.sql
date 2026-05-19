DROP PROCEDURE  IF EXISTS  spl_proveedor_numeracion;
DELIMITER $$
CREATE PROCEDURE spl_proveedor_numeracion()
BEGIN
    SELECT
        id_proveedor_numeracion,
        nombre_proveedor
    FROM m_proveedor_numeracion;
END$$
DELIMITER ;