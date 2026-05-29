-- Script alineado a schema_erflow.dbml (ER Flow)
-- MySQL / InnoDB
-- Nota: PK de m_opciones es (id_opcion, id_menu) para AUTO_INCREMENT en MySQL; FK usa UNIQUE (id_menu, id_opcion).

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS t_usuario_rol;
DROP TABLE IF EXISTS m_roles_opciones;
DROP TABLE IF EXISTS m_roles_menus;
DROP TABLE IF EXISTS t_usuarios;
DROP TABLE IF EXISTS m_opciones;
DROP TABLE IF EXISTS m_menus;
DROP TABLE IF EXISTS m_roles;
DROP TABLE IF EXISTS m_estados;
DROP TABLE IF EXISTS m_tipo_estado;
DROP TABLE IF EXISTS t_trazabilidad_eventos;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE IF NOT EXISTS `m_tipo_servicio` (
  `id_tipo_servicio` int NOT NULL AUTO_INCREMENT,
  `nombre_tipo_servicio` varchar(255) NOT NULL,
  `fec_crea` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fech_upd` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tipo_servicio`)
) ENGINE=InnoDB ;


CREATE TABLE IF NOT EXISTS `m_tipo_zona` (
  `id_tipo_zona` int NOT NULL AUTO_INCREMENT,
  `nombre_tipo_zona` varchar(255) NOT NULL,
  `fec_crea` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fech_upd` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_tipo_zona`)
) ENGINE=InnoDB ;

