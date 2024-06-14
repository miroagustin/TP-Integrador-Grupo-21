-- SCRIPT PARA LA CREACION DE QUERYS CLINICA S.A
-- FECHA: 2024-06-11
-- GRUPO: 21
-- INTEGRANTES: FRAGASSI DONATELLA, MIRO AGUSTIN, ROJAS RODRIGUEZ CHRISTIAN RODRIGO, GARIN MATIAS
use master
--drop database C2900G21
create database C2900G21 collate SQL_Latin1_General_CP1_CI_AS
go
use C2900G21
go
-- Create Schemas
CREATE SCHEMA Clinica;
go

CREATE SCHEMA Admin;
go

----LIMPIAR TABLES
--DROP TABLES
--DROP TABLE Admin.Usuario GO
--DROP TABLE Clinica.Paciente GO
--DROP TABLE Clinica.Estudio GO
--DROP TABLE Clinica.Cobertura GO
--DROP TABLE Clinica.Prestador GO
--DROP TABLE Clinica.Domicilio GO
--DROP TABLE Clinica.Tipo_Turno GO
--DROP TABLE Clinica.Medico GO
--DROP TABLE Clinica.Especialidad GO
--DROP TABLE Clinica.Sede GO
--DROP TABLE Clinica.Relacion_Paciente_Cobertura GO
--DROP TABLE Clinica.Turno GO
--DROP TABLE Clinica.Turno GO
--DROP TABLE Clinica.DiasXSede GO

----DELETE TABLES
--DELETE TABLE Admin.Usuario GO
--DELETE TABLE Clinica.Paciente GO
--DELETE TABLE Clinica.Estudio GO
--DELETE TABLE Clinica.Cobertura GO
--DELETE TABLE Clinica.Prestador GO
--DELETE TABLE Clinica.Domicilio GO
--DELETE TABLE Clinica.Tipo_Turno GO
--DELETE TABLE Clinica.Medico GO
--DELETE TABLE Clinica.Especialidad GO
--DELETE TABLE Clinica.Sede GO
--DELETE TABLE Clinica.Relacion_Paciente_Cobertura GO
--DELETE TABLE Clinica.Turno GO
--DELETE TABLE Clinica.Turno GO
--DELETE TABLE Clinica.DiasXSede GO


--CREAR TABLAS
CREATE TABLE Admin.Usuario (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    contraseña VARCHAR(255) NOT NULL,
    fecha_creacion DATETIME NOT NULL
);

CREATE TABLE Clinica.Paciente (
    id_historia_clinica INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    apellido_materno VARCHAR(255),
    fecha_nacimiento DATE NOT NULL,
    tipo_documento VARCHAR(50) NOT NULL,
    nro_documento VARCHAR(50) NOT NULL,
    sexo_biologico VARCHAR(50),
    genero VARCHAR(50),
    nacionalidad VARCHAR(50),
    foto_perfil VARCHAR(MAX),
    mail VARCHAR(255),
    telefono VARCHAR(50),
    telefono_contacto_alternativo VARCHAR(50),
    telefono_laboral VARCHAR(50),
    fecha_registro DATETIME NOT NULL,
    fecha_actualizacion DATETIME,
    usuario_actualizacion INT,
    FOREIGN KEY (usuario_actualizacion) REFERENCES Admin.Usuario(id_usuario)
);


CREATE TABLE Clinica.Area (
    id_area INT IDENTITY(1,1) PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL
);

CREATE TABLE Clinica.Estudio (
    id_estudio INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATE NOT NULL,
    nombre_estudio VARCHAR(255) NOT NULL,
    autorizado BIT NOT NULL,
    documento_resultado VARCHAR(MAX),
    imagen_resultado VARCHAR(MAX),
	id_area INT,
	FOREIGN KEY (id_area) REFERENCES Clinica.Area(id_area)
);
CREATE TABLE Clinica.Prestador (
    id_prestador INT IDENTITY(1,1) PRIMARY KEY,
    nombre_prestador VARCHAR(255) NOT NULL,
    plan_prestador VARCHAR(255) NOT NULL
);
CREATE TABLE Clinica.Cobertura (
    id_cobertura INT IDENTITY(1,1) PRIMARY KEY,
    imagen_credencial VARCHAR(MAX),
    nro_socio VARCHAR(50),
    fecha_registro DATE NOT NULL,
	id_historia_clinica int,
	id_prestador int,
	FOREIGN KEY (id_historia_clinica) REFERENCES Clinica.Paciente(id_historia_clinica),
	FOREIGN KEY (id_prestador) REFERENCES Clinica.Prestador(id_prestador)
);



CREATE TABLE Clinica.Domicilio (
    id_domicilio INT IDENTITY(1,1) PRIMARY KEY,
    calle VARCHAR(255) NOT NULL,
    numero VARCHAR(50) NOT NULL,
    piso VARCHAR(50),
    departamento VARCHAR(50),
    codigo_postal VARCHAR(20) NULL,
    provincia VARCHAR(255) NOT NULL,
    localidad VARCHAR(255) NOT NULL,
	id_historia_clinica INT NOT NULL,
	FOREIGN KEY (id_historia_clinica) REFERENCES Clinica.Paciente(id_historia_clinica)
);

CREATE TABLE Clinica.Tipo_Turno (
    id_tipo_turno INT IDENTITY(1,1) PRIMARY KEY,
    nombre_tipo_turno VARCHAR(255) NOT NULL
);

CREATE TABLE Clinica.Especialidad (
    id_especialidad INT IDENTITY(1,1) PRIMARY KEY,
    nombre_especialidad VARCHAR(255) NOT NULL
);

CREATE TABLE Clinica.Medico (
    id_medico INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    nro_matricula VARCHAR(50) NOT NULL,
	id_especialidad INT NOT NULL,
	FOREIGN KEY  (id_especialidad) REFERENCES Clinica.Especialidad(id_especialidad)
);


