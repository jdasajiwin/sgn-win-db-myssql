DROP PROCEDURE  IF EXISTS  sp_tipo_estado_listar;
DELIMITER $$
CREATE PROCEDURE sp_tipo_estado_listar(
IN p_id_estado INT
)
BEGIN
    SELECT
        id_estado,
        desc_estado
    FROM m_estados where id_tipo_estado=p_id_estado;
END$$
DELIMITER ;