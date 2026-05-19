DROP PROCEDURE  IF EXISTS  spl_detalle_template;
DELIMITER $$
CREATE PROCEDURE spl_detalle_template(
    IN p_id_evento INT
)
BEGIN
    SELECT detalle_template
    FROM m_eventos
    WHERE id_evento = p_id_evento;
END$$
DELIMITER ;