CREATE TABLE Clinica.Sede (
    id_sede INT IDENTITY(1,1) PRIMARY KEY,
    nombre_sede VARCHAR(255) NOT NULL,
    direccion_sede VARCHAR(255) NOT NULL
);

CREATE TABLE Clinica.Estado_Turno (
	id_estado int IDENTITY(1,1) PRIMARY KEY,
	Nombre_estado varchar(50)
)

CREATE TABLE Clinica.DiasXSede (
    id_sede INT,
    id_medico INT,
    hora_inicio TIME NOT NULL,
	dia_semana int,
    PRIMARY KEY (id_sede, id_medico),
    FOREIGN KEY (id_sede) REFERENCES Clinica.Sede(id_sede),
    FOREIGN KEY (id_medico) REFERENCES Clinica.Medico(id_medico)
);

CREATE TABLE Clinica.Turno (
    id_turno INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATETIME NOT NULL,
    id_medico INT NOT NULL,
    id_sede int NOT NULL,
	id_historia_clinica INT NOT NULL,
	id_tipo_turno INT NOT NULL,
	id_estado int NOT NULL,
    id_estudio INT,
    FOREIGN KEY (id_sede,id_medico) REFERENCES Clinica.DiasXSede(id_sede,id_medico),
    FOREIGN KEY (id_estudio) REFERENCES Clinica.Estudio(id_estudio),
    FOREIGN KEY (id_tipo_turno) REFERENCES Clinica.Tipo_Turno(id_tipo_turno),
    FOREIGN KEY (id_estado) REFERENCES Clinica.Estado_Turno(id_estado),
	FOREIGN KEY (id_historia_clinica) REFERENCES Clinica.Paciente(id_historia_clinica)
);




CREATE TABLE Clinica.EstudioPrestador (
    id_estudio INT NOT NULL,
    id_prestador INT NOT NULL,
    porcentaje FLOAT NOT NULL,
    costo FLOAT NOT NULL,
    PRIMARY KEY (id_estudio, id_prestador),
    FOREIGN KEY (id_estudio) REFERENCES Clinica.Estudio(id_estudio),
    FOREIGN KEY (id_prestador) REFERENCES Clinica.Prestador(id_prestador)
);
go
------ STORED PROCEDURES ------

-- Procedimiento para Insertar en Admin.Usuario
CREATE PROCEDURE Admin.InsertarUsuario
    @contraseña VARCHAR(255),
    @fecha_creacion DATETIME
AS
BEGIN
    INSERT INTO Admin.Usuario (contraseña, fecha_creacion)
    VALUES (@contraseña, @fecha_creacion);
END;
GO

-- Procedimiento para Eliminar de Admin.Usuario
CREATE PROCEDURE Admin.EliminarUsuario
    @id_usuario INT
AS
BEGIN
    DELETE FROM Admin.Usuario WHERE id_usuario = @id_usuario;
END;
GO

-- Procedimiento para Actualizar Admin.Usuario
CREATE PROCEDURE Admin.ActualizarUsuario
    @id_usuario INT,
    @contraseña VARCHAR(255),
    @fecha_creacion DATETIME
AS
BEGIN
    UPDATE Admin.Usuario
    SET contraseña = @contraseña, fecha_creacion = @fecha_creacion
    WHERE id_usuario = @id_usuario;
END;
GO

-- Procedimiento para Insertar en Clinica.Paciente
CREATE PROCEDURE Clinica.InsertarPaciente
    @nombre VARCHAR(255),
    @apellido VARCHAR(255),
    @apellido_materno VARCHAR(255),
    @fecha_nacimiento DATE,
    @tipo_documento VARCHAR(50),
    @nro_documento VARCHAR(50),
    @sexo_biologico VARCHAR(50),
    @genero VARCHAR(50),
    @nacionalidad VARCHAR(50),
    @foto_perfil VARCHAR(MAX),
    @mail VARCHAR(255),
    @telefono VARCHAR(50),
    @telefono_contacto_alternativo VARCHAR(50),
    @telefono_laboral VARCHAR(50),
    @fecha_registro DATETIME,
    @fecha_actualizacion DATETIME,
    @usuario_actualizacion INT
AS
BEGIN
    INSERT INTO Clinica.Paciente (
        nombre, apellido, apellido_materno, fecha_nacimiento,
        tipo_documento, nro_documento, sexo_biologico, genero,
        nacionalidad, foto_perfil, mail, telefono,
        telefono_contacto_alternativo, telefono_laboral,
        fecha_registro, fecha_actualizacion, usuario_actualizacion
    )
    VALUES (
        @nombre, @apellido, @apellido_materno, @fecha_nacimiento,
        @tipo_documento, @nro_documento, @sexo_biologico, @genero,
        @nacionalidad, @foto_perfil, @mail, @telefono,
        @telefono_contacto_alternativo, @telefono_laboral,
        @fecha_registro, @fecha_actualizacion, @usuario_actualizacion
    );
END;
GO

-- Procedimiento para Eliminar de Clinica.Paciente
CREATE PROCEDURE Clinica.EliminarPaciente
    @id_historia_clinica INT
AS
BEGIN
    DELETE FROM Clinica.Paciente WHERE id_historia_clinica = @id_historia_clinica;
END;
GO

-- Procedimiento para Actualizar Clinica.Paciente
CREATE PROCEDURE Clinica.ActualizarPaciente
    @id_historia_clinica INT,
    @nombre VARCHAR(255),
    @apellido VARCHAR(255),
    @apellido_materno VARCHAR(255),
    @fecha_nacimiento DATE,
    @tipo_documento VARCHAR(50),
    @nro_documento VARCHAR(50),
    @sexo_biologico VARCHAR(50),
    @genero VARCHAR(50),
    @nacionalidad VARCHAR(50),
    @foto_perfil VARCHAR(MAX),
    @mail VARCHAR(255),
    @telefono VARCHAR(50),
    @telefono_contacto_alternativo VARCHAR(50),
    @telefono_laboral VARCHAR(50),
    @fecha_registro DATETIME,
    @fecha_actualizacion DATETIME,
    @usuario_actualizacion INT
