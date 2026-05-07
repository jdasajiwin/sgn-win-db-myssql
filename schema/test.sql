
DROP PROCEDURE  IF EXISTS  sp_hello_listar;

DELIMITER $$
CREATE PROCEDURE sp_hello_listar()
BEGIN
    SELECT
        desc_name,
        desc_hello_wordl
    FROM t_hello_wordl;
END$$

DELIMITER ;

-- ---

DROP PROCEDURE  IF EXISTS  sp_hello_add;

DELIMITER $$
CREATE PROCEDURE sp_hello_add(name VARCHAR(200),description VARCHAR(200))
BEGIN

    INSERT INTO t_hello_wordl VALUES(name,description);
END$$

DELIMITER ;

-- ---