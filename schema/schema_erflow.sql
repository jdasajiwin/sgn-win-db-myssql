-- Script alineado a schema_erflow.dbml (ER Flow)
-- MySQL / InnoDB
-- Nota: PK de m_opciones es (id_opcion, id_menu) para AUTO_INCREMENT en MySQL; FK usa UNIQUE (id_menu, id_opcion).

SET FOREIGN_KEY_CHECKS = 0;


DROP TABLE IF EXISTS m_menus_permisos;
DROP TABLE IF exists m_roles_permisos;
DROP TABLE IF exists m_permisos;
DROP TABLE IF EXISTS m_operador;
DROP TABLE IF EXISTS m_estado_numero;
DROP TABLE IF EXISTS m_tipo_documento;
DROP TABLE IF EXISTS m_estado_portabilidad;
DROP TABLE IF EXISTS m_motivo_rechazo;
DROP TABLE IF EXISTS m_plan_telefonia;
DROP TABLE IF EXISTS m_motivo_cambio;
DROP TABLE IF EXISTS m_roles_menus;
DROP TABLE IF EXISTS m_roles_opciones;
DROP TABLE IF EXISTS m_opciones;
DROP TABLE IF EXISTS m_menus;
DROP TABLE IF EXISTS m_roles;
DROP TABLE IF EXISTS t_auditoria;
DROP TABLE IF EXISTS m_tipo_evento;
DROP TABLE IF EXISTS m_eventos;
DROP TABLE IF EXISTS m_estados;
DROP TABLE IF EXISTS m_tipo_estado;
DROP TABLE IF EXISTS t_trazabilidad_eventos;
DROP TABLE IF EXISTS m_proveedor_numeracion;
DROP TABLE IF EXISTS m_comercializador;
DROP TABLE IF EXISTS m_estado_rango;
DROP TABLE IF EXISTS m_departamento;
DROP TABLE IF EXISTS m_tipo_servicio;
DROP TABLE IF EXISTS m_tipo_zona;
DROP TABLE IF EXISTS t_usuario_rol;
DROP TABLE IF EXISTS t_usuarios;
DROP TABLE IF EXISTS m_estado_usuario;
DROP TABLE IF EXISTS m_acceso_usuario;
DROP TABLE IF EXISTS t_rango_numeracion;
DROP TABLE IF EXISTS t_historial_numero;
DROP TABLE IF EXISTS t_numero_telefonico;
DROP TABLE IF EXISTS t_numero_adjunto;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE IF NOT EXISTS `m_estado_proceso` (
    `id_estado_proceso` INT PRIMARY KEY AUTO_INCREMENT,
    `desc_estado` VARCHAR(50),
    `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `fec_modf` DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `flg_activo` BIT NOT NULL DEFAULT 1
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_operador` (
    `id_operador` SMALLINT PRIMARY KEY AUTO_INCREMENT,
    `desc_operador` VARCHAR(150) NOT NULL,
    `cod_enrutador` VARCHAR(20),
    `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `fec_modf` DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `flg_activo` BIT NOT NULL DEFAULT 1
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_motivo_rechazo` (
    `id_motivo_rechazo` SMALLINT PRIMARY KEY AUTO_INCREMENT,
    `desc_motivo_rechazo` VARCHAR(50),
    `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `fec_modf` DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `flg_activo` BIT NOT NULL DEFAULT 1
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_estado_portabilidad` (
    `id_estado_portabilidad` SMALLINT PRIMARY KEY AUTO_INCREMENT,
    `desc_estado_portabilidad` VARCHAR(50),
    `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `fec_modf` DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `flg_activo` BIT NOT NULL DEFAULT 1
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_plan_telefonia` (
    `id_plan_telefonia` SMALLINT PRIMARY KEY AUTO_INCREMENT,
    `desc_plan_telefonia` VARCHAR(150),
    `desc_tarifa_asignada` VARCHAR(50),
    `cant_saldo_inicial` TINYINT(4) UNSIGNED,
    `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `fec_modf` DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `flg_activo` BIT NOT NULL DEFAULT 1
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_motivo_rechazo` (
    `id_motivo_rechazo` SMALLINT PRIMARY KEY AUTO_INCREMENT,
    `desc_motivo_rechazo` VARCHAR(50),
    `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    `fec_modf` DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `flg_activo` BIT NOT NULL DEFAULT 1
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_motivo_cambio` (
    `id_motivo_cambio` SMALLINT PRIMARY KEY AUTO_INCREMENT,
    `desc_motivo_cambio` VARCHAR(50),
    `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    `fec_modf` DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `flg_activo` BIT NOT NULL DEFAULT 1
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_estado_numero` (
    `id_estado_numero` SMALLINT PRIMARY KEY AUTO_INCREMENT,
    `desc_estado_numero` VARCHAR(50),
    `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `fec_modf` DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `flg_activo` BIT NOT NULL DEFAULT 1
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_estado_usuario` (
    `id_estado_usuario` TINYINT PRIMARY KEY AUTO_INCREMENT,
    `desc_estado` VARCHAR(50),
    `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `fec_modf` DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `flg_activo` BIT NOT NULL DEFAULT 1
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_acceso_usuario` (
    `id_acceso_usuario` TINYINT PRIMARY KEY AUTO_INCREMENT,
    `desc_acceso` VARCHAR(50),
    `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `fec_modf` DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `flg_activo` BIT NOT NULL DEFAULT 1
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_tipo_documento` (
    `id_tipo_doc` SMALLINT PRIMARY KEY AUTO_INCREMENT,
    `desc_tipo_doc` VARCHAR(50),
    `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `fec_modf` DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `flg_activo` BIT NOT NULL DEFAULT 1
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_tipo_servicio` (
  `id_tipo_servicio` int NOT NULL AUTO_INCREMENT,
  `desc_tipo_servicio` varchar(255) NOT NULL,
  `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fec_modf` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flg_activo` BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_tipo_servicio`)
) ENGINE=InnoDB ;


CREATE TABLE IF NOT EXISTS `m_tipo_zona` (
  `id_tipo_zona` int NOT NULL AUTO_INCREMENT,
  `desc_tipo_zona` varchar(255) NOT NULL,
  `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fec_modf` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flg_activo` BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_tipo_zona`)
) ENGINE=InnoDB ;

CREATE TABLE IF NOT EXISTS `m_proveedor_numeracion` (
  `id_proveedor_numeracion` int NOT NULL AUTO_INCREMENT,
  `desc_proveedor_numeracion` varchar(255) NOT NULL,
  `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fec_modf` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flg_activo` BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_proveedor_numeracion`)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `m_comercializador` (
  `id_comercializador` int NOT NULL AUTO_INCREMENT,
  `desc_comercializador` varchar(255) NOT NULL,
  `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fec_modf` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flg_activo` BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_comercializador`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_estado_rango` (
  `id_estado_rango` int NOT NULL AUTO_INCREMENT,
  `desc_estado_rango` varchar(255) NOT NULL,
  `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fec_modf` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flg_activo` BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_estado_rango`)
) ENGINE=InnoDB ;

CREATE TABLE IF NOT EXISTS `m_tipo_estado` (
  `id_tipo_estado` int NOT NULL AUTO_INCREMENT,
  `cod_tipo_estado` varchar(12) NOT NULL,
  `desc_tipo_estado` varchar(255) NOT NULL,
  `flg_activo` BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_tipo_estado`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_estados` (
  `id_estado` TINYINT NOT NULL,
  `id_tipo_estado` INT NOT NULL,
  `cod_estado` VARCHAR(12) NOT NULL,
  `desc_estado` VARCHAR(50) NOT NULL,
  `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  `fec_creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fec_modf` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flg_activo` BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_estado`),
  UNIQUE KEY `uq_m_estados_cod_estado` (`cod_estado`),
  CONSTRAINT `fk_m_tipo_estado_m_estados`
    FOREIGN KEY (`id_tipo_estado`) REFERENCES `m_tipo_estado` (`id_tipo_estado`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_tipo_evento` (
  `id_tipo_evento` SMALLINT NOT NULL AUTO_INCREMENT,
  -- `cod_tipo_evento` varchar(12) NOT NULL,
  `desc_tipo_evento` varchar(255) NOT NULL,
  `desc_usuario_crea` VARCHAR(50) NOT NULL,
  `desc_usuario_modf` VARCHAR(50) NOT NULL,
  `flg_activo` BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_tipo_evento`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_eventos` (
  `id_evento` INT NOT NULL AUTO_INCREMENT,
  `cod_evento` VARCHAR(50) NOT NULL,
  `desc_evento` VARCHAR(255) NOT NULL,
  `detalle_template` VARCHAR(500) NOT NULL,
  -- `id_tipo_evento` SMALLINT NOT NULL,
  `tipo_evento` ENUM('FORMULARIO', 'API', 'JOB', 'OTRO') NOT NULL DEFAULT 'OTRO',
  `desc_usuario_crea` VARCHAR(50) NOT NULL,
  `desc_usuario_modf` VARCHAR(50) NOT NULL,
  `fec_creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fec_modf` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flg_activo` BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_evento`),
  UNIQUE KEY `uq_m_eventos_cod_evento` (`cod_evento`),
  KEY `ix_m_eventos_tipo_evento` (`tipo_evento`)
  -- CONSTRAINT `fk_m_tipo_evento_m_eventos`
  --  FOREIGN KEY (`id_tipo_evento`)
  --  REFERENCES `m_tipo_evento` (`id_tipo_evento`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_auditoria (
    `id_auditoria` BIGINT PRIMARY KEY AUTO_INCREMENT,
    `id_evento` INT NOT NULL,
    `desc_modulo` VARCHAR(100) NOT NULL,
    `desc_accion` VARCHAR(50) NOT NULL,
    `desc_detalle_accion` TEXT NOT NULL,
    `usuario_accion` VARCHAR(100),
    `desc_usuario_crea` VARCHAR(50) NOT NULL,
    `desc_usuario_modf` VARCHAR(50) NOT NULL,
    `fec_creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `fec_modf` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `flg_activo` BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (id_evento)
        REFERENCES m_eventos(id_evento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS m_departamento (
  `id_departamento` int NOT NULL AUTO_INCREMENT,
  `desc_departamento` varchar(150) NOT NULL,
  `cod_ubigeo_departamento` char(10) NOT NULL,
  `cod_tel_departamento` char(10) NOT NULL,
  `cobertura_departamento` char(10) NOT NULL,
  `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fec_modf` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flg_activo` BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_departamento`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS m_menus (
  id_menu INT NOT NULL AUTO_INCREMENT,
  cod_menu VARCHAR(12) NOT NULL,
  cod_sub_menu VARCHAR(12) NULL,
  id_menu_padre INT NULL,
  desc_menu VARCHAR(150) NOT NULL,
  desc_ruta VARCHAR(200) NOT NULL,
  desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  desc_usuario_modf VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  flg_activo BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_menu),
  UNIQUE KEY uq_m_menus_cod_menu (cod_menu)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS m_opciones (
  id_menu INT NOT NULL,
  id_opcion INT NOT NULL AUTO_INCREMENT,
  cod_menu VARCHAR(12) NOT NULL,
  desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  desc_usuario_modf VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  desc_opcion VARCHAR(150) NOT NULL,
  desc_ruta VARCHAR(200) NOT NULL,
  flg_activo BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_opcion, id_menu),
  UNIQUE KEY uq_m_opciones_menu_opcion (id_menu, id_opcion),
  UNIQUE KEY uq_m_opciones_cod_menu (cod_menu),
  CONSTRAINT fk_m_menus_m_opciones
    FOREIGN KEY (id_menu) REFERENCES m_menus (id_menu)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS m_roles (
  id_rol INT NOT NULL AUTO_INCREMENT,
  cod_rol VARCHAR(12) NOT NULL,
  desc_rol VARCHAR(150) NOT NULL,
  desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  desc_usuario_modf VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  flg_activo BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_rol),
  UNIQUE KEY uq_m_roles_cod_rol (cod_rol)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS m_roles_menus (
  id_rol_menu INT NOT NULL AUTO_INCREMENT,
  id_rol INT NOT NULL,
  id_menu INT NOT NULL,
  desc_usuario_crea VARCHAR(255) NOT NULL,
  desc_usuario_modf VARCHAR(255) NOT NULL,
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  flg_activo BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_rol_menu),
  UNIQUE KEY uq_m_roles_menus_id_rol_menu (id_rol_menu),
  KEY ix_m_roles_menus_id_rol (id_rol),
  KEY ix_m_roles_menus_id_menu (id_menu),
  CONSTRAINT fk_m_roles_m_roles_menus
    FOREIGN KEY (id_rol) REFERENCES m_roles (id_rol),
  CONSTRAINT fk_m_menus_m_roles_menus
    FOREIGN KEY (id_menu) REFERENCES m_menus (id_menu)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_usuarios (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  desc_nombres VARCHAR(255) NOT NULL,
  desc_apellidos VARCHAR(255) NOT NULL,
  desc_usuario VARCHAR(150) NOT NULL,
  desc_email VARCHAR(150) NOT NULL,
  desc_password VARCHAR(150) NULL,
  desc_tipo_login VARCHAR(50) NULL DEFAULT 'AD',
  desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  desc_usuario_modf VARCHAR(50) NULL,
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  id_estado TINYINT NOT NULL DEFAULT 1,
  id_acceso TINYINT NOT NULL DEFAULT 1,
  flg_activo BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_usuario),
  UNIQUE KEY uq_t_usuarios_desc_usuario (desc_usuario),
  UNIQUE KEY uq_t_usuarios_desc_email (desc_email),
  CONSTRAINT fk_m_estado_usuario_t_usuarios
    FOREIGN KEY (id_estado) REFERENCES m_estado_usuario (id_estado_usuario),
  CONSTRAINT fk_m_acceso_usuario_t_usuarios
    FOREIGN KEY (id_acceso) REFERENCES m_acceso_usuario (id_acceso_usuario)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS m_roles_opciones (
  id_rol_opcion INT NOT NULL AUTO_INCREMENT,
  id_rol INT NOT NULL,
  id_opcion INT NOT NULL,
  id_menu INT NOT NULL,
  desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  desc_usuario_modf VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id_rol_opcion),
  KEY ix_m_roles_opciones_id_rol (id_rol),
  KEY ix_m_roles_opciones_menu_opcion (id_menu, id_opcion),
  CONSTRAINT fk_m_roles_m_roles_opciones
    FOREIGN KEY (id_rol) REFERENCES m_roles (id_rol),
  CONSTRAINT fk_m_opciones_m_roles_opciones
    FOREIGN KEY (id_menu, id_opcion) REFERENCES m_opciones (id_menu, id_opcion)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS m_permisos (
  id_permiso INT NOT NULL AUTO_INCREMENT,
  cod_permiso VARCHAR(50) NOT NULL,
  desc_modulo VARCHAR(100) NOT NULL,
  desc_submodulo VARCHAR(100) NULL,
  desc_accion VARCHAR(100) NOT NULL,
  desc_permiso VARCHAR(255) NULL,
  desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  desc_usuario_modf VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  flg_activo BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_permiso),
  UNIQUE KEY uq_m_permisos_cod_permiso (cod_permiso),
  KEY ix_m_permisos_modulo_submodulo (desc_modulo, desc_submodulo),
  KEY ix_m_permisos_accion (desc_accion)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS m_roles_permisos (
  id_rol_permiso INT NOT NULL AUTO_INCREMENT,
  id_rol INT NOT NULL,
  id_permiso INT NOT NULL,
  desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  desc_usuario_modf VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  flg_activo BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_rol_permiso),
  UNIQUE KEY uq_m_roles_permisos_rol_permiso (id_rol, id_permiso),
  KEY ix_m_roles_permisos_id_rol (id_rol),
  KEY ix_m_roles_permisos_id_permiso (id_permiso),
  CONSTRAINT fk_m_roles_m_roles_permisos
    FOREIGN KEY (id_rol) REFERENCES m_roles (id_rol),
  CONSTRAINT fk_m_permisos_m_roles_permisos
    FOREIGN KEY (id_permiso) REFERENCES m_permisos (id_permiso)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS m_menus_permisos (
  id_menu_permiso INT NOT NULL AUTO_INCREMENT,
  id_menu INT NOT NULL,
  id_permiso INT NOT NULL,
  desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  desc_usuario_modf VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  flg_activo BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_menu_permiso),
  UNIQUE KEY uq_m_menus_permisos_menu_permiso (id_menu, id_permiso),
  KEY ix_m_menus_permisos_id_menu (id_menu),
  KEY ix_m_menus_permisos_id_permiso (id_permiso),
  CONSTRAINT fk_m_menus_m_menus_permisos
    FOREIGN KEY (id_menu) REFERENCES m_menus (id_menu),
  CONSTRAINT fk_m_permisos_m_menus_permisos
    FOREIGN KEY (id_permiso) REFERENCES m_permisos (id_permiso)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_usuario_rol (
  `id_usuario_rol` INT NOT NULL AUTO_INCREMENT,
  `id_rol` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
  `fec_creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fec_modf` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `flg_activo` BIT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_usuario_rol`),
  UNIQUE KEY uq_t_usuario_rol_id_usuario_rol (id_usuario_rol),
  KEY ix_t_usuario_rol_id_rol (id_rol),
  KEY ix_t_usuario_rol_id_usuario (id_usuario),
  CONSTRAINT fk_m_roles_t_usuario_rol
    FOREIGN KEY (id_rol) REFERENCES m_roles (id_rol),
  CONSTRAINT fk_t_usuarios_t_usuario_rol
    FOREIGN KEY (id_usuario) REFERENCES t_usuarios (id_usuario)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `t_trazabilidad_eventos` (
  `id_trazabilidad` BIGINT NOT NULL AUTO_INCREMENT,
  `id_evento` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_menu` INT NOT NULL,
  `detalle` TEXT NULL,
  `fec_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip_origen` VARCHAR(45) NULL,
  `creado_por_api` BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id_trazabilidad`),
  KEY `ix_t_trazabilidad_eventos_id_evento` (`id_evento`),
  KEY `ix_t_trazabilidad_eventos_id_usuario` (`id_usuario`),
  KEY `ix_t_trazabilidad_eventos_fec_registro` (`fec_registro`),
  KEY `ix_t_trazabilidad_eventos_creado_por_api` (`creado_por_api`),
  CONSTRAINT `fk_t_trazabilidad_eventos_evento`
    FOREIGN KEY (`id_evento`)
    REFERENCES `m_eventos` (`id_evento`),
  CONSTRAINT `fk_t_trazabilidad_eventos_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `t_usuarios` (`id_usuario`),
  CONSTRAINT `fk_t_trazabilidad_eventos_menu`
    FOREIGN KEY (`id_menu`)
    REFERENCES `m_menus` (`id_menu`)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS t_rango_numeracion (
    `id_rango` BIGINT PRIMARY KEY AUTO_INCREMENT,
    `id_tipo_servicio` INT NOT NULL, 
    `id_departamento` INT NOT NULL,
    `id_tipo_zona` INT NOT NULL,
    `id_proveedor_numeracion` INT NOT NULL,
    `id_comercializador` INT NOT NULL,
    `cant_numeros_generados` INT NOT NULL,
    `num_rango_inicial` BIGINT NOT NULL,
    `num_rango_final` BIGINT NOT NULL,
    `fec_creacion_rango` DATETIME NOT NULL,
    `id_estado_rango` INT NOT NULL,
    `id_estado_proceso` INT DEFAULT 1,
    `cant_total_generados` INT DEFAULT 0,
    `cant_total_error` INT DEFAULT 0,
    `fec_inicio_proceso` DATETIME NULL,
    `fec_fin_proceso` DATETIME NULL,
    `id_usuario_creacion` INT NOT NULL,
    `id_usuario_modificacion` INT NOT NULL,
    `desc_usuario_crea` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `desc_usuario_modf` VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    `fec_creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `fec_modf` DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    `nom_app` VARCHAR(100),
    `flg_activo` BIT NOT NULL DEFAULT 1,
    `nom_app_modf` VARCHAR(100),
    CONSTRAINT fk_m_tipo_servicio_t_rango_numeracion FOREIGN KEY (id_tipo_servicio)
        REFERENCES m_tipo_servicio(id_tipo_servicio)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_m_departamento_t_rango_numeracion FOREIGN KEY (id_departamento)
        REFERENCES m_departamento(id_departamento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_m_tipo_zona_t_rango_numeracion FOREIGN KEY (id_tipo_zona)
        REFERENCES m_tipo_zona(id_tipo_zona)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_m_proveedor_numeracion_t_rango_numeracion FOREIGN KEY (id_proveedor_numeracion)
        REFERENCES m_proveedor_numeracion(id_proveedor_numeracion)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_m_comercializador_t_rango_numeracion FOREIGN KEY (id_comercializador)
        REFERENCES m_comercializador(id_comercializador)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_m_estado_rango_t_rango_numeracion FOREIGN KEY (id_estado_rango)
        REFERENCES m_estado_rango(id_estado_rango)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_m_estado_proceso_t_rango_numeracion FOREIGN KEY (id_estado_proceso)
        REFERENCES m_estado_proceso(id_estado_proceso)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_t_usuarios_t_rango_numeracion FOREIGN KEY (id_usuario_creacion)
        REFERENCES t_usuarios(id_usuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS t_numero_telefonico (
    id_numero_telefonico BIGINT PRIMARY KEY AUTO_INCREMENT,
    id_rango BIGINT NOT NULL,
    desc_numero_telefono VARCHAR(20) NOT NULL,
    facil_recordacion TINYINT(1) DEFAULT 0,
    cod_pedido VARCHAR(100),
    id_suscriptor VARCHAR(100),
    id_cliente_freeswitch VARCHAR(100),
    id_tipo_doc SMALLINT,
    desc_numero_documento VARCHAR(30),
    id_operador_cedente SMALLINT NOT NULL,
    id_operador_receptor SMALLINT NOT NULL,
    fec_activacion DATETIME,
    fec_port_in DATETIME,
    fec_port_out DATETIME,
    num_dias_reserva INT,
    fec_baja DATETIME,
    id_motivo_cambio SMALLINT,
    id_estado_numero SMALLINT NOT NULL,
    id_plan_telefonia SMALLINT,
    id_usuario_creacion INT NOT NULL,
    id_usuario_modificacion INT NOT NULL,
    desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    desc_usuario_modf VARCHAR(50) NOT NULL DEFAULT "Super Admin",
    fec_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fec_modf DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY ix_t_numero_telefonico_desc_numero_telefono (desc_numero_telefono),
    CONSTRAINT fk_t_rango_numeracion_t_numero_telefonico FOREIGN KEY (id_rango)
        REFERENCES t_rango_numeracion(id_rango)
         ON DELETE RESTRICT
         ON UPDATE CASCADE,
    CONSTRAINT fk_m_estado_numero_t_numero_telefonico FOREIGN KEY (id_estado_numero)
        REFERENCES m_estado_numero(id_estado_numero)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_m_plan_telefonico_t_numero_telefonico FOREIGN KEY (id_plan_telefonia)
        REFERENCES m_plan_telefonia(id_plan_telefonia)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_m_tipo_documento_t_numero_telefonico FOREIGN KEY (id_tipo_doc)
        REFERENCES m_tipo_documento(id_tipo_doc)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_m_operador_t_numero_telefonico FOREIGN KEY (id_operador_cedente)
        REFERENCES m_operador(id_operador)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_m_operador_t_numero_telefonico_receptor FOREIGN KEY (id_operador_receptor)
        REFERENCES m_operador(id_operador)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_m_motivo_cambio_t_numero_telefonico FOREIGN KEY (id_motivo_cambio)
        REFERENCES m_motivo_cambio(id_motivo_cambio)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_historial_numero (
    id_historial BIGINT PRIMARY KEY AUTO_INCREMENT,
    id_numero_telefonico BIGINT NOT NULL,
    estado_anterior INT,
    estado_nuevo INT,
    motivo VARCHAR(255),
    usuario VARCHAR(100),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_t_numero_telefonico_t_historial_numero FOREIGN KEY (id_numero_telefonico) REFERENCES t_numero_telefonico(id_numero_telefonico)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_numero_adjunto (
    id_adjunto BIGINT PRIMARY KEY AUTO_INCREMENT,
    id_numero_telefonico BIGINT NOT NULL,
    desc_nombre_archivo VARCHAR(255),
    desc_ruta_archivo VARCHAR(500),
    fec_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fec_modf DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    id_usuario_creacion INT NOT NULL,
    CONSTRAINT fk_t_numero_telefonico_t_numero_adjunto FOREIGN KEY (id_numero_telefonico) REFERENCES t_numero_telefonico(id_numero_telefonico)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
)ENGINE=InnoDB;

-- win_sgn_db.app_security_settings definition
CREATE TABLE IF NOT EXISTS `app_security_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- win_sgn_db.app_user_sessions definition
CREATE TABLE IF NOT EXISTS `app_user_sessions` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_usuario` bigint unsigned NOT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `last_activity_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `invalidated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_user_sessions_id_usuario_index` (`id_usuario`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE INDEX ix_t_numero_telefonico_id_estado_numero
ON t_numero_telefonico(id_estado_numero);
CREATE INDEX ix_t_numero_telefonico_id_rango
ON t_numero_telefonico(id_rango);
CREATE INDEX ix_t_numero_telefonico_id_tipo_doc
ON t_numero_telefonico(id_tipo_doc);
CREATE INDEX ix_t_numero_telefonico_id_operador_cedente
ON t_numero_telefonico(id_operador_cedente);
CREATE INDEX ix_t_numero_telefonico_id_operador_receptor
ON t_numero_telefonico(id_operador_receptor);
CREATE INDEX ix_t_numero_telefonico_id_motivo_cambio
ON t_numero_telefonico(id_motivo_cambio);
CREATE INDEX ix_t_rango_numeracion_num_rango_inicial_num_rango_final
ON t_rango_numeracion(num_rango_inicial, num_rango_final);


CREATE INDEX ix_t_historial_numero_id_numero_telefonico
ON t_historial_numero(id_numero_telefonico);

CREATE INDEX ix_t_numero_adjunto_id_numero_telefonico
ON t_numero_adjunto(id_numero_telefonico);

CREATE INDEX ix_t_rango_numeracion_id_tipo_servicio
ON t_rango_numeracion(id_tipo_servicio);
CREATE INDEX ix_t_rango_numeracion_id_departamento
ON t_rango_numeracion(id_departamento);
CREATE INDEX ix_t_rango_numeracion_id_tipo_zona
ON t_rango_numeracion(id_tipo_zona);
CREATE INDEX ix_t_rango_numeracion_id_proveedor_numeracion
ON t_rango_numeracion(id_proveedor_numeracion);
CREATE INDEX ix_t_rango_numeracion_id_comercializador
ON t_rango_numeracion(id_comercializador);
CREATE INDEX ix_t_rango_numeracion_id_estado_rango
ON t_rango_numeracion(id_estado_rango);
CREATE INDEX ix_t_rango_numeracion_id_tipo_servicio_departamento_tipo_zona ON t_rango_numeracion (id_tipo_servicio, id_departamento, id_tipo_zona);