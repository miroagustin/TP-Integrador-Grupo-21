USE C2900G21;
GO

-- Insertar datos de prueba en la tabla Admin.Usuario
INSERT INTO Admin.Usuario (contraseña, fecha_creacion)
VALUES 
('password123', GETDATE()),
('password456', GETDATE());

-- Insertar datos de prueba en la tabla Clinica.Paciente
INSERT INTO Clinica.Paciente (nombre, apellido, apellido_materno, fecha_nacimiento, tipo_documento, nro_documento, sexo_biologico, genero, nacionalidad, foto_perfil, mail, telefono, telefono_contacto_alternativo, telefono_laboral, fecha_registro, fecha_actualizacion, usuario_actualizacion)
VALUES
('Juan', 'Perez', 'Gomez', '1980-01-01', 'DNI', '12345678', 'Masculino', 'Masculino', 'Argentina', NULL, 'juan.perez@example.com', '123456789', '987654321', '1122334455', GETDATE(), NULL, 1),
('Maria', 'Lopez', 'Fernandez', '1990-02-02', 'DNI', '87654321', 'Femenino', 'Femenino', 'Argentina', NULL, 'maria.lopez@example.com', '234567890', '876543210', '2233445566', GETDATE(), NULL, 2);
-- Insertar datos de prueba en la tabla Clinica.Especialidad
INSERT INTO Clinica.Especialidad (nombre_especialidad)
VALUES
('Cardiología'),
('Dermatología');
-- Insertar datos de prueba en la tabla Clinica.Medico
INSERT INTO Clinica.Medico (nombre, apellido, nro_matricula, id_especialidad)
VALUES
('Carlos', 'Gonzalez', 'MAT1234', 1),
('Ana', 'Martinez', 'MAT5678', 2);



-- Insertar datos de prueba en la tabla Clinica.Cobertura
INSERT INTO Clinica.Cobertura (imagen_credencial, nro_socio, fecha_registro, id_historia_clinica)
VALUES 
(NULL, '1001', GETDATE(), 1),
(NULL, '1002', GETDATE(), 2);

-- Insertar datos de prueba en la tabla Clinica.Prestador
INSERT INTO Clinica.Prestador (nombre_prestador, plan_prestador)
VALUES
('ObraSocial1', 'Plan1'),
('ObraSocial2', 'Plan2');



-- Insertar datos de prueba en la tabla Clinica.Area
INSERT INTO Clinica.Area (descripcion)
VALUES 
('Radiología'),
('Cardiología');

-- Insertar datos de prueba en la tabla Clinica.Estudio
INSERT INTO Clinica.Estudio (fecha, nombre_estudio, autorizado, documento_resultado, imagen_resultado, id_area)
VALUES 
(GETDATE(), 'Radiografía de Tórax', 1, NULL, NULL, 1),
(GETDATE(), 'Electrocardiograma', 1, NULL, NULL, 2);

-- Insertar datos de prueba en la tabla Clinica.Estado_Turno
INSERT INTO Clinica.Estado_Turno (Nombre_estado)
VALUES
('Atendido'),
('Pendiente');

-- Insertar datos de prueba en la tabla Clinica.Tipo_Turno
INSERT INTO Clinica.Tipo_Turno (nombre_tipo_turno)
VALUES
('Consulta'),
('Emergencia');

-- Insertar datos de prueba en la tabla Clinica.Turno
INSERT INTO Clinica.Turno (id_estado, nombre_estado)
VALUES 
(1, 'Atendido'),
(2, 'Pendiente');

-- Insertar datos de prueba en la tabla Clinica.Relacion_Turno_Medico
INSERT INTO Clinica.Relacion_Turno_Medico (fecha, id_medico, id_especialidad, direccion_atencion, id_estudio, id_tipo_turno, id_historia_clinica, id_estado)
VALUES
('2024-06-10 10:00:00', 1, 1, 'Av. Siempre Viva 123', 1, 1, 1, 1),
('2024-06-11 11:00:00', 2, 2, 'Av. Siempre Viva 456', 2, 2, 2, 2);

-- Insertar datos de prueba en la tabla Clinica.Sede
INSERT INTO Clinica.Sede (nombre_sede, direccion_sede)
VALUES
('Sede Central', 'Av. Principal 123'),
('Sede Norte', 'Calle Secundaria 456');

-- Insertar datos de prueba en la tabla Clinica.Lista_Sede
INSERT INTO Clinica.Lista_Sede (id_sede, id_medico, hora_inicio)
VALUES
(1, 1, '08:00:00'),
(2, 2, '09:00:00');

-- Insertar datos de prueba en la tabla Clinica.Domicilio
INSERT INTO Clinica.Domicilio (calle, numero, piso, departamento, codigo_postal, provincia, localidad, id_historia_clinica)
VALUES
('Calle Falsa', '123', '1', 'A', '1000', 'Buenos Aires', 'CABA', 1),
('Calle Verdadera', '456', '2', 'B', '2000', 'Buenos Aires', 'CABA', 2);

-- Insertar datos de prueba en la tabla Clinica.EstudioPrestador
INSERT INTO Clinica.EstudioPrestador (id_estudio, id_prestador, porcentaje, costo)
VALUES
(1, 1, 50.0, 1500.0),
(2, 2, 75.0, 2000.0);

-- Verificar los datos insertados
SELECT * FROM Admin.Usuario;
SELECT * FROM Clinica.Paciente;
SELECT * FROM Clinica.Medico;
SELECT * FROM Clinica.Especialidad;
SELECT * FROM Clinica.Cobertura;
SELECT * FROM Clinica.Prestador;
SELECT * FROM Clinica.Area;
SELECT * FROM Clinica.Estudio;
SELECT * FROM Clinica.Estado_Turno;
SELECT * FROM Clinica.Tipo_Turno;
SELECT * FROM Clinica.Turno;
SELECT * FROM Clinica.Relacion_Turno_Medico;
SELECT * FROM Clinica.Sede;
SELECT * FROM Clinica.Lista_Sede;
SELECT * FROM Clinica.Domicilio;
SELECT * FROM Clinica.EstudioPrestador;
