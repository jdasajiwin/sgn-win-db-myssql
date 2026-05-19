-- Data de prueba (ordenada por dependencias FK)
-- Estructura navegacion (desde Inicio de sesion):
--   Usuarios (1) -> Gestion de usuario (2), Trazabilidad de eventos (3)
--   Gestion de rangos de numeracion (4)
--   Gestion de numeros telefonicos (5)
--   Gestion de Portabilidad (6)
--   Contingencia activacion freeswitch (7) -> Numeros WI NET (8), Numeros Portados (9)
--   Mantenimientos (10) -> Parametros SGN, Proveedores, Comercializador, Operadores,
--                          Motivo cambio estado, Parametros Freeswitch (11-16)
-- Roles: SuperAdmin (1), Admin TI (2), Gestor de telefonia (3), Supervisor NOC (4), Operador NOC (5).
-- Menus y opciones solo asignados a SuperAdmin (id_rol=1).
-- t_usuario_rol: usuario principal (1) -> SuperAdmin. Usuario Fuyu Collantes (2) sin rol en seed.

START TRANSACTION;
-- m_eventos
INSERT INTO m_eventos (
    cod_evento,
    desc_evento,
    tipo_evento,
    desc_usuario_crea,
    desc_usuario_modf,
    fec_creacion,
    fec_modf,
    id_estado,
    detalle_template
) 
VALUES
('USER_REG','CREAR USUARIO','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se creó un registro en {{modulo}}'),
('USER_EDIT','EDITAR USUARIO','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se actualizaron datos en {{modulo}}'),
('USER_DEL','ELIMINAR USUARIO','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se eliminó un registro en {{modulo}}'),
('USER_EXPORT','EXPORTAR USUARIO','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se exportó información del módulo {{modulo}}'),
('RN_REG','CREAR RANGO DE NUMERACIÓN','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se creó un registro en {{modulo}}'),
('RN_CAMBIAR_EST','CAMBIAR ESTADO RANGO DE NUMERACIÓN','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se cambió el estado de un registro en {{modulo}}'),
('RN_EXPORT','EXPORTAR RANGO DE NUMERACIÓN','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se exportó información del módulo {{modulo}}'),
('NUM_TEL_EDIT','EDITAR NUMERO TELEFÓNICO','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se actualizaron datos en {{modulo}}'),
('NUM_TEL_EXPORT','EXPORTAR NUMERO TELEFÓNICO','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se exportó información del módulo {{modulo}}'),
('PORT_IMPORT','IMPORTAR PORTABILIDAD','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se importó información en {{modulo}}'),
('PORT_EDIT','EDITAR PORTABILIDAD','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se actualizaron datos en {{modulo}}'),
('PORT_EXPORT','EXPORTAR PORTABILIDAD','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se exportó información del módulo {{modulo}}'),
('NUM_WINET','ACTIVACIÓN','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se realizó una activación en {{modulo}}'),
('NUM_PORTA','ACTIVACIÓN','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se realizó una activación por portabilidad en {{modulo}}'),
('DIA_RES_BAJA_REG','CREAR DÍAS DE RESERVA DE BAJA','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se creó un registro en {{modulo}}'),
('DIA_RES_BAJA_EDIT','EDITAR DÍAS DE RESERVA DE BAJA','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se actualizaron datos en {{modulo}}'),
('DIA_RES_BAJA_DEL','ELIMINAR DÍAS DE RESERVA DE BAJA','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se eliminó un registro en {{modulo}}'),
('DIA_PRE_RESER_REG','CREAR DÍAS DE PRE-RESERVA','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se creó un registro en {{modulo}}'),
('DIA_PRE_RESER_EDIT','EDITAR DÍAS DE PRE-RESERVA','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se actualizaron datos en {{modulo}}'),
('DIA_PRE_RESER_DEL','ELIMINAR DÍAS DE PRE-RESERVA','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se eliminó un registro en {{modulo}}'),
('CANT_NUM_REG','CREAR CANTIDAD MÍNIMA DE NÚMEROS A GENERAR','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se creó un registro en {{modulo}}'),
('CANT_NUM_EDIT','EDITAR CANTIDAD MÍNIMA DE NÚMEROS A GENERAR','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se actualizaron datos en {{modulo}}'),
('CANT_NUM_DEL','ELIMINAR CANTIDAD MÍNIMA DE NÚMEROS A GENERAR','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se eliminó un registro en {{modulo}}'),
('PROV_NUM_REG','CREAR PROVEEDOR DE NUMERACIÓN','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se creó un registro en {{modulo}}'),
('PROV_NUM_EDIT','EDITAR PROVEEDOR DE NUMERACIÓN','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se actualizaron datos en {{modulo}}'),
('PROV_NUM_DEL','ELIMINAR PROVEEDOR DE NUMERACIÓN','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se eliminó un registro en {{modulo}}'),
('COMER_REG','CREAR COMERCIALIZADOR','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se creó un registro en {{modulo}}'),
('COMER_EDIT','EDITAR COMERCIALIZADOR','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se actualizaron datos en {{modulo}}'),
('COMER_DEL','ELIMINAR COMERCIALIZADOR','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se eliminó un registro en {{modulo}}'),
('OPERA_REG','CREAR OPERADORES','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se creó un registro en {{modulo}}'),
('OPERA_EDIT','EDITAR OPERADORES','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se actualizaron datos en {{modulo}}'),
('OPERA_DEL','ELIMINAR OPERADORES','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se eliminó un registro en {{modulo}}'),
('MOT_CAMB_REG','CREAR MOTIVO DEL CAMBIO DE ESTADO','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se creó un registro en {{modulo}}'),
('MOT_CAMB_EDIT','EDITAR MOTIVO DEL CAMBIO DE ESTADO','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se actualizaron datos en {{modulo}}'),
('MOT_CAMB_DEL','ELIMINAR MOTIVO DEL CAMBIO DE ESTADO','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se eliminó un registro en {{modulo}}'),
('PL_TEL_REG','CREAR PLANES DE TELEFONÍA','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se creó un registro en {{modulo}}'),
('PL_TEL_EDIT','EDITAR PLANES DE TELEFONÍA','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se actualizaron datos en {{modulo}}'),
('PL_TEL_DEL','ELIMINAR PLANES DE TELEFONÍA','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se eliminó un registro en {{modulo}}'),
('DEPART_REG','CREAR DEPARTAMENTOS','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se creó un registro en {{modulo}}'),
('DEPART_EDIT','EDITAR DEPARTAMENTOS','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se actualizaron datos en {{modulo}}'),
('DEPART_DEL','ELIMINAR DEPARTAMENTOS','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se eliminó un registro en {{modulo}}'),
('EST_NUM_TEL_REG','CREAR ESTADOS DEL NÚMERO TELEFÓNICO','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se creó un registro en {{modulo}}'),
('EST_NUM_TEL_EDIT','EDITAR ESTADOS DEL NÚMERO TELEFÓNICO','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se actualizaron datos en {{modulo}}'),
('EST_NUM_TEL_DEL','ELIMINAR ESTADOS DEL NÚMERO TELEFÓNICO','FORMULARIO','ADMIN','ADMIN',NOW(),NOW(),1,'Se eliminó un registro en {{modulo}}'),
('API_OBT_NUM','OBTENER NÚMERO','API','ADMIN','ADMIN',NOW(),NOW(),1,'Se obtuvo un número desde {{modulo}}'),
('API_REG_NUM_PORTIN','REGISTRAR NÚMERO PORT IN','API','ADMIN','ADMIN',NOW(),NOW(),1,'Se creó un registro en {{modulo}}'),
('API_ACT_NUM_FREESW','ACTIVACIÓN DE NÚMERO TELEFÓNICO EN FREESWITCH','API','ADMIN','ADMIN',NOW(),NOW(),1,'Se activó un número telefónico en {{modulo}}'),
('API_NUM_NCE','GESTIÓN DEL NÚMERO TELEFÓNICO EN NCE','API','ADMIN','ADMIN',NOW(),NOW(),1,'Se realizó una gestión de número telefónico en {{modulo}}'),
('API_LIB_NUM_BL','LIBERAR NÚMERO BLOQUEADO','API','ADMIN','ADMIN',NOW(),NOW(),1,'Se liberó un número bloqueado en {{modulo}}'),
('API_CONS_NUM','CONSULTA DE NÚMERO ','API','ADMIN','ADMIN',NOW(),NOW(),1,'Se realizó una consulta de número en {{modulo}}'),
('API_CAM_NUM','CAMBIO DE NÚMERO TELEFÓNICO','API','ADMIN','ADMIN',NOW(),NOW(),1,'Se realizó un cambio de número telefónico en {{modulo}}'),
('API_CAM_NUM_PORT','CAMBIO DE NÚMERO POR PORTABILIDAD','API','ADMIN','ADMIN',NOW(),NOW(),1,'Se realizó un cambio de número por portabilidad en {{modulo}}'),
('API_BAJA_NUM','BAJA DE NÚMERO TELEFÓNICO','API','ADMIN','ADMIN',NOW(),NOW(),1,'Se dio de baja un número telefónico en {{modulo}}'),
('API_CB_TITU','CAMBIO DE TITULARIDAD DE NÚMERO TELEFONICO ','API','ADMIN','ADMIN',NOW(),NOW(),1,'Se realizó un cambio de titularidad en {{modulo}}'),
('API_PORTIN_DEL','ELIMINAR NÚMERO BLOQUEADO PORT IN','API','ADMIN','ADMIN',NOW(),NOW(),1,'Se eliminó un registro en {{modulo}}'),
('API_NOT_PORTOUT','PORT OUT CON NOTIFICACIÓN A LAS VNOs','API','ADMIN','ADMIN',NOW(),NOW(),1,'Se notificó un proceso de port out en {{modulo}}'),
('API_NOT_STOCK','Noticación de stock mínimo de numeración','API','ADMIN','ADMIN',NOW(),NOW(),1,'Se generó una notificación de stock mínimo en {{modulo}}'),
('API_ALERT_BAJA_FREESW','Alerta de baja pendiente en FreeSwitch','API','ADMIN','ADMIN',NOW(),NOW(),1,'Se generó una alerta de baja pendiente en {{modulo}}'),
('JOB_LIB_AUTO','LIBERACIÓN AUTOMÁTICA DE NÚMEROS BLOQUEADOS','JOB','ADMIN','ADMIN',NOW(),NOW(),1,'Se ejecutó la liberación automática de números bloqueados en {{modulo}}'),
('JOB_PORTA','Proceso automático de portabilidad','JOB','ADMIN','ADMIN',NOW(),NOW(),1,'Se ejecutó el proceso automático de portabilidad en {{modulo}}');