AS
BEGIN
    UPDATE Clinica.Paciente
    SET
        nombre = @nombre,
        apellido = @apellido,
        apellido_materno = @apellido_materno,
        fecha_nacimiento = @fecha_nacimiento,
        tipo_documento = @tipo_documento,
        nro_documento = @nro_documento,
        sexo_biologico = @sexo_biologico,
        genero = @genero,
        nacionalidad = @nacionalidad,
        foto_perfil = @foto_perfil,
        mail = @mail,
        telefono = @telefono,
        telefono_contacto_alternativo = @telefono_contacto_alternativo,
        telefono_laboral = @telefono_laboral,
        fecha_registro = @fecha_registro,
        fecha_actualizacion = @fecha_actualizacion,
        usuario_actualizacion = @usuario_actualizacion
    WHERE id_historia_clinica = @id_historia_clinica;
END;
GO

-- Procedimiento para Insertar en Clinica.Area
CREATE PROCEDURE Clinica.InsertarArea
    @descripcion VARCHAR(255)
AS
BEGIN
    INSERT INTO Clinica.Area (descripcion)
    VALUES (@descripcion);
END;
GO

-- Procedimiento para Eliminar de Clinica.Area
CREATE PROCEDURE Clinica.EliminarArea
    @id_area INT
AS
BEGIN
    DELETE FROM Clinica.Area WHERE id_area = @id_area;
END;
GO

-- Procedimiento para Actualizar Clinica.Area
CREATE PROCEDURE Clinica.ActualizarArea
    @id_area INT,
    @descripcion VARCHAR(255)
AS
BEGIN
    UPDATE Clinica.Area
    SET descripcion = @descripcion
    WHERE id_area = @id_area;
END;
GO

-- Procedimiento para Insertar en Clinica.Estudio
CREATE PROCEDURE Clinica.InsertarEstudio
    @fecha DATE,
    @nombre_estudio VARCHAR(255),
    @autorizado BIT,
    @documento_resultado VARCHAR(MAX),
    @imagen_resultado VARCHAR(MAX),
    @id_area INT
AS
BEGIN
    INSERT INTO Clinica.Estudio (
        fecha, nombre_estudio, autorizado, documento_resultado,
        imagen_resultado, id_area
    )
    VALUES (
        @fecha, @nombre_estudio, @autorizado, @documento_resultado,
        @imagen_resultado, @id_area
    );
END;
GO

-- Procedimiento para Eliminar de Clinica.Estudio
CREATE PROCEDURE Clinica.EliminarEstudio
    @id_estudio INT
AS
BEGIN
    DELETE FROM Clinica.Estudio WHERE id_estudio = @id_estudio;
END;
GO

-- Procedimiento para Actualizar Clinica.Estudio
CREATE PROCEDURE Clinica.ActualizarEstudio
    @id_estudio INT,
    @fecha DATE,
    @nombre_estudio VARCHAR(255),
    @autorizado BIT,
    @documento_resultado VARCHAR(MAX),
    @imagen_resultado VARCHAR(MAX),
    @id_area INT
AS
BEGIN
    UPDATE Clinica.Estudio
    SET
        fecha = @fecha,
        nombre_estudio = @nombre_estudio,
        autorizado = @autorizado,
        documento_resultado = @documento_resultado,
        imagen_resultado = @imagen_resultado,
        id_area = @id_area
    WHERE id_estudio = @id_estudio;
END;
GO

-- Procedimiento para Insertar en Clinica.Prestador
CREATE PROCEDURE Clinica.InsertarPrestador
    @nombre_prestador VARCHAR(255),
    @plan_prestador VARCHAR(255)
AS
BEGIN
    INSERT INTO Clinica.Prestador (nombre_prestador, plan_prestador)
    VALUES (@nombre_prestador, @plan_prestador);
END;
GO

-- Procedimiento para Eliminar de Clinica.Prestador
CREATE PROCEDURE Clinica.EliminarPrestador
    @id_prestador INT
AS
BEGIN
    DELETE FROM Clinica.Prestador WHERE id_prestador = @id_prestador;
END;
GO

-- Procedimiento para Actualizar Clinica.Prestador
CREATE PROCEDURE Clinica.ActualizarPrestador
    @id_prestador INT,
    @nombre_prestador VARCHAR(255),
    @plan_prestador VARCHAR(255)
AS
BEGIN
    UPDATE Clinica.Prestador
    SET
        nombre_prestador = @nombre_prestador,
        plan_prestador = @plan_prestador
    WHERE id_prestador = @id_prestador;
END;
GO

-- Procedimiento para Insertar en Clinica.Cobertura
CREATE PROCEDURE Clinica.InsertarCobertura
    @imagen_credencial VARCHAR(MAX),
    @nro_socio VARCHAR(50),
    @fecha_registro DATE,
    @id_historia_clinica INT,
    @id_prestador INT
AS
BEGIN
    INSERT INTO Clinica.Cobertura (
        imagen_credencial, nro_socio, fecha_registro,
        id_historia_clinica, id_prestador
    )
    VALUES (
        @imagen_credencial, @nro_socio, @fecha_registro,
        @id_historia_clinica, @id_prestador
    );
END;
GO

-- Procedimiento para Eliminar de Clinica.Cobertura
CREATE PROCEDURE Clinica.EliminarCobertura
    @id_cobertura INT
AS
BEGIN
    DELETE FROM Clinica.Cobertura WHERE id_cobertura = @id_cobertura;
END;
GO

-- Procedimiento para Actualizar Clinica.Cobertura
CREATE PROCEDURE Clinica.ActualizarCobertura
    @id_cobertura INT,
    @imagen_credencial VARCHAR(MAX),
    @nro_socio VARCHAR(50),
    @fecha_registro DATE,
    @id_historia_clinica INT,
    @id_prestador INT
