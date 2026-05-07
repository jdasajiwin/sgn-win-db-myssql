DROP PROCEDURE IF EXISTS spl_t_usuarios_principal_listar;

DELIMITER $$
CREATE PROCEDURE spl_t_usuarios_principal_listar(
    IN p_desc_email VARCHAR(150)
)
BEGIN
    SELECT
        id_usuario,
        desc_email,
        id_estado
    FROM t_usuarios
    WHERE desc_email = p_desc_email
      AND id_estado = 1;
END$$
DELIMITER ;