-- DEPARTAMENTOS

INSERT INTO m_departamento (nombre_departamento,cod_ubigeo_departamento,cod_tel_departamento,cobertura_departamento,fec_crea,fec_upd) VALUES
	 ('Amazonas','01','41','NO',NOW(),NOW()),
	 ('Áncash','02','43','SI',NOW(),NOW()),
	 ('Apurímac','03','83','NO',NOW(),NOW()),
	 ('Arequipa','04','54','SI',NOW(),NOW()),
	 ('Ayacucho','05','66','NO',NOW(),NOW()),
	 ('Cajamarca','06','76','NO',NOW(),NOW()),
	 ('Cusco','07','84','SI',NOW(),NOW()),
	 ('Huancavelica','08','67','NO',NOW(),NOW()),
	 ('Huánuco','09','62','NO',NOW(),NOW()),
	 ('Ica','10','56','NO',NOW(),NOW());
INSERT INTO m_departamento (nombre_departamento,cod_ubigeo_departamento,cod_tel_departamento,cobertura_departamento,fec_crea,fec_upd) VALUES
	 ('Junín','11','64','SI',NOW(),NOW()),
	 ('La Libertad','12','44','SI',NOW(),NOW()),
	 ('Lambayeque','13','74','SI',NOW(),NOW()),
	 ('Lima','14','1','SI',NOW(),NOW()),
	 ('Loreto','15','65','NO',NOW(),NOW()),
	 ('Madre de Dios','16','82','NO',NOW(),NOW()),
	 ('Moquegua','17','53','NO',NOW(),NOW()),
	 ('Pasco','18','63','NO',NOW(),NOW()),
	 ('Piura','19','73','SI',NOW(),NOW()),
	 ('Puno','20','51','NO',NOW(),NOW());