AS
BEGIN
    UPDATE Clinica.Cobertura
    SET
        imagen_credencial = @imagen_credencial,
        nro_socio = @nro_socio,
        fecha_registro = @fecha_registro,
        id_historia_clinica = @id_historia_clinica,
        id_prestador = @id_prestador
    WHERE id_cobertura = @id_cobertura;
END;
GO

-- Procedimiento para Insertar en Clinica.Domicilio
CREATE PROCEDURE Clinica.InsertarDomicilio
    @calle VARCHAR(255),
    @numero VARCHAR(50),
    @piso VARCHAR(50),
    @departamento VARCHAR(50),
    @codigo_postal VARCHAR(20),
    @provincia VARCHAR(255),
    @localidad VARCHAR(255),
    @id_historia_clinica INT
AS
BEGIN
    INSERT INTO Clinica.Domicilio (
        calle, numero, piso, departamento,
        codigo_postal, provincia, localidad,
        id_historia_clinica
    )
    VALUES (
        @calle, @numero, @piso, @departamento,
        @codigo_postal, @provincia, @localidad,
        @id_historia_clinica
    );
END;
GO

-- Procedimiento para Eliminar en Clinica.Domicilio
CREATE PROCEDURE Clinica.EliminarDomicilio
    @id_domicilio INT
AS
BEGIN
    DELETE FROM Clinica.Domicilio WHERE id_domicilio = @id_domicilio;
END;
GO

-- Procedimiento para Actualizar Clinica.Domicilio
CREATE PROCEDURE Clinica.ActualizarDomicilio
    @id_domicilio INT,
    @calle VARCHAR(255),
    @numero VARCHAR(50),
    @piso VARCHAR(50),
    @departamento VARCHAR(50),
    @codigo_postal VARCHAR(20),
    @provincia VARCHAR(255),
    @localidad VARCHAR(255),
    @id_historia_clinica INT
AS
BEGIN
    UPDATE Clinica.Domicilio
    SET
        calle = @calle,
        numero = @numero,
        piso = @piso,
        departamento = @departamento,
        codigo_postal = @codigo_postal,
        provincia = @provincia,
        localidad = @localidad,
        id_historia_clinica = @id_historia_clinica
    WHERE id_domicilio = @id_domicilio;
END;
GO

-- Procedimiento para insertar en Clinica.Tipo_Turno
CREATE PROCEDURE Clinica.InsertarTipoTurno
    @nombre_tipo_turno VARCHAR(255)
AS
BEGIN
    INSERT INTO Clinica.Tipo_Turno (nombre_tipo_turno)
    VALUES (@nombre_tipo_turno);
END;
GO

-- Procedimiento para borrar en Clinica.Tipo_Turno
CREATE PROCEDURE Clinica.EliminarTipoTurno
    @id_tipo_turno INT
AS
BEGIN
    DELETE FROM Clinica.Tipo_Turno WHERE id_tipo_turno = @id_tipo_turno;
END;
GO

-- Procedimiento para Actualizar Clinica.Tipo_Turno
CREATE PROCEDURE Clinica.ActualizarTipoTurno
    @id_tipo_turno INT,
    @nombre_tipo_turno VARCHAR(255)
AS
BEGIN
    UPDATE Clinica.Tipo_Turno
    SET nombre_tipo_turno = @nombre_tipo_turno
    WHERE id_tipo_turno = @id_tipo_turno;
END;
GO

-- Procedimiento para insertar en Clinica.Especialidad
CREATE PROCEDURE Clinica.InsertarEspecialidad
    @nombre_especialidad VARCHAR(255)
AS
BEGIN
    INSERT INTO Clinica.Especialidad (nombre_especialidad)
    VALUES (@nombre_especialidad);
END;
GO

-- Procedimiento para Eliminar en Clinica.Especialidad
CREATE PROCEDURE Clinica.EliminarEspecialidad
    @id_especialidad INT
AS
BEGIN
    DELETE FROM Clinica.Especialidad WHERE id_especialidad = @id_especialidad;
END;
GO

-- Procedimiento para Actualizar Clinica.Especialidad
CREATE PROCEDURE Clinica.ActualizarEspecialidad
    @id_especialidad INT,
    @nombre_especialidad VARCHAR(255)
AS
BEGIN
    UPDATE Clinica.Especialidad
    SET nombre_especialidad = @nombre_especialidad
    WHERE id_especialidad = @id_especialidad;
END;
GO

-- Procedimiento para insertar en into Clinica.Medico
CREATE PROCEDURE Clinica.InsertarMedico
    @nombre VARCHAR(255),
    @apellido VARCHAR(255),
    @nro_matricula VARCHAR(50),
    @id_especialidad INT
AS
BEGIN
    INSERT INTO Clinica.Medico (
        nombre, apellido, nro_matricula, id_especialidad
    )
    VALUES (
        @nombre, @apellido, @nro_matricula, @id_especialidad
    );
END;
GO

-- Procedimiento para Eliminar en Clinica.Medico
CREATE PROCEDURE Clinica.EliminarMedico
    @id_medico INT
AS
BEGIN
    DELETE FROM Clinica.Medico WHERE id_medico = @id_medico;
END;
GO

-- Procedimiento para Actualizar Clinica.Medico
CREATE PROCEDURE Clinica.ActualizarMedico
    @id_medico INT,
    @nombre VARCHAR(255),
    @apellido VARCHAR(255),
    @nro_matricula VARCHAR(50),
    @id_especialidad INT
AS
BEGIN
    UPDATE Clinica.Medico
    SET
        nombre = @nombre,
        apellido = @apellido,
        nro_matricula = @nro_matricula,
        id_especialidad = @id_especialidad
    WHERE id_medico = @id_medico;
END;
GO

--- Procedimiento para Insertar en Clinica.Sede
CREATE PROCEDURE Clinica.InsertarSede
    @nombre_sede VARCHAR(255),
    @direccion_sede VARCHAR(255)
