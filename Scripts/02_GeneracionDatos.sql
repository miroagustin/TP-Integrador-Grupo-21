USE C2900G21;
GO

-- Datos para Admin.Usuario
DECLARE @fecha_creacion DATETIME = GETDATE();
DECLARE @rutabase varchar(50) = 'C:/Ruta/';

DECLARE @rutasedes varchar(50) = @rutabase+'Sedes.csv';
DECLARE @rutapacientes varchar(50) = @rutabase+'Pacientes.csv';
DECLARE @rutamedicos varchar(50) = @rutabase+'medicos.csv';

EXEC Admin.InsertarUsuario 'contraseña123', @fecha_creacion;
EXEC Admin.InsertarUsuario 'contraseña456', @fecha_creacion;
EXEC Admin.InsertarUsuario 'contraseña789', @fecha_creacion;
--Importacion desde archivos
exec [Clinica].[ImportarSedesDesdeCSV] @rutasedes;
exec [Clinica].[ImportarPacientesDesdeCSV] @rutapacientes;
exec [Clinica].[ImportarMedicosDesdeCSV] @rutamedicos;
-- Datos para Clinica.Paciente
DECLARE @fecha_registro DATETIME = GETDATE();
DECLARE @usuario_actualizacion INT = 1; -- Suponiendo que el id_usuario 1 existe

EXEC Clinica.InsertarPaciente 'Juan', 'Pérez', 'González', '1980-05-15', 'DNI', '12345678', 'Masculino', 'Masculino', 'Argentina', 'foto1.jpg', 'juan.perez@example.com', '111-111-1111', '222-222-2222', '333-333-3333', @fecha_registro, NULL, @usuario_actualizacion;
EXEC Clinica.InsertarPaciente 'Ana', 'Martínez', 'López', '1990-07-20', 'DNI', '87654321', 'Femenino', 'Femenino', 'Argentina', 'foto2.jpg', 'ana.martinez@example.com', '444-444-4444', '555-555-5555', '666-666-6666', @fecha_registro, NULL, @usuario_actualizacion;
EXEC Clinica.InsertarPaciente 'Carlos', 'Gómez', NULL, '1985-10-30', 'DNI', '13579246', 'Masculino', 'Masculino', 'Argentina', 'foto3.jpg', 'carlos.gomez@example.com', '777-777-7777', '888-888-8888', '999-999-9999', @fecha_registro, NULL, @usuario_actualizacion;

-- Datos para Clinica.Area
EXEC Clinica.InsertarArea 'Cardiología';
EXEC Clinica.InsertarArea 'Dermatología';
EXEC Clinica.InsertarArea 'Neurología';

-- Datos para Clinica.Estudio
DECLARE @fecha DATE = GETDATE();
DECLARE @id_area INT = 1; -- Suponiendo que el id_area 1 existe

EXEC Clinica.InsertarEstudio @fecha, 'Electrocardiograma', 1, 'documento1.pdf', 'imagen1.jpg', @id_area;
EXEC Clinica.InsertarEstudio @fecha, 'Biopsia de piel', 1, 'documento2.pdf', 'imagen2.jpg', @id_area;
EXEC Clinica.InsertarEstudio @fecha, 'Resonancia magnética', 1, 'documento3.pdf', 'imagen3.jpg', @id_area;

-- Datos para Clinica.Prestador
EXEC Clinica.InsertarPrestador 'Obra Social 1', 'Plan A';
EXEC Clinica.InsertarPrestador 'Prepaga 2', 'Plan B';
EXEC Clinica.InsertarPrestador 'Seguro 3', 'Plan C';

-- Datos para Clinica.Cobertura
DECLARE @id_historia_clinica INT = 1; -- Suponiendo que el id_historia_clinica 1 existe
DECLARE @id_prestador INT = 1; -- Suponiendo que el id_prestador 1 existe

EXEC Clinica.InsertarCobertura 'credencial1.jpg', '12345', @fecha, @id_historia_clinica, @id_prestador;
EXEC Clinica.InsertarCobertura 'credencial2.jpg', '67890', @fecha, @id_historia_clinica, @id_prestador;
EXEC Clinica.InsertarCobertura 'credencial3.jpg', '54321', @fecha, @id_historia_clinica, @id_prestador;

-- Datos para Clinica.Domicilio
EXEC Clinica.InsertarDomicilio 'Calle Falsa', '123', '4', 'A', '1234', 'Buenos Aires', 'CABA', @id_historia_clinica;
EXEC Clinica.InsertarDomicilio 'Calle Verdadera', '456', '7', 'B', '5678', 'Buenos Aires', 'CABA', @id_historia_clinica;
EXEC Clinica.InsertarDomicilio 'Avenida Siempreviva', '789', '10', 'C', '9101', 'Buenos Aires', 'CABA', @id_historia_clinica;

-- Datos para Clinica.Tipo_Turno
EXEC Clinica.InsertarTipoTurno 'Presencial';
EXEC Clinica.InsertarTipoTurno 'Virtual';