INSERT INTO m_departamento (nombre_departamento,cod_ubigeo_departamento,cod_tel_departamento,cobertura_departamento,fec_crea,fec_upd) VALUES
	 ('San Martín','21','42','NO',NOW(),NOW()),
	 ('Tacna','22','42','NO',NOW(),NOW()),
	 ('Tumbes','23','72','NO',NOW(),NOW()),
	 ('Ucayali','24','61','NO',NOW(),NOW()),
	 ('Callao (Provincia Constitucional del Callao)','25','1','NO',NOW(),NOW());

-- 0) Tipo de estado (padre de m_estados)
INSERT INTO m_tipo_estado (id_tipo_estado, cod_tipo_estado, desc_tipo_estado, flc_activo)
VALUES
  (1, 'GEN', 'General', 1),
  (2, 'TPSRV', 'Tipo proveedor servicio', 1),
  (3, 'TPZON', 'Tipo de Zona', 1),
  (4, 'TPROV', 'Tipo de proveedor numeración', 1),
  (5, 'TPCOM', 'Tipo de comercializador', 1),
  (6, 'TPESR', 'Estado Rango', 1),
  (7, 'TPFCR', 'Fácil recordación', 1),
  (8, 'TPDOC', 'Tipo de documento', 1),
  (9, 'TPSTN', 'Tipo estado de número', 1),
  (10, 'TPMVC', 'Motivo Cambio', 1)
