/**************RANGO NUM****************************/
/**************RANGO NUM****************************/
/**************RANGO NUM****************************/
/**************RANGO NUM****************************/
/**************RANGO NUM****************************/
/**************RANGO NUM****************************/
/**************RANGO NUM****************************/


CREATE TABLE IF NOT EXISTS m_operador (
    id_operador INT PRIMARY KEY AUTO_INCREMENT,
    desc_operador VARCHAR(150) NOT NULL,
    cod_enrutador VARCHAR(20),
    flg_estado CHAR(1) DEFAULT 'A',
    fec_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fec_modf DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
)ENGINE=InnoDB;


CREATE TABLE IF NOT EXISTS m_estado_proceso (
    id_estado_proceso INT PRIMARY KEY AUTO_INCREMENT,
    desc_estado VARCHAR(50)
)ENGINE=InnoDB;

INSERT INTO m_estado_proceso(desc_estado)
VALUES
('Pendiente'),
('Procesando'),
('Completado'),
('Error');

CREATE TABLE IF NOT EXISTS t_rango_numeracion (
    id_rango BIGINT PRIMARY KEY AUTO_INCREMENT,
    id_tipo_servicio INT NOT NULL, 
    id_departamento INT NOT NULL,
    id_tipo_zona INT NOT NULL,
    id_proveedor_numeracion INT NOT NULL,
    id_comercializador INT NOT NULL,
    cant_numeros_generados INT NOT NULL,
    num_rango_inicial BIGINT NOT NULL,
    num_rango_final BIGINT NOT NULL,
    fec_creacion_rango DATETIME NOT NULL,
    id_estado_rango INT NOT NULL,
    id_estado_proceso INT DEFAULT 1,
    cant_total_generados INT DEFAULT 0,
    cant_total_error INT DEFAULT 0,
    fec_inicio_proceso DATETIME NULL,
    fec_fin_proceso DATETIME NULL,
    id_usuario_creacion INT NOT NULL,
    id_usuario_modificacion INT NOT NULL,
    fec_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fec_modf DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    nom_app VARCHAR(100),
    nom_app_modf VARCHAR(100),
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
    id_operador_cedente SMALLINT,
    id_operador_receptor SMALLINT,
    fec_activacion DATETIME,
    fec_port_in DATETIME,
    fec_port_out DATETIME,
    num_dias_reserva INT,
    fec_baja DATETIME,
    id_motivo_cambio INT,
    id_estado_numero INT NOT NULL,
    id_usuario_creacion INT NOT NULL,
    -- fec_creacion_numero DATETIME NOT NULL,
    id_usuario_modificacion INT NOT NULL,
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
    CONSTRAINT fk_m_tipo_doc_t_numero_telefonico FOREIGN KEY (id_tipo_doc)
        REFERENCES m_tipo_doc(id_tipo_doc)
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

CREATE INDEX idx_numero_telefono
ON t_numero_telefonico(num_telefono);
CREATE INDEX idx_numero_estado
ON t_numero_telefonico(id_estado_numero);
CREATE INDEX idx_numero_rango
ON t_numero_telefonico(id_rango);
CREATE INDEX idx_rango_inicio_fin
ON t_rango_numeracion(rango_inicial, rango_final);
CREATE INDEX idx_rango_departamento
ON t_rango_numeracion(id_departamento);

CREATE INDEX idx_historial_numero
ON t_historial_numero(id_numero);

CREATE INDEX idx_adjunto_numero
ON t_numero_adjunto(id_numero);

CREATE INDEX idx_estado_rango
ON t_rango_numeracion(id_estado_rango);

CREATE INDEX idx_estado_proceso
ON t_rango_numeracion(id_estado_proceso);