AS
BEGIN
    INSERT INTO Clinica.Sede (
        nombre_sede, direccion_sede
    )
    VALUES (
        @nombre_sede, @direccion_sede
    );
END;
GO

-- Procedimiento para Eliminar de Clinica.Sede
CREATE PROCEDURE Clinica.EliminarSede
    @id_sede INT
AS
BEGIN
    DELETE FROM Clinica.Sede WHERE id_sede = @id_sede;
END;
GO

-- Procedimiento para Actualizar Clinica.Sede
CREATE PROCEDURE Clinica.ActualizarSede
    @id_sede INT,
    @nombre_sede VARCHAR(255),
    @direccion_sede VARCHAR(255)
AS
BEGIN
    UPDATE Clinica.Sede
    SET
        nombre_sede = @nombre_sede,
        direccion_sede = @direccion_sede
    WHERE id_sede = @id_sede;
END;
GO

-- Procedimiento para Insertar en Clinica.Estado_Turno
CREATE PROCEDURE Clinica.InsertarEstadoTurno
    @Nombre_estado VARCHAR(50)
AS
BEGIN
    INSERT INTO Clinica.Estado_Turno (
        Nombre_estado
    )
    VALUES (
        @Nombre_estado
    );
END;
GO

-- Procedimiento para Eliminar de Clinica.Estado_Turno
CREATE PROCEDURE Clinica.EliminarEstadoTurno
    @id_estado INT
AS
BEGIN
    DELETE FROM Clinica.Estado_Turno WHERE id_estado = @id_estado;
END;
GO

-- Procedimiento para Actualizar Clinica.Estado_Turno
CREATE PROCEDURE Clinica.ActualizarEstadoTurno
    @id_estado INT,
    @Nombre_estado VARCHAR(50)
AS
BEGIN
    UPDATE Clinica.Estado_Turno
    SET
        Nombre_estado = @Nombre_estado
    WHERE id_estado = @id_estado;
END;
GO

-- Procedimiento para Insertar en Clinica.Turno
CREATE PROCEDURE Clinica.InsertarTurno
    @fecha DATETIME,
    @id_medico INT,
    @id_sede INT,
    @id_estudio INT,
    @id_tipo_turno INT,
    @id_historia_clinica INT,
    @id_estado INT
AS
BEGIN
	--Validar minutos en intervalos de 15
	 IF DATEPART(MINUTE, @fecha) % 15 != 0
		BEGIN
			RAISERROR('La hora del turno debe ser en intervalos de 15 minutos: 00, 15, 30, 45.', 16, 1);
			RETURN;
		END
	DECLARE @dia_semana int;
	SET @dia_semana = DATEPART(WEEKDAY, @fecha);  -- Obtener el día de la semana de la fecha
	IF NOT EXISTS (
        SELECT 1
        FROM Clinica.DiasXSede
        WHERE id_medico = @id_medico
          AND id_sede = @id_sede
          AND dia_semana = @dia_semana
    )
    BEGIN
        -- Si no es válido, arrojar un error y retornar
        RAISERROR('El día de la semana para la fecha proporcionada no es válido para el médico y la sede especificados.', 16, 1);
        RETURN;
    END
	-- Insertar el turno
    INSERT INTO Clinica.Turno (
        fecha, id_medico,
        id_estudio, id_tipo_turno,
        id_historia_clinica, id_estado
    )
    VALUES (
        @fecha, @id_medico,
        @id_estudio, @id_tipo_turno,
        @id_historia_clinica, @id_estado
    );
END;
GO

-- Procedimiento para Eliminar de Clinica.Turno
CREATE PROCEDURE Clinica.EliminarTurno
    @id_turno INT
AS
BEGIN
    DELETE FROM Clinica.Turno WHERE id_turno = @id_turno;
END;
GO

-- Procedimiento para Actualizar Clinica.Turno
CREATE PROCEDURE Clinica.ActualizarTurno
    @id_turno INT,
    @fecha DATETIME,
    @id_medico INT,
    @id_sede INT,
    @id_estudio INT,
    @id_tipo_turno INT,
    @id_historia_clinica INT,
    @id_estado INT
AS
BEGIN
	--Validar minutos en intervalos de 15
	 IF DATEPART(MINUTE, @fecha) % 15 != 0
		BEGIN
			-- If not, raise an error and return
			RAISERROR('La hora del turno debe ser en intervalos de 15 minutos: 00, 15, 30, 45.', 16, 1);
			RETURN;
		END
		    DECLARE @dia_semana INT;
    SET @dia_semana = DATEPART(WEEKDAY, @fecha);  -- Obtener el día de la semana de la fecha

    -- Verificar si el día es válido para el médico y la sede
    IF NOT EXISTS (
        SELECT 1
        FROM Clinica.DiasXSede
        WHERE id_medico = @id_medico
          AND id_sede = @id_sede
          AND dia_semana = @dia_semana
    )
    BEGIN
        -- Si no es válido, arrojar un error y retornar
        RAISERROR('El día de la semana para la fecha proporcionada no es válido para el médico y la sede especificados.', 16, 1);
        RETURN;
    END
	--Actualizar turno
    UPDATE Clinica.Turno
    SET
        fecha = @fecha,
        id_medico = @id_medico,
        id_estudio = @id_estudio,
        id_tipo_turno = @id_tipo_turno,
        id_historia_clinica = @id_historia_clinica,
        id_estado = @id_estado
    WHERE id_turno = @id_turno;
END;
GO

-- Procedimiento para Insertar en Clinica.DiasXSede
CREATE PROCEDURE Clinica.InsertarDiasXSede
    @id_sede INT,
    @id_medico INT,
    @hora_inicio TIME
AS
BEGIN
    INSERT INTO Clinica.DiasXSede (
        id_sede, id_medico, hora_inicio
    )
    VALUES (
        @id_sede, @id_medico, @hora_inicio
    );
END;
GO