ON DUPLICATE KEY UPDATE
  cod_tipo_estado = VALUES(cod_tipo_estado),
  desc_tipo_estado = VALUES(desc_tipo_estado),
  flc_activo = VALUES(flc_activo);

-- 1) Catalogo de estados
INSERT INTO m_estados (id_estado, id_tipo_estado, cod_estado, desc_estado, flg_activo)
VALUES
  (0, 1, 'INA', 'Inactivo', 1),
  (1, 1, 'ACT', 'Activo', 1),
  (2, 2, 'FJX', 'Fijo', 1),
  (3, 2, 'MVL', 'Móvil', 1),
  (4,3, 'RUR', 'Rural', 1),
  (5,3, 'URB', 'Urbano', 1),
  (6,4, 'WI', 'WI NET TELECOM', 1),
  (7,4, 'ON', 'ON', 1),
  (8,4, 'GTD', 'GTD', 1),
  (9,5, 'WIN', 'WIN', 1),
  (10,6, 'HAB', 'Habilitado', 1),
  (11,6, 'NOH', 'No habilitado', 1),
  (12,7, 'S', 'Sí', 1),
  (13,7, 'N', 'No', 1),
  (14,8, 'DNI', 'Documento Nacional de Identidad', 1),
  (15,8, 'CE', 'Carnet de Extranjería', 1),
  (16,8, 'RUC', 'Registro Único de Contribuyentes', 1),
  (17,8, 'PAS', 'Pasaporte', 1),
  (18,8, 'CIP', 'Carnet de Identidad Personal', 1),
  (19,9, 'NOH', 'No habilitado', 1),
  (20,9, 'DIS', 'Disponible', 1),
  (21,9, 'PRR', 'Pre-reserva', 1),
  (22,9, 'BLQ', 'Bloqueado', 1),
  (23,9, 'PPB', 'Pendiente portabilidad', 1),
  (24,9, 'EUS', 'En uso', 1),
  (25,9, 'BAJ', 'Baja', 1),
  (26,9, 'BLP', 'Bloqueado port in', 1),
  (27,9, 'POT', 'Port out', 1),
  (28,10, 'CAMTIT', 'Cambio de titularidad', 1),
  (29,10, 'INCAPI', 'Incidencia con las APIs', 1),
  (30,10, 'SOLVNO', 'A solicitud de VNO', 1),
  (31,10, 'SOLOSP', 'A solicitud de OSIPTEL', 1),
  (32,10, 'SOLIND', 'A solicitud de INDECOPI', 1),
  (33,10, 'CONTFRE', 'Contingencia Freeswitch', 1),
  (34,10, 'CAMNUM', 'Cambio de número', 1),
  (35,10,'CAMNUMPOR','Cambio de número por portabilidad' ,1)

