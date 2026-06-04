DROP PROCEDURE IF EXISTS spl_m_roles_listar;

DELIMITER $$
CREATE PROCEDURE spl_m_roles_listar(
    IN p_id_usuario INT
)
BEGIN

	 SELECT  TUR.id_rol
			 ,RL.cod_rol
             ,RL.desc_rol
     FROM t_usuario_rol AS TUR
     INNER JOIN m_roles AS RL
     ON TUR.id_rol=RL.id_rol
     WHERE TUR.flg_activo=1
     AND RL.flg_activo=1
     AND TUR.id_usuario=p_id_usuario;
END$$
DELIMITER ;
