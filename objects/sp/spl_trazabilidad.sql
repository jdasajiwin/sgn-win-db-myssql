DROP PROCEDURE IF EXISTS spl_trazabilidad;
DELIMITER $$

CREATE PROCEDURE spl_trazabilidad(
    IN p_fecha_desde DATETIME,
    IN p_fecha_hasta DATETIME,
    IN p_id_modulo INT,
    IN p_usuario VARCHAR(200)
)
BEGIN

    SELECT 
        tr.id_trazabilidad,
        tr.evento,
        tr.detalle,
        tr.fec_registro,
        tr.ip_origen,
        tr.creado_por_api,

        u.id_usuario,
        u.desc_nombres,
        u.desc_apellidos,
        CONCAT(u.desc_nombres, ' ', u.desc_apellidos) AS usuario_completo,

        m.desc_menu AS submodulo,

        CASE
            WHEN mp.desc_menu IS NOT NULL THEN mp.desc_menu
            ELSE m.desc_menu
        END AS modulo_principal

    FROM t_trazabilidad_eventos tr

    INNER JOIN t_usuarios u
        ON u.id_usuario = tr.id_usuario

    INNER JOIN m_menus m
        ON m.id_menu = tr.id_menu

    LEFT JOIN m_menus mp
        ON mp.id_menu = m.id_sub_menu

    WHERE
        (
            p_fecha_desde IS NULL
            OR tr.fec_registro >= p_fecha_desde
        )

        AND (
            p_fecha_hasta IS NULL
            OR tr.fec_registro <= p_fecha_hasta
        )

        AND (
            p_id_modulo IS NULL
            OR tr.id_menu = p_id_modulo
        )

        AND (
            p_usuario IS NULL
            OR CONCAT(u.desc_nombres, ' ', u.desc_apellidos)
                LIKE CONCAT('%', p_usuario, '%')
        )

    ORDER BY tr.fec_registro DESC;

END$$

DELIMITER ;