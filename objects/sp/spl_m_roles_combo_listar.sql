DROP PROCEDURE IF EXISTS spl_m_roles_combo_listar;

DELIMITER $$
CREATE PROCEDURE spl_m_roles_combo_listar()
BEGIN

	 SELECT  RL.id_rol
			,RL.cod_rol
			,RL.desc_rol
     FROM m_roles AS RL
     WHERE RL.id_estado = 1
     ORDER BY RL.id_rol;

END$$
DELIMITER ;
