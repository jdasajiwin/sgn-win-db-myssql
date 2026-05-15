DROP PROCEDURE  IF EXISTS  spl_departamento;
DELIMITER $$
CREATE PROCEDURE spl_departamento()
BEGIN
    SELECT
        id_departamento,
        nombre_departamento,
        cod_ubigeo_departamento,
        cod_tel_departamento,
        cobertura_departamento
    FROM m_departamento;
END$$
DELIMITER ;