CREATE TABLE IF NOT EXISTS `m_proveedor_numeracion` (
  `id_proveedor_numeracion` int NOT NULL AUTO_INCREMENT,
  `nombre_proveedor` varchar(255) NOT NULL,
  `fec_crea` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fech_upd` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_proveedor_numeracion`)
) ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS `m_comercializador` (
  `id_comercializador` int NOT NULL AUTO_INCREMENT,
  `nombre_comercializador` varchar(255) NOT NULL,
  `fec_crea` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fech_upd` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_comercializador`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_estado_rango` (
  `id_estado_rango` int NOT NULL AUTO_INCREMENT,
  `nombre_estado_rango` varchar(255) NOT NULL,
  `fec_crea` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fech_upd` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_estado_rango`)
) ENGINE=InnoDB ;

CREATE TABLE IF NOT EXISTS m_tipo_estado (
  id_tipo_estado INT NOT NULL AUTO_INCREMENT,
  cod_tipo_estado VARCHAR(12) NOT NULL,
  desc_tipo_estado VARCHAR(255) NOT NULL,
  flc_activo BIGINT NOT NULL,
  PRIMARY KEY (id_tipo_estado)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS m_estados (
  id_estado TINYINT NOT NULL,
  id_tipo_estado INT NOT NULL,
  cod_estado VARCHAR(12) NOT NULL,
  desc_estado VARCHAR(50) NOT NULL,
  desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT (CURRENT_USER()),
  desc_usuario_modf VARCHAR(50) NOT NULL DEFAULT (CURRENT_USER()),
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  flg_activo BIGINT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_estado),
  UNIQUE KEY uq_m_estados_cod_estado (cod_estado),
  CONSTRAINT fk_m_tipo_estado_m_estados
    FOREIGN KEY (id_tipo_estado) REFERENCES m_tipo_estado (id_tipo_estado)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `m_eventos` (
  `id_evento` INT NOT NULL AUTO_INCREMENT,
  `cod_evento` VARCHAR(50) NOT NULL,
  `desc_evento` VARCHAR(255) NOT NULL,
  `detalle_template` VARCHAR(500) NOT NULL,
  `tipo_evento` ENUM('FORMULARIO', 'API', 'JOB', 'OTRO') NOT NULL DEFAULT 'OTRO',
  `desc_usuario_crea` VARCHAR(50) NOT NULL,
  `desc_usuario_modf` VARCHAR(50) NOT NULL,
  `fec_creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fec_modf` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_estado` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_evento`),
  UNIQUE KEY `uq_m_eventos_cod_evento` (`cod_evento`),
  KEY `ix_m_eventos_tipo_evento` (`tipo_evento`),
  CONSTRAINT `fk_m_estados_m_eventos`
    FOREIGN KEY (`id_estado`)
    REFERENCES `m_estados` (`id_estado`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_auditoria (
    id_auditoria BIGINT PRIMARY KEY AUTO_INCREMENT,
    id_evento INT NOT NULL,
    modulo VARCHAR(100) NOT NULL,
    accion VARCHAR(50) NOT NULL,
    detalle TEXT NOT NULL,
    usuario_accion VARCHAR(100),
    fecha_evento DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_evento)
        REFERENCES m_eventos(id_evento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE

) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS m_departamento (
  `id_departamento` int NOT NULL AUTO_INCREMENT,
  `nombre_departamento` varchar(150) NOT NULL,
  `cod_ubigeo_departamento` char(10) NOT NULL,
  `cod_tel_departamento` char(10) NOT NULL,
  `cobertura_departamento` char(10) NOT NULL,
  `fec_crea` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fec_upd` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_departamento`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS m_menus (
  id_menu INT NOT NULL AUTO_INCREMENT,
  cod_menu VARCHAR(12) NOT NULL,
  cod_sub_menu VARCHAR(12) NULL,
  id_menu_padre INT NULL,
  desc_menu VARCHAR(150) NOT NULL,
  desc_ruta VARCHAR(200) NOT NULL,
  desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT (CURRENT_USER()),
  desc_usuario_modf VARCHAR(50) NOT NULL DEFAULT (CURRENT_USER()),
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  id_estado TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_menu),
  UNIQUE KEY uq_m_menus_cod_menu (cod_menu),
  CONSTRAINT fk_m_estados_m_menus
    FOREIGN KEY (id_estado) REFERENCES m_estados (id_estado)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS m_opciones (
  id_menu INT NOT NULL,
  id_opcion INT NOT NULL AUTO_INCREMENT,
  cod_menu VARCHAR(12) NOT NULL,
  desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT (CURRENT_USER()),
  desc_usuario_modf VARCHAR(50) NOT NULL DEFAULT (CURRENT_USER()),
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  desc_opcion VARCHAR(150) NOT NULL,
  desc_ruta VARCHAR(200) NOT NULL,
  id_estado TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_opcion, id_menu),
  UNIQUE KEY uq_m_opciones_menu_opcion (id_menu, id_opcion),
  UNIQUE KEY uq_m_opciones_cod_menu (cod_menu),
  CONSTRAINT fk_m_estados_m_opciones
    FOREIGN KEY (id_estado) REFERENCES m_estados (id_estado),
  CONSTRAINT fk_m_menus_m_opciones
    FOREIGN KEY (id_menu) REFERENCES m_menus (id_menu)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS m_roles (
  id_rol INT NOT NULL AUTO_INCREMENT,
  cod_rol VARCHAR(12) NOT NULL,
  desc_rol VARCHAR(150) NOT NULL,
  desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT (CURRENT_USER()),
  desc_usuario_modf VARCHAR(50) NOT NULL DEFAULT (CURRENT_USER()),
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  id_estado TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_rol),
  UNIQUE KEY uq_m_roles_cod_rol (cod_rol),
  CONSTRAINT fk_m_estados_m_roles
    FOREIGN KEY (id_estado) REFERENCES m_estados (id_estado)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS m_roles_menus (
  id_rol_menu INT NOT NULL AUTO_INCREMENT,
  id_rol INT NOT NULL,
  id_menu INT NOT NULL,
  desc_usuario_crea VARCHAR(255) NOT NULL,
  desc_usuario_modf VARCHAR(255) NOT NULL,
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  id_estado TINYINT NOT NULL,
  PRIMARY KEY (id_rol_menu),
  UNIQUE KEY uq_m_roles_menus_id_rol_menu (id_rol_menu),
  KEY ix_m_roles_menus_id_rol (id_rol),
  KEY ix_m_roles_menus_id_menu (id_menu),
  KEY ix_m_roles_menus_id_estado (id_estado),
  CONSTRAINT fk_m_roles_m_roles_menus
    FOREIGN KEY (id_rol) REFERENCES m_roles (id_rol),
  CONSTRAINT fk_m_menus_m_roles_menus
    FOREIGN KEY (id_menu) REFERENCES m_menus (id_menu),
  CONSTRAINT fk_m_estados_m_roles_menus
    FOREIGN KEY (id_estado) REFERENCES m_estados (id_estado)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_usuarios (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  desc_apellidos VARCHAR(255) NOT NULL,
  desc_email VARCHAR(150) NULL,
  desc_nombres VARCHAR(255) NOT NULL,
  desc_usuario VARCHAR(150) NOT NULL,
  desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT (CURRENT_USER()),
  desc_usuario_modf VARCHAR(50) NULL,
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  id_estado TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_usuario),
  UNIQUE KEY uq_t_usuarios_id_usuario (id_usuario),
  CONSTRAINT fk_m_estados_t_usuarios
    FOREIGN KEY (id_estado) REFERENCES m_estados (id_estado)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS m_roles_opciones (
  id_rol_opcion INT NOT NULL AUTO_INCREMENT,
  id_rol INT NOT NULL,
  id_opcion INT NOT NULL,
  id_menu INT NOT NULL,
  desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT (CURRENT_USER()),
  desc_usuario_modf VARCHAR(50) NOT NULL DEFAULT (CURRENT_USER()),
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

CREATE TABLE IF NOT EXISTS t_usuario_rol (
  id_usuario_rol INT NOT NULL AUTO_INCREMENT,
  id_rol INT NOT NULL,
  id_usuario INT NOT NULL,
  desc_usuario_crea VARCHAR(50) NOT NULL DEFAULT (CURRENT_USER()),
  desc_usuario_modf VARCHAR(50) NOT NULL DEFAULT (CURRENT_USER()),
  fec_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fec_modf DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  id_estado TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (id_usuario_rol),
  UNIQUE KEY uq_t_usuario_rol_id_usuario_rol (id_usuario_rol),
  KEY ix_t_usuario_rol_id_rol (id_rol),
  KEY ix_t_usuario_rol_id_usuario (id_usuario),
  CONSTRAINT fk_m_roles_t_usuario_rol
    FOREIGN KEY (id_rol) REFERENCES m_roles (id_rol),
  CONSTRAINT fk_m_estados_t_usuario_rol
    FOREIGN KEY (id_estado) REFERENCES m_estados (id_estado),
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


-- win_sgn_db.app_security_settings definition
CREATE TABLE IF NOT EXISTS `app_security_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fec_creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fec_modf` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- win_sgn_db.app_user_sessions definition
CREATE TABLE IF NOT EXISTS `app_user_sessions` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_usuario` bigint unsigned NOT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `last_activity_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fec_creacion` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `invalidated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_user_sessions_id_usuario_index` (`id_usuario`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;