-- Datos para Clinica.Especialidad
EXEC Clinica.InsertarEspecialidad 'Cardiología';
EXEC Clinica.InsertarEspecialidad 'Dermatología';
EXEC Clinica.InsertarEspecialidad 'Neurología';

-- Datos para Clinica.Medico
DECLARE @id_especialidad INT = 1; -- Suponiendo que el id_especialidad 1 existe

EXEC Clinica.InsertarMedico 'José', 'Rodríguez', '12345', @id_especialidad;
EXEC Clinica.InsertarMedico 'María', 'López', '67890', @id_especialidad;
EXEC Clinica.InsertarMedico 'Pedro', 'García', '54321', @id_especialidad;

-- Datos para Clinica.Sede
EXEC Clinica.InsertarSede 'Sede Central', 'Av. Principal 123';
EXEC Clinica.InsertarSede 'Sede Norte', 'Calle Norte 456';
EXEC Clinica.InsertarSede 'Sede Sur', 'Calle Sur 789';

-- Datos para Clinica.Estado_Turno
EXEC Clinica.InsertarEstadoTurno 'Pendiente';
EXEC Clinica.InsertarEstadoTurno 'Confirmado';
EXEC Clinica.InsertarEstadoTurno 'Cancelado';

-- Datos para Clinica.Turno
DECLARE @id_medico INT = 1; -- Suponiendo que el id_medico 1 existe
DECLARE @direccion_atencion VARCHAR(255) = 'Av. Principal 123';
DECLARE @id_tipo_turno INT = 1; -- Suponiendo que el id_tipo_turno 1 existe
DECLARE @id_estado INT = 1; -- Suponiendo que el id_estado 1 existe

EXEC Clinica.InsertarTurno '2024-06-10 10:00:00', @id_medico, @direccion_atencion, NULL, @id_tipo_turno, @id_historia_clinica, @id_estado;
EXEC Clinica.InsertarTurno '2024-06-10 11:00:00', @id_medico, @direccion_atencion, NULL, @id_tipo_turno, @id_historia_clinica, @id_estado;
EXEC Clinica.InsertarTurno '2024-06-10 12:00:00', @id_medico, @direccion_atencion, NULL, @id_tipo_turno, @id_historia_clinica, @id_estado;

-- Datos para Clinica.EstudioPrestador
DECLARE @porcentaje FLOAT = 50.0;
DECLARE @costo FLOAT = 100.0;

EXEC Clinica.InsertarEstudioPrestador 1, 1, @porcentaje, @costo; -- Suponiendo que el id_estudio 1 y el id_prestador 1 existen
EXEC Clinica.InsertarEstudioPrestador 2, 2, @porcentaje, @costo; -- Suponiendo que el id_estudio 2 y el id_prestador 2 existen
EXEC Clinica.InsertarEstudioPrestador 3, 3, @porcentaje, @costo; -- Suponiendo que el id_estudio 3 y el id_prestador 3 existen

-- Assuming there are already 63 doctors and 15 sedes in the database
-- Insert test data into Clinica.DiasXSede

-- Check the number of records in Medico and Sede tables
SELECT COUNT(*) AS MedicoCount FROM Clinica.Medico;
SELECT COUNT(*) AS SedeCount FROM Clinica.Sede;

-- Generating 50 test records
DECLARE @MedicoCount INT = 63;
DECLARE @SedeCount INT = 15;
DECLARE @Counter INT = 1;

WHILE @Counter <= 50
BEGIN
    DECLARE @id_sede_gen INT;
    DECLARE @id_medico_gen INT;
    DECLARE @hora_inicio_gen TIME;
    DECLARE @dia_semana INT;
    
    -- Randomly select an id_sede and id_medico
    SET @id_sede_gen = FLOOR(RAND() * @SedeCount) + 1;
    SET @id_medico_gen = FLOOR(RAND() * @MedicoCount) + 1;

    -- Randomly select a start time between 08:00 and 18:00 (8 AM to 6 PM)
     SET @hora_inicio_gen = CAST(CAST(FLOOR(RAND() * (18 - 8) + 8) AS VARCHAR) + ':'
                    + RIGHT('00' + CAST(FLOOR(RAND() * 4) * 15 AS VARCHAR), 2) + ':00' AS TIME);
    
    -- Randomly select a day of the week (1 = Sunday, 2 = Monday, ..., 7 = Saturday)
    SET @dia_semana = FLOOR(RAND() * 7) + 1;
    
    -- Insert the generated record
    INSERT INTO Clinica.DiasXSede (id_sede, id_medico, hora_inicio, dia_semana)
    VALUES (@id_sede_gen, @id_medico_gen, @hora_inicio_gen, @dia_semana);
    
    SET @Counter = @Counter + 1;
END;
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
SELECT * FROM Clinica.Sede;
SELECT * FROM Clinica.DiasXSede;
SELECT * FROM Clinica.Domicilio;
SELECT * FROM Clinica.EstudioPrestador;
