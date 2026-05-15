DROP PROCEDURE IF EXISTS spi_trazabilidad;

DELIMITER $$
CREATE PROCEDURE spi_trazabilidad(
    IN p_id_usuario INT,
    IN p_id_menu INT,
    IN p_evento VARCHAR(100),
    IN p_detalle TEXT,
    IN p_datos_anteriores JSON,
    IN p_datos_nuevos JSON,
    IN p_ip_origen VARCHAR(45),
    IN p_creado_por_api TINYINT(1)
)
BEGIN
    INSERT INTO t_trazabilidad_eventos (
        id_usuario,
        id_menu,
        evento,
        detalle,
        datos_anteriores,
        datos_nuevos,
        ip_origen,
        creado_por_api
    ) VALUES (
        p_id_usuario,
        p_id_menu,
        p_evento,
        p_detalle,
        p_datos_anteriores,
        p_datos_nuevos,
        p_ip_origen,
        p_creado_por_api
    );

END$$
DELIMITER ;