-- Procedimiento para Eliminar de Clinica.DiasXSede
CREATE PROCEDURE Clinica.EliminarDiasXSede
    @id_sede INT,
    @id_medico INT
AS
BEGIN
    DELETE FROM Clinica.DiasXSede
    WHERE id_sede = @id_sede AND id_medico = @id_medico;
END;
GO

-- Procedimiento para Actualizar Clinica.DiasXSede
CREATE PROCEDURE Clinica.ActualizarDiasXSede
    @id_sede INT,
    @id_medico INT,
    @hora_inicio TIME
AS
BEGIN
    UPDATE Clinica.DiasXSede
    SET hora_inicio = @hora_inicio
    WHERE id_sede = @id_sede AND id_medico = @id_medico;
END;
GO

-- Procedimiento para Insertar en Clinica.EstudioPrestador
CREATE PROCEDURE Clinica.InsertarEstudioPrestador
    @id_estudio INT,
    @id_prestador INT,
    @porcentaje FLOAT,
    @costo FLOAT
AS
BEGIN
    INSERT INTO Clinica.EstudioPrestador (
        id_estudio, id_prestador, porcentaje, costo
    )
    VALUES (
        @id_estudio, @id_prestador, @porcentaje, @costo
    );
END;
GO

-- Procedimiento para Eliminar de Clinica.EstudioPrestador
CREATE PROCEDURE Clinica.EliminarEstudioPrestador
    @id_estudio INT,
    @id_prestador INT
AS
BEGIN
    DELETE FROM Clinica.EstudioPrestador
    WHERE id_estudio = @id_estudio AND id_prestador = @id_prestador;
END;
GO

-- Procedimiento para Actualizar Clinica.EstudioPrestador
CREATE PROCEDURE Clinica.ActualizarEstudioPrestador
    @id_estudio INT,
    @id_prestador INT,
    @porcentaje FLOAT,
    @costo FLOAT
AS
BEGIN
    UPDATE Clinica.EstudioPrestador
    SET
        porcentaje = @porcentaje,
        costo = @costo
    WHERE id_estudio = @id_estudio AND id_prestador = @id_prestador;
END;
GO

-- SP medicos.csv
CREATE PROCEDURE [Clinica].[ImportarMedicosDesdeCSV]
@ruta varchar(200)
AS
BEGIN
    CREATE TABLE #temp_medicos (
	    apellido VARCHAR(255),
        nombre VARCHAR(255),
		nombre_especialidad varchar(255),
        nro_matricula VARCHAR(50)
    );

    -- Importar datos CSV a la tabla temporal
	DECLARE @bulksql NVARCHAR(1000);
	SET @bulksql = N'
	BULK INSERT #temp_medicos
    FROM '''+@ruta+'''
    WITH (
        FIELDTERMINATOR = '';'',  
        ROWTERMINATOR = ''\n'',  
		DATAFILETYPE = ''char'',
		CODEPAGE = ''65001'',
        FIRSTROW = 2           
    );
	'
	EXEC sp_executesql @bulksql;
	insert into Clinica.Especialidad (nombre_especialidad) 
	select tm.nombre_especialidad
	FROM #temp_medicos tm
	left join Clinica.Especialidad e on e.nombre_especialidad = tm.nombre_especialidad COLLATE SQL_Latin1_General_CP1_CI_AI
	where e.id_especialidad is null
	group by tm.nombre_especialidad

    -- Insertar datos de la tabla temporal en la tabla permanente medicos
    INSERT INTO Clinica.medico (nombre, apellido, nro_matricula, id_especialidad)
    SELECT tm.nombre, tm.apellido, tm.nro_matricula, e.id_especialidad
    FROM #temp_medicos tm
	inner join Clinica.Especialidad e on e.nombre_especialidad = tm.nombre_especialidad COLLATE SQL_Latin1_General_CP1_CI_AI
	left join Clinica.medico m on m.nombre = tm.nombre and m.apellido = tm.apellido and tm.nro_matricula = m.nro_matricula and e.id_especialidad = m.id_especialidad
	where m.id_medico is null
    -- Eliminar la tabla temporal
    DROP TABLE #temp_medicos;
END;
GO
-- SP pacientes.csv
CREATE PROCEDURE [Clinica].[ImportarPacientesDesdeCSV]
@ruta varchar(200)
AS
BEGIN
    CREATE TABLE #temp_pacientes (
        nombre VARCHAR(255),
        apellido VARCHAR(255),
        fecha_nacimiento VARCHAR(10),
        tipo_documento VARCHAR(50),
        nro_documento VARCHAR(50),
        sexo_biologico VARCHAR(50),
        genero VARCHAR(50),
		telefono VARCHAR(50),
        nacionalidad VARCHAR(50),
		mail VARCHAR(255),
		calle_y_numero VARCHAR(255),
		localidad VARCHAR(255),
		provincia varchar(255)
    );

    -- Importar datos CSV a la tabla temporal
		DECLARE @bulksql NVARCHAR(1000);
		SET @bulksql = N'
		BULK INSERT #temp_pacientes
		FROM '''+@ruta+''' -- Ruta del archivo hardcodeada
		WITH (
			FIELDTERMINATOR = '';'',  
			ROWTERMINATOR = ''\n'',  
			DATAFILETYPE = ''char'',
			CODEPAGE = ''65001'',
			FIRSTROW = 2            
		);
		'
		EXEC sp_executesql @bulksql;
    

    -- Insertar datos de la tabla temporal en la tabla permanente pacientes
    INSERT INTO Clinica.paciente (
        nombre, apellido, fecha_nacimiento, tipo_documento, nro_documento, sexo_biologico,
        genero, nacionalidad, mail, telefono, fecha_registro 
              )
    SELECT tp.nombre, tp.apellido,CONVERT(DATE, tp.fecha_nacimiento, 103), tp.tipo_documento, tp.nro_documento, tp.sexo_biologico,
        tp.genero, tp.nacionalidad, tp.mail, tp.telefono, getdate() 
    FROM #temp_pacientes tp
	left join Clinica.paciente p on p.tipo_documento = tp.tipo_documento and tp.nro_documento = p.nro_documento
	where p.id_historia_clinica is null
	
	INSERT INTO Clinica.Domicilio (calle,numero,localidad,provincia,id_historia_clinica)
	select 
	CASE WHEN
	TRY_CONVERT(INT, RIGHT(TRIM(tp.calle_y_numero), CHARINDEX(' ', REVERSE(TRIM(tp.calle_y_numero))) - 1)) is not null then
		REPLACE(TRIM(LEFT(TRIM(tp.calle_y_numero), LEN(TRIM(tp.calle_y_numero)) - CHARINDEX(' ', REVERSE(TRIM(tp.calle_y_numero))))),'Nº','')
	else tp.calle_y_numero end AS calle,
	CASE WHEN
	TRY_CONVERT(INT, RIGHT(TRIM(tp.calle_y_numero), CHARINDEX(' ', REVERSE(TRIM(tp.calle_y_numero))) - 1)) is not null then
		RIGHT(TRIM(tp.calle_y_numero), CHARINDEX(' ', REVERSE(TRIM(tp.calle_y_numero))) - 1)
	else '' end AS nro,
	tp.localidad,
	tp.provincia,
	p.id_historia_clinica
	FROM #temp_pacientes tp
	inner join Clinica.paciente p on p.tipo_documento = tp.tipo_documento and tp.nro_documento = p.nro_documento
	left join Clinica.Domicilio d on d.id_historia_clinica = p.id_historia_clinica
	where d.id_historia_clinica is null

    -- Eliminar la tabla temporal
    DROP TABLE #temp_pacientes;
