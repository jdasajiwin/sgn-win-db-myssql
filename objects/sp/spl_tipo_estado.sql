DROP PROCEDURE  IF EXISTS  spl_tipo_estado;
DELIMITER $$
CREATE PROCEDURE spl_tipo_estado(
IN p_id_estado INT
)
BEGIN
    SELECT
        id_estado,
        desc_estado
    FROM m_estados where id_tipo_estado=p_id_estado;
END$$
DELIMITER ;