DROP PROCEDURE IF EXISTS spl_m_roles_menus_listar;

DELIMITER $$
CREATE PROCEDURE spl_m_roles_menus_listar(
    IN p_id_rol INT
)
BEGIN

	 SELECT  MNS.cod_menu
			,MNS.cod_sub_menu
			,MNS.desc_menu
			,desc_ruta 
     FROM m_roles_menus 		 AS MROL
     INNER JOIN m_menus			 AS MNS
     ON MROL.id_menu=MNS.id_menu
     WHERE MROL.id_estado=1
		AND MNS.id_estado=1
        AND MROL.id_rol=p_id_rol;
    
END$$
DELIMITER ;
