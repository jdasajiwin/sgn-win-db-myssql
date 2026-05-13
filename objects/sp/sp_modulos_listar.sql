DROP PROCEDURE IF EXISTS sp_modulos_listar;
DELIMITER $$

CREATE PROCEDURE sp_modulos_listar(
    IN p_cod_menu INT
)
BEGIN
    SELECT
        id_menu,
        cod_menu,
        desc_menu,
        fec_creacion,
        fec_modf,
        desc_usuario_crea,
        desc_usuario_modf
    FROM sgn.m_menus
    WHERE id_sub_menu IS NULL
      AND id_estado = 1
      AND (p_cod_menu IS NULL OR cod_menu = p_cod_menu);
END$$

DELIMITER ;