END;
GO
-- SP prestadores.csv
CREATE PROCEDURE [Clinica].[ImportarPrestadoresDesdeCSV]
@ruta varchar(200)
AS
BEGIN
    CREATE TABLE #temp_prestadores (
        nombre_prestador VARCHAR(255),
        plan_prestador VARCHAR(255)
    );

    -- Importar datos CSV a la tabla temporal
	DECLARE @bulksql NVARCHAR(1000);
	SET @bulksql = N'
	BULK INSERT #temp_prestadores
    FROM '''+@ruta+''' -- Ruta del archivo hardcodeada
    WITH (
        FIELDTERMINATOR = '';'',  
        ROWTERMINATOR = ''\n'',  
		DATAFILETYPE = ''char'',
		CODEPAGE = ''65001'',
        FIRSTROW = 2             
    );
	'
	EXEC sp_executesql @bulksql;
    

    -- Insertar datos de la tabla temporal en la tabla permanente prestadores
    INSERT INTO Clinica.prestador (nombre_prestador, plan_prestador)
    SELECT tp.nombre_prestador, tp.plan_prestador
    FROM #temp_prestadores tp
	left join clinica.prestador p on p.nombre_prestador = tp.nombre_prestador and p.plan_prestador = tp.plan_prestador
	where p.id_prestador is null


    -- Eliminar la tabla temporal
    DROP TABLE #temp_prestadores;
END;
GO
-- SP sedes.csv
CREATE PROCEDURE [Clinica].[ImportarSedesDesdeCSV]
@ruta varchar(200)
AS
BEGIN
    CREATE TABLE #temp_sedes (
        nombre_sede VARCHAR(255),
		direccion_sede VARCHAR(255),
		localidad_sede VARCHAR(255),
        provincia_sede VARCHAR(255),
    );
	-- Importar datos CSV a la tabla temporal
	DECLARE @bulksql NVARCHAR(1000);
	SET @bulksql = N'BULK INSERT #temp_sedes
    FROM '''+@ruta+'''
    WITH (
        FIELDTERMINATOR = '';'',  
        ROWTERMINATOR = ''\n'',  
		DATAFILETYPE = ''char'',
		CODEPAGE = ''65001'',
        FIRSTROW = 2              
    );'
	EXEC sp_executesql @bulksql;


    -- Insertar datos de la tabla temporal en la tabla permanente sedes
    INSERT INTO Clinica.sede (nombre_sede, direccion_sede)
    SELECT ts.nombre_sede, ts.direccion_sede + ' , ' +  ts.localidad_sede + ' , ' + ts.provincia_sede
    FROM #temp_sedes ts
	left join Clinica.sede s on s.nombre_sede = ts.nombre_sede and s.direccion_sede = ts.direccion_sede + ' , ' +  ts.localidad_sede + ' , ' + ts.provincia_sede
	where s.id_sede is null

    -- Eliminar la tabla temporal
    DROP TABLE #temp_sedes;