ON DUPLICATE KEY UPDATE
  id_tipo_estado = VALUES(id_tipo_estado),
  cod_estado = VALUES(cod_estado),
  desc_estado = VALUES(desc_estado),
  flg_activo = VALUES(flg_activo);




-- 2) Catalogos base
INSERT INTO m_menus (
  id_menu, cod_menu, cod_sub_menu, id_menu_padre, desc_menu, desc_ruta, id_estado
)
VALUES
  (1, LEFT(REGEXP_REPLACE(UPPER('Usuarios'), '[^A-Z0-9]', ''), 12), NULL, NULL, 'Usuarios', '/usuarios', 1),
  (2, LEFT(REGEXP_REPLACE(UPPER('Gestion de usuario'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Usuarios'), '[^A-Z0-9]', ''), 12), 1, 'Gestion de usuario', '/usuarios/gestion', 1),
  (3, LEFT(REGEXP_REPLACE(UPPER('Trazabilidad de eventos'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Usuarios'), '[^A-Z0-9]', ''), 12), 1, 'Trazabilidad de eventos', '/usuarios/trazabilidad', 1),
  (4, LEFT(REGEXP_REPLACE(UPPER('Gestion de rangos de numeracion'), '[^A-Z0-9]', ''), 12), NULL, NULL, 'Gestion de rangos de numeracion', '/rangos-numeracion', 1),
  (5, LEFT(REGEXP_REPLACE(UPPER('Gestion de numeros telefonicos'), '[^A-Z0-9]', ''), 12), NULL, NULL, 'Gestion de numeros telefonicos', '/numeros-telefonicos', 1),
  (6, LEFT(REGEXP_REPLACE(UPPER('Gestion de Portabilidad'), '[^A-Z0-9]', ''), 12), NULL, NULL, 'Gestion de Portabilidad', '/portabilidad', 1),
  (7, LEFT(REGEXP_REPLACE(UPPER('Contingencia de activacion freeswitch'), '[^A-Z0-9]', ''), 12), NULL, NULL, 'Contingencia de activacion freeswitch', '/contingencia', 1),
  (8, LEFT(REGEXP_REPLACE(UPPER('Numeros WI NET'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Contingencia de activacion freeswitch'), '[^A-Z0-9]', ''), 12), 7, 'Numeros WI NET', '/contingencia/winet', 1),
  (9, LEFT(REGEXP_REPLACE(UPPER('Numeros Portados'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Contingencia de activacion freeswitch'), '[^A-Z0-9]', ''), 12), 7, 'Numeros Portados', '/contingencia/numeros-portados', 1),
  (10, LEFT(REGEXP_REPLACE(UPPER('Mantenimientos'), '[^A-Z0-9]', ''), 12), NULL, NULL, 'Mantenimientos', '/mantenimientos', 1),
  (11, LEFT(REGEXP_REPLACE(UPPER('SGN parametros generales'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Mantenimientos'), '[^A-Z0-9]', ''), 12), 10, 'Parametros generales SGN', '/mantenimientos/parametros-sgn', 1),
  (12, LEFT(REGEXP_REPLACE(UPPER('Proveedores de numeracion'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Mantenimientos'), '[^A-Z0-9]', ''), 12), 10, 'Proveedores de numeracion', '/mantenimientos/proveedores-numeracion', 1),
  (13, LEFT(REGEXP_REPLACE(UPPER('Comercializador'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Mantenimientos'), '[^A-Z0-9]', ''), 12), 10, 'Comercializador', '/mantenimientos/comercializador', 1),
  (14, LEFT(REGEXP_REPLACE(UPPER('Operadores'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Mantenimientos'), '[^A-Z0-9]', ''), 12), 10, 'Operadores', '/mantenimientos/operadores', 1),
  (15, LEFT(REGEXP_REPLACE(UPPER('Motivo del cambio de estado'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Mantenimientos'), '[^A-Z0-9]', ''), 12), 10, 'Motivo del cambio de estado', '/mantenimientos/motivo-cambio-estado', 1),
  (16, LEFT(REGEXP_REPLACE(UPPER('Freeswitch parametros generales'), '[^A-Z0-9]', ''), 12), LEFT(REGEXP_REPLACE(UPPER('Mantenimientos'), '[^A-Z0-9]', ''), 12), 10, 'Parametros generales Freeswitch', '/mantenimientos/parametros-freeswitch', 1)
ON DUPLICATE KEY UPDATE
  cod_menu = VALUES(cod_menu),
  cod_sub_menu = VALUES(cod_sub_menu),
  id_menu_padre = VALUES(id_menu_padre),
  desc_menu = VALUES(desc_menu),
  desc_ruta = VALUES(desc_ruta),
  id_estado = VALUES(id_estado);

INSERT INTO m_opciones (
  id_menu, id_opcion, cod_menu, desc_opcion, desc_ruta, id_estado
)
VALUES
  (1, 1, LEFT(REGEXP_REPLACE(UPPER('Usuarios'), '[^A-Z0-9]', ''), 12), 'Usuarios', '/usuarios', 1),
  (2, 2, LEFT(REGEXP_REPLACE(UPPER('Gestion de usuario'), '[^A-Z0-9]', ''), 12), 'Gestion de usuario', '/usuarios/gestion', 1),
  (3, 3, LEFT(REGEXP_REPLACE(UPPER('Trazabilidad de eventos'), '[^A-Z0-9]', ''), 12), 'Trazabilidad de eventos', '/usuarios/trazabilidad', 1),
  (4, 4, LEFT(REGEXP_REPLACE(UPPER('Gestion de rangos de numeracion'), '[^A-Z0-9]', ''), 12), 'Gestion de rangos de numeracion', '/rangos-numeracion', 1),
  (5, 5, LEFT(REGEXP_REPLACE(UPPER('Gestion de numeros telefonicos'), '[^A-Z0-9]', ''), 12), 'Gestion de numeros telefonicos', '/numeros-telefonicos', 1),
  (6, 6, LEFT(REGEXP_REPLACE(UPPER('Gestion de Portabilidad'), '[^A-Z0-9]', ''), 12), 'Gestion de Portabilidad', '/portabilidad', 1),
  (7, 7, LEFT(REGEXP_REPLACE(UPPER('Contingencia de activacion freeswitch'), '[^A-Z0-9]', ''), 12), 'Contingencia de activacion freeswitch', '/contingencia', 1),
  (8, 8, LEFT(REGEXP_REPLACE(UPPER('Numeros WI NET'), '[^A-Z0-9]', ''), 12), 'Numeros WI NET', '/contingencia/winet', 1),
  (9, 9, LEFT(REGEXP_REPLACE(UPPER('Numeros Portados'), '[^A-Z0-9]', ''), 12), 'Numeros Portados', '/contingencia/numeros-portados', 1),
  (10, 10, LEFT(REGEXP_REPLACE(UPPER('Mantenimientos'), '[^A-Z0-9]', ''), 12), 'Mantenimientos', '/mantenimientos', 1),
  (11, 11, LEFT(REGEXP_REPLACE(UPPER('SGN parametros generales'), '[^A-Z0-9]', ''), 12), 'Parametros generales SGN', '/mantenimientos/parametros-sgn', 1),
  (12, 12, LEFT(REGEXP_REPLACE(UPPER('Proveedores de numeracion'), '[^A-Z0-9]', ''), 12), 'Proveedores de numeracion', '/mantenimientos/proveedores-numeracion', 1),
  (13, 13, LEFT(REGEXP_REPLACE(UPPER('Comercializador'), '[^A-Z0-9]', ''), 12), 'Comercializador', '/mantenimientos/comercializador', 1),
  (14, 14, LEFT(REGEXP_REPLACE(UPPER('Operadores'), '[^A-Z0-9]', ''), 12), 'Operadores', '/mantenimientos/operadores', 1),
  (15, 15, LEFT(REGEXP_REPLACE(UPPER('Motivo del cambio de estado'), '[^A-Z0-9]', ''), 12), 'Motivo del cambio de estado', '/mantenimientos/motivo-cambio-estado', 1),
  (16, 16, LEFT(REGEXP_REPLACE(UPPER('Freeswitch parametros generales'), '[^A-Z0-9]', ''), 12), 'Parametros generales Freeswitch', '/mantenimientos/parametros-freeswitch', 1)
ON DUPLICATE KEY UPDATE
  cod_menu = VALUES(cod_menu),
  desc_opcion = VALUES(desc_opcion),
  desc_ruta = VALUES(desc_ruta),
  id_estado = VALUES(id_estado);

INSERT INTO m_roles (id_rol, cod_rol, desc_rol, id_estado)
VALUES
  (1, LEFT(REGEXP_REPLACE(UPPER('SuperAdmin'), '[^A-Z0-9]', ''), 12), 'SuperAdmin', 1),
  (2, LEFT(REGEXP_REPLACE(UPPER('Admin TI'), '[^A-Z0-9]', ''), 12), 'Admin TI', 1),
  (3, LEFT(REGEXP_REPLACE(UPPER('Gestor de telefonia'), '[^A-Z0-9]', ''), 12), 'Gestor de telefonía', 1),
  (4, LEFT(REGEXP_REPLACE(UPPER('Supervisor NOC'), '[^A-Z0-9]', ''), 12), 'Supervisor NOC', 1),
  (5, LEFT(REGEXP_REPLACE(UPPER('Operador NOC'), '[^A-Z0-9]', ''), 12), 'Operador NOC', 1)
ON DUPLICATE KEY UPDATE
  cod_rol = VALUES(cod_rol),
  desc_rol = VALUES(desc_rol),
  id_estado = VALUES(id_estado);

INSERT INTO m_roles_menus (
  id_rol_menu, id_rol, id_menu, desc_usuario_crea, desc_usuario_modf, fec_modf, id_estado
)
VALUES
  (1, 1, 1, 'seed', 'seed', 0, 1),
  (2, 1, 2, 'seed', 'seed', 0, 1),
  (3, 1, 3, 'seed', 'seed', 0, 1),
  (4, 1, 4, 'seed', 'seed', 0, 1),
  (5, 1, 5, 'seed', 'seed', 0, 1),
  (6, 1, 6, 'seed', 'seed', 0, 1),
  (7, 1, 7, 'seed', 'seed', 0, 1),
  (8, 1, 8, 'seed', 'seed', 0, 1),
  (9, 1, 9, 'seed', 'seed', 0, 1),
  (10, 1, 10, 'seed', 'seed', 0, 1),
  (11, 1, 11, 'seed', 'seed', 0, 1),
  (12, 1, 12, 'seed', 'seed', 0, 1),
  (13, 1, 13, 'seed', 'seed', 0, 1),
  (14, 1, 14, 'seed', 'seed', 0, 1),
  (15, 1, 15, 'seed', 'seed', 0, 1),
  (16, 1, 16, 'seed', 'seed', 0, 1)
ON DUPLICATE KEY UPDATE
  id_rol = VALUES(id_rol),
  id_menu = VALUES(id_menu),
  desc_usuario_modf = VALUES(desc_usuario_modf),
  fec_modf = VALUES(fec_modf),
  id_estado = VALUES(id_estado);

DELETE FROM m_roles_opciones;

INSERT INTO m_roles_opciones (
  id_rol_opcion, id_rol, id_opcion, id_menu, desc_usuario_crea, desc_usuario_modf, fec_creacion, fec_modf
)
VALUES
  (1, 1, 1, 1, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (2, 1, 2, 2, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (3, 1, 3, 3, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (4, 1, 4, 4, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (5, 1, 5, 5, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (6, 1, 6, 6, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (7, 1, 7, 7, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (8, 1, 8, 8, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (9, 1, 9, 9, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (10, 1, 10, 10, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (11, 1, 11, 11, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (12, 1, 12, 12, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (13, 1, 13, 13, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (14, 1, 14, 14, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (15, 1, 15, 15, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (16, 1, 16, 16, 'seed', 'seed', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO t_usuarios (
  id_usuario, desc_usuario, desc_nombres, desc_apellidos, desc_email, id_estado,
  desc_usuario_crea, desc_usuario_modf, fec_creacion, fec_modf
)
VALUES (
  1, 'usuario principal', 'jhoel', 'salinas', 'jsdaniel_21@hotmail.com', 1,
  CURRENT_USER(), CURRENT_USER(), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
)
ON DUPLICATE KEY UPDATE
  desc_usuario = VALUES(desc_usuario),
  desc_nombres = VALUES(desc_nombres),
  desc_apellidos = VALUES(desc_apellidos),
  desc_email = VALUES(desc_email),
  id_estado = VALUES(id_estado),
  desc_usuario_modf = CURRENT_USER(),
  fec_modf = CURRENT_TIMESTAMP;

INSERT INTO t_usuarios (
  id_usuario, desc_usuario, desc_nombres, desc_apellidos, desc_email, id_estado,
  desc_usuario_crea, desc_usuario_modf, fec_creacion, fec_modf
)
VALUES (
  2, 'fuyu.collantes', 'Fuyu', 'Collantes', 'fuyu.collantes@outlook.com', 1,
  CURRENT_USER(), CURRENT_USER(), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
)
ON DUPLICATE KEY UPDATE
  desc_usuario = VALUES(desc_usuario),
  desc_nombres = VALUES(desc_nombres),
  desc_apellidos = VALUES(desc_apellidos),
  desc_email = VALUES(desc_email),
  id_estado = VALUES(id_estado),
  desc_usuario_modf = CURRENT_USER(),
  fec_modf = CURRENT_TIMESTAMP;

-- 3) Relacion usuario-rol (solo SuperAdmin al usuario principal)
INSERT INTO t_usuario_rol (
  id_usuario_rol, id_rol, id_usuario, id_estado,
  desc_usuario_crea, desc_usuario_modf, fec_creacion, fec_modf
)
VALUES (
  1, 1, 1, 1,
  CURRENT_USER(), CURRENT_USER(), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
)
ON DUPLICATE KEY UPDATE
  id_rol = VALUES(id_rol),
  id_usuario = VALUES(id_usuario),
  id_estado = VALUES(id_estado),
  desc_usuario_modf = CURRENT_USER(),
  fec_modf = CURRENT_TIMESTAMP;

COMMIT;

-- Validacion rapida
SELECT 'm_tipo_estado' AS tabla, id_tipo_estado FROM m_tipo_estado WHERE id_tipo_estado IN (1, 2)
UNION ALL
SELECT 'm_estados', id_estado FROM m_estados WHERE id_estado = 1
UNION ALL
SELECT 'm_menus', id_menu FROM m_menus WHERE id_menu IN (1, 16)
UNION ALL
SELECT 'm_roles_superadmin', id_rol FROM m_roles WHERE id_rol = 1
UNION ALL
SELECT 'm_roles_total', id_rol FROM m_roles WHERE id_rol = 5
UNION ALL
SELECT 't_usuarios', id_usuario FROM t_usuarios WHERE id_usuario IN (1, 2);
