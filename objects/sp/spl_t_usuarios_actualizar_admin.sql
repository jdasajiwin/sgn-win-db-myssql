DROP PROCEDURE IF EXISTS spl_t_usuarios_actualizar_admin;

DELIMITER $$

CREATE PROCEDURE spl_t_usuarios_actualizar_admin(
    IN p_id_usuario INT,
    IN p_desc_usuario VARCHAR(255),
    IN p_desc_nombres VARCHAR(255),
    IN p_desc_apellidos VARCHAR(255),
    IN p_desc_email VARCHAR(255),
    IN p_id_estado_usuario INT,
    IN p_id_acceso_usuario INT,
    IN p_id_rol INT
)
BEGIN
    DECLARE v_id_usuario_rol INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    UPDATE t_usuarios
    SET
        desc_usuario = p_desc_usuario,
        desc_nombres = p_desc_nombres,
        desc_apellidos = p_desc_apellidos,
        desc_email = p_desc_email,
        id_estado_usuario = p_id_estado_usuario,
        id_acceso_usuario = p_id_acceso_usuario
    WHERE id_usuario = p_id_usuario;

    SELECT id_usuario_rol INTO v_id_usuario_rol
    FROM t_usuario_rol
    WHERE id_usuario = p_id_usuario
    LIMIT 1;

    IF v_id_usuario_rol IS NULL THEN
        INSERT INTO t_usuario_rol (id_rol, id_usuario, flg_activo)
        VALUES (p_id_rol, p_id_usuario, p_id_estado_usuario);
    ELSE
        UPDATE t_usuario_rol
        SET id_rol = p_id_rol
        WHERE id_usuario_rol = v_id_usuario_rol;
    END IF;

    COMMIT;

    SELECT p_id_usuario AS id_usuario, 'Usuario actualizado correctamente' AS mensaje;
END$$

DELIMITER ;