END;
GO
-- SP Centro_Autorizaciones.Estudios clinicos.json
CREATE PROCEDURE [Clinica].[ImportarAutorizacionesDesdeJSON]
@ruta varchar(200)
AS
BEGIN
    -- Crear la tabla temporal
	CREATE TABLE #TempData (
		_id VARCHAR(24) ,
		Area VARCHAR(50) ,
		Estudio VARCHAR(50) ,
		Prestador VARCHAR(50) ,
		PlanPrestador VARCHAR(50) ,
		PorcentajeCobertura INT,
		Costo DECIMAL(10, 2),
		RequiereAutorizacion BIT,
	);

	-- Declarar la variable @json y cargar el contenido del archivo JSON
	DECLARE @json VARCHAR(MAX);
	DECLARE @bulksql NVARCHAR(1000);
	SET @bulksql = N'
			DECLARE @json VARCHAR(MAX);
			SELECT @json = convert(varchar(max), coalesce(BulkColumn,'''' collate Latin1_General_100_CI_AS_SC_UTF8 )) collate SQL_Latin1_General_CP1_CI_AS
			FROM OPENROWSET (BULK '''+@ruta+''', SINGLE_BLOB) AS j;
				
			INSERT INTO #TempData (_id, Area, Estudio, Prestador, PlanPrestador, PorcentajeCobertura, Costo, RequiereAutorizacion)
			SELECT
				_id,
				main.Area,
				main.Estudio,
				main.Prestador,
				main.[Plan] AS PlanPrestador,
				main.[Porcentaje Cobertura] AS PorcentajeCobertura,    
				main.Costo,
				main.[Requiere autorizacion] AS RequiereAutorizacion
			FROM OPENJSON(@json) 
			WITH (
				_id VARCHAR(MAX) ''$._id."$oid"'',
				Area VARCHAR(50),
				Estudio VARCHAR(50),
				Prestador VARCHAR(50),
				[Plan] VARCHAR(50),
				[Porcentaje Cobertura] INT,
				Costo DECIMAL(10,2),
				[Requiere autorizacion] BIT
			) main
            ';

	EXEC sp_executesql @bulksql;

	-- Cargar el contenido del archivo JSON en la variable @json


	--Print (@json)

	-- Insertar los datos parseados en la tabla temporal
	INSERT INTO #TempData (_id, Area, Estudio, Prestador, PlanPrestador, PorcentajeCobertura, Costo, RequiereAutorizacion)
	SELECT
		_id,
		main.Area,
		main.Estudio,
		main.Prestador,
		main.[Plan] AS PlanPrestador,
		main.[Porcentaje Cobertura] AS PorcentajeCobertura,    
		main.Costo,
		main.[Requiere autorizacion] AS RequiereAutorizacion
	FROM OPENJSON(@json) 
	WITH (
		_id VARCHAR(MAX) '$._id."$oid"',
		Area VARCHAR(50),
		Estudio VARCHAR(50),
		Prestador VARCHAR(50),
		[Plan] VARCHAR(50),
		[Porcentaje Cobertura] INT,
		Costo DECIMAL(10,2),
		[Requiere autorizacion] BIT
	) main

    -- Insertar datos en la tabla Area si no existen
	INSERT INTO Clinica.Area (descripcion)
	SELECT DISTINCT t.Area 
	FROM #TempData t
	WHERE t.Area is not null AND NOT EXISTS (SELECT 1 FROM Clinica.Area a WHERE a.descripcion = t.Area) ;

	-- Insertar datos en la tabla Estudio si no existen
	INSERT INTO Clinica.Estudio(nombre_estudio,fecha,autorizado)
	SELECT DISTINCT t.Estudio,GETDATE(),t.RequiereAutorizacion
	FROM #TempData t
	WHERE t.Estudio is not null AND t.RequiereAutorizacion is not null AND NOT EXISTS (SELECT 1 FROM Clinica.Estudio e WHERE e.nombre_estudio = t.Estudio) ;

	-- Insertar datos en la tabla Prestador si no existen
	INSERT INTO Clinica.Prestador(nombre_prestador,plan_prestador)
	SELECT DISTINCT t.Prestador, t.PlanPrestador 
	FROM #TempData t
	WHERE t.Prestador is not null AND t.PlanPrestador is not null AND NOT EXISTS (SELECT 1 FROM Clinica.Prestador p WHERE p.nombre_prestador = t.Prestador) ;

	-- Insertar datos en la tabla EstudioPrestador si no existen
	INSERT INTO Clinica.EstudioPrestador (id_estudio, id_prestador, porcentaje, costo)
	SELECT DISTINCT 
		e.id_estudio, 
		p.id_prestador,
		t.PorcentajeCobertura,
		t.Costo
	FROM #TempData t
	LEFT JOIN Clinica.Estudio e ON t.Estudio = e.nombre_estudio
	LEFT JOIN Clinica.Prestador p ON t.Prestador = p.nombre_prestador AND t.PlanPrestador = p.plan_prestador
	WHERE t.Estudio is not null AND t.Prestador is not null and e.id_estudio is not null and 
	NOT EXISTS (
		SELECT 1 
		FROM Clinica.EstudioPrestador 
		WHERE id_estudio = e.id_estudio 
		  AND id_prestador = p.id_prestador
	);

    -- Eliminar la tabla temporal
    DROP TABLE #TempData;
END;
GO
-- SP Genera turnos atendidos en formato XML
CREATE PROCEDURE GenerarXMLTurnosAtendidos
    @nombreObraSocial VARCHAR(255),
    @fechaInicio DATETIME,
    @fechaFin DATETIME
AS
BEGIN
    DECLARE @xmlResult XML;

    SET @xmlResult = (
        SELECT
            P.apellido AS 'Paciente/Apellido',
            P.nombre AS 'Paciente/Nombre',
            P.nro_documento AS 'Paciente/DNI',
            M.nombre AS 'Medico/Nombre',
            M.apellido AS 'Medico/Apellido',
            M.nro_matricula AS 'Medico/Matricula',
            RTM.fecha AS 'Turno/Fecha',
            CONVERT(TIME, RTM.fecha) AS 'Turno/Hora',
            E.nombre_especialidad AS 'Turno/Especialidad'
        FROM
            Clinica.Turno RTM
            INNER JOIN Clinica.Paciente P ON RTM.id_historia_clinica = P.id_historia_clinica
            INNER JOIN Clinica.Medico M ON RTM.id_medico = M.id_medico
            INNER JOIN Clinica.Especialidad E ON M.id_especialidad = E.id_especialidad
            INNER JOIN Clinica.Cobertura C ON P.id_historia_clinica = C.id_historia_clinica
            INNER JOIN Clinica.Prestador PR ON C.id_cobertura = PR.id_prestador
			inner join clinica.Estado_Turno ET on ET.id_estado = RTM.id_estado
        WHERE
            PR.nombre_prestador = @nombreObraSocial AND
            RTM.fecha BETWEEN @fechaInicio AND @fechaFin and ET.Nombre_estado = 'Atendido'
        FOR XML PATH('Turno'), ROOT('Turnos')
    );

    -- Retornar el XML resultante
    SELECT @xmlResult AS ResultadoXML;
END;
GO
-- FIN
