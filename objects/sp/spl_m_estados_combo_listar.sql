DROP PROCEDURE IF EXISTS spl_m_estados_combo_listar;

DELIMITER $$
CREATE PROCEDURE spl_m_estados_combo_listar(
    IN p_cod_tipo_estado VARCHAR(12)
)
BEGIN

	 SELECT  EST.id_estado
			,EST.cod_estado
			,EST.desc_estado
			,TIP.id_tipo_estado
			,TIP.cod_tipo_estado
			,TIP.desc_tipo_estado
     FROM m_estados AS EST
     INNER JOIN m_tipo_estado AS TIP
        ON EST.id_tipo_estado = TIP.id_tipo_estado
     WHERE EST.flg_activo = 1
       AND TIP.flc_activo = 1
       AND (
            p_cod_tipo_estado IS NULL
            OR TRIM(p_cod_tipo_estado) = ''
            OR TIP.cod_tipo_estado = p_cod_tipo_estado
           )
     ORDER BY TIP.cod_tipo_estado, EST.id_estado;

END$$
DELIMITER ;
