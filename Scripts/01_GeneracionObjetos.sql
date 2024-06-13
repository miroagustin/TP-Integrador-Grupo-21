-- SCRIPT PARA LA CREACION DE QUERYS CLINICA S.A
-- FECHA: 2024-06-11
-- GRUPO: 21
-- INTEGRANTES: FRAGASSI DONATELLA, MIRO AGUSTIN, ROJAS RODRIGUEZ CHRISTIAN RODRIGO, GARIN MATIAS
use master
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
--DROP TABLE Clinica.Relacion_Turno_Medico GO
--DROP TABLE Clinica.Turno GO
--DROP TABLE Clinica.Lista_Sede GO

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
--DELETE TABLE Clinica.Relacion_Turno_Medico GO
--DELETE TABLE Clinica.Turno GO
--DELETE TABLE Clinica.Lista_Sede GO


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


CREATE TABLE Clinica.Turno (
    id_turno INT IDENTITY(1,1) PRIMARY KEY,
    id_estado INT NOT NULL,
    nombre_estado VARCHAR(50) NOT NULL
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

CREATE TABLE Clinica.Cobertura (
    id_cobertura INT IDENTITY(1,1) PRIMARY KEY,
    imagen_credencial VARCHAR(MAX),
    nro_socio VARCHAR(50),
    fecha_registro DATE NOT NULL,
	id_historia_clinica int,
	FOREIGN KEY (id_historia_clinica) REFERENCES Clinica.Paciente(id_historia_clinica)
);

CREATE TABLE Clinica.Prestador (
    id_prestador INT IDENTITY(1,1) PRIMARY KEY,
    nombre_prestador VARCHAR(255) NOT NULL,
    plan_prestador VARCHAR(255) NOT NULL
);

CREATE TABLE Clinica.Domicilio (
    id_domicilio INT IDENTITY(1,1) PRIMARY KEY,
    calle VARCHAR(255) NOT NULL,
    numero VARCHAR(50) NOT NULL,
    piso VARCHAR(50),
    departamento VARCHAR(50),
    codigo_postal VARCHAR(20) NOT NULL,
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

CREATE TABLE Clinica.Relacion_Turno_Medico (
    id_turno INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATETIME NOT NULL,
    id_medico INT NOT NULL,
    id_especialidad INT NOT NULL,
    direccion_atencion VARCHAR(255) NOT NULL,
    id_estudio INT,
    id_tipo_turno INT,
	id_historia_clinica INT,
	id_estado int,
    FOREIGN KEY (id_medico) REFERENCES Clinica.Medico(id_medico),
    FOREIGN KEY (id_especialidad) REFERENCES Clinica.Especialidad(id_especialidad),
    FOREIGN KEY (id_estudio) REFERENCES Clinica.Estudio(id_estudio),
    FOREIGN KEY (id_tipo_turno) REFERENCES Clinica.Tipo_Turno(id_tipo_turno),
    FOREIGN KEY (id_estado) REFERENCES Clinica.Estado_Turno(id_estado),
	FOREIGN KEY (id_historia_clinica) REFERENCES Clinica.Paciente(id_historia_clinica)
);

CREATE TABLE Clinica.Lista_Sede (
    id_sede INT,
    id_medico INT,
    hora_inicio TIME NOT NULL,
    PRIMARY KEY (id_sede, id_medico),
    FOREIGN KEY (id_sede) REFERENCES Clinica.Sede(id_sede),
    FOREIGN KEY (id_medico) REFERENCES Clinica.Medico(id_medico)
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

--INSERTAR PACIENTE
CREATE PROCEDURE Clinica.InsertPaciente (
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
)
AS
BEGIN
    INSERT INTO Clinica.Paciente (
        nombre, apellido, apellido_materno, fecha_nacimiento, tipo_documento, nro_documento,
        sexo_biologico, genero, nacionalidad, foto_perfil, mail, telefono, telefono_contacto_alternativo,
        telefono_laboral, fecha_registro, fecha_actualizacion, usuario_actualizacion
    )
    VALUES (
        @nombre, @apellido, @apellido_materno, @fecha_nacimiento, @tipo_documento, @nro_documento,
        @sexo_biologico, @genero, @nacionalidad, @foto_perfil, @mail, @telefono, @telefono_contacto_alternativo,
        @telefono_laboral, @fecha_registro, @fecha_actualizacion, @usuario_actualizacion
    );
END;
go

-- UPDATE PACIENTE
CREATE PROCEDURE Clinica.UpdatePaciente (
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
)
AS
BEGIN
    UPDATE Clinica.Paciente
    SET nombre = @nombre, apellido = @apellido, apellido_materno = @apellido_materno, fecha_nacimiento = @fecha_nacimiento,
        tipo_documento = @tipo_documento, nro_documento = @nro_documento, sexo_biologico = @sexo_biologico,
        genero = @genero, nacionalidad = @nacionalidad, foto_perfil = @foto_perfil, mail = @mail, telefono = @telefono,
        telefono_contacto_alternativo = @telefono_contacto_alternativo, telefono_laboral = @telefono_laboral,
        fecha_registro = @fecha_registro, fecha_actualizacion = @fecha_actualizacion, usuario_actualizacion = @usuario_actualizacion
    WHERE id_historia_clinica = @id_historia_clinica;
END;
go

--ELIMINAR PACIENTE LOGICO
CREATE PROCEDURE Clinica.DeletePaciente (
    @id_historia_clinica INT
)
AS
BEGIN
    UPDATE Clinica.Paciente
    SET usuario_actualizacion = NULL
    WHERE id_historia_clinica = @id_historia_clinica;
END;
go

--INSERTAR ESTUDIO
CREATE PROCEDURE Clinica.InsertEstudio (
    @fecha DATE,
    @nombre_estudio VARCHAR(255),
    @autorizado BIT,
    @documento_resultado VARCHAR(MAX),
    @imagen_resultado VARCHAR(MAX)
)
AS
BEGIN
    INSERT INTO Clinica.Estudio (
      fecha, nombre_estudio, autorizado, documento_resultado, imagen_resultado
    )
    VALUES (
       @fecha, @nombre_estudio, @autorizado, @documento_resultado, @imagen_resultado
    );
END;
go

--UPDATE ESTUDIO
CREATE PROCEDURE Clinica.UpdateEstudio (
    @id_estudio INT,
    @fecha DATE,
    @nombre_estudio VARCHAR(255),
    @autorizado BIT,
    @documento_resultado VARCHAR(MAX),
    @imagen_resultado VARCHAR(MAX)
)
AS
BEGIN
    UPDATE Clinica.Estudio
    SET fecha = @fecha, nombre_estudio = @nombre_estudio, autorizado = @autorizado,
        documento_resultado = @documento_resultado, imagen_resultado = @imagen_resultado
    WHERE id_estudio = @id_estudio;
END;
go

--ELIMINAR ESTUDIO LOGICO
CREATE PROCEDURE Clinica.DeleteEstudio (
    @id_estudio INT
)
AS
BEGIN
    UPDATE Clinica.Estudio
    SET autorizado = 0
    WHERE id_estudio = @id_estudio;
END;
go

--INSERTAR COBERTURA
CREATE PROCEDURE Clinica.InsertCobertura (
    @imagen_credencial VARCHAR(MAX),
    @nro_socio VARCHAR(50),
    @fecha_registro DATE
)
AS
BEGIN
    INSERT INTO Clinica.Cobertura (
       imagen_credencial, nro_socio, fecha_registro
    )
    VALUES (
       @imagen_credencial, @nro_socio, @fecha_registro
    );
END;
go
--UPDATE COBERTURA
CREATE PROCEDURE Clinica.UpdateCobertura (
    @id_cobertura INT,
    @imagen_credencial VARCHAR(MAX),
    @nro_socio VARCHAR(50),
    @fecha_registro DATE
)
AS
BEGIN
    UPDATE Clinica.Cobertura
    SET imagen_credencial = @imagen_credencial, nro_socio = @nro_socio, fecha_registro = @fecha_registro
    WHERE id_cobertura = @id_cobertura;
END;
go
-- ELIMINAR COBERTURA FISICO
CREATE PROCEDURE Clinica.DeleteCobertura (
    @id_cobertura INT
)
AS
BEGIN
    DELETE FROM Clinica.Cobertura
    WHERE id_cobertura = @id_cobertura;
END;
go
-- INSERTAR PRESTADOR
CREATE PROCEDURE Clinica.InsertPrestador (
    @id_prestador INT,
    @nombre_prestador VARCHAR(255),
    @plan_prestador VARCHAR(255)
)
AS
BEGIN
    INSERT INTO Clinica.Prestador (
       nombre_prestador, plan_prestador
    )
    VALUES (
       @nombre_prestador, @plan_prestador
    );
END;
go
-- UPDATE PRESTADOR
CREATE PROCEDURE Clinica.UpdatePrestador (
    @id_prestador INT,
    @nombre_prestador VARCHAR(255),
    @plan_prestador VARCHAR(255)
)
AS
BEGIN
    UPDATE Clinica.Prestador
    SET nombre_prestador = @nombre_prestador, plan_prestador = @plan_prestador
    WHERE id_prestador = @id_prestador;
END;
go
-- ELIMINAR PRESTADOR FISICO
CREATE PROCEDURE Clinica.DeletePrestador (
    @id_prestador INT
)
AS
BEGIN
    DELETE FROM Clinica.Prestador
    WHERE id_prestador = @id_prestador;
END;
go
-- INSERTAR DOMICILIO
CREATE PROCEDURE Clinica.InsertDomicilio (
   
    @calle VARCHAR(255),
    @numero VARCHAR(50),
    @piso VARCHAR(50),
    @departamento VARCHAR(50),
    @codigo_postal VARCHAR(20),
    @provincia VARCHAR(255),
    @localidad VARCHAR(255)
)
AS
BEGIN
    INSERT INTO Clinica.Domicilio (
       calle, numero, piso, departamento, codigo_postal, provincia, localidad
    )
    VALUES (
         @calle, @numero, @piso, @departamento, @codigo_postal, @provincia, @localidad
    );
END;
go
-- UPDATE DOMICILIO
CREATE PROCEDURE Clinica.UpdateDomicilio (
    @id_domicilio INT,
    @calle VARCHAR(255),
    @numero VARCHAR(50),
    @piso VARCHAR(50),
    @departamento VARCHAR(50),
    @codigo_postal VARCHAR(20),
    @provincia VARCHAR(255),
    @localidad VARCHAR(255)
)
AS
BEGIN
    UPDATE Clinica.Domicilio
    SET calle = @calle, numero = @numero, piso = @piso, departamento = @departamento,
        codigo_postal = @codigo_postal, provincia = @provincia, localidad = @localidad
    WHERE id_domicilio = @id_domicilio;
END;
go
-- ELIMINAR DOMICILIO FISICO
CREATE PROCEDURE Clinica.DeleteDomicilio (
    @id_domicilio INT
)
AS
BEGIN
    DELETE FROM Clinica.Domicilio
    WHERE id_domicilio = @id_domicilio;
END;
go
-- INSERT TIPO TURNO
CREATE PROCEDURE Clinica.InsertTipoTurno (
   
    @nombre_tipo_turno VARCHAR(255)
)
AS
BEGIN
    INSERT INTO Clinica.Tipo_Turno (
      nombre_tipo_turno
    )
    VALUES (
      @nombre_tipo_turno
    );
END;
go
-- UPDATE TIPO TURNO
CREATE PROCEDURE Clinica.UpdateTipoTurno (
    @id_tipo_turno INT,
    @nombre_tipo_turno VARCHAR(255)
)
AS
BEGIN
    UPDATE Clinica.Tipo_Turno
    SET nombre_tipo_turno = @nombre_tipo_turno
    WHERE id_tipo_turno = @id_tipo_turno;
END;
go
-- PELIMINAR TIPO TURNO FISICO
CREATE PROCEDURE Clinica.DeleteTipoTurno (
    @id_tipo_turno INT
)
AS
BEGIN
    DELETE FROM Clinica.Tipo_Turno
    WHERE id_tipo_turno = @id_tipo_turno;
END;
go

-- INSERTAR MEDICO
CREATE PROCEDURE Clinica.InsertMedico (
   
    @nombre VARCHAR(255),
    @apellido VARCHAR(255),
    @nro_matricula VARCHAR(50)
)
AS
BEGIN
    INSERT INTO Clinica.Medico (
       nombre, apellido, nro_matricula
    )
    VALUES (
       @nombre, @apellido, @nro_matricula
    );
END;
go
-- UPDATE MEDICO
CREATE PROCEDURE Clinica.UpdateMedico (
    @id_medico INT,
    @nombre VARCHAR(255),
    @apellido VARCHAR(255),
    @nro_matricula VARCHAR(50)
)
AS
BEGIN
    UPDATE Clinica.Medico
    SET nombre = @nombre, apellido = @apellido, nro_matricula = @nro_matricula
    WHERE id_medico = @id_medico;
END;
go
-- ELIMINAR MEDICO FISICO
CREATE PROCEDURE Clinica.DeleteMedico (
    @id_medico INT
)
AS
BEGIN
    DELETE FROM Clinica.Medico
    WHERE id_medico = @id_medico;
END;
go

-- INSERTAR ESPECIALIDAD
CREATE PROCEDURE Clinica.InsertEspecialidad (
    @nombre_especialidad VARCHAR(255)
)
AS
BEGIN
    INSERT INTO Clinica.Especialidad (
        nombre_especialidad
    )
    VALUES (
        @nombre_especialidad
    );
END;
go
-- UPDATE ESPECIALIDAD
CREATE PROCEDURE Clinica.UpdateEspecialidad (
    @id_especialidad INT,
    @nombre_especialidad VARCHAR(255)
)
AS
BEGIN
    UPDATE Clinica.Especialidad
    SET nombre_especialidad = @nombre_especialidad
    WHERE id_especialidad = @id_especialidad;
END;
go
-- ELIMINAR ESPECIALIDAD FISICO
CREATE PROCEDURE Clinica.DeleteEspecialidad (
    @id_especialidad INT
)
AS
BEGIN
    DELETE FROM Clinica.Especialidad
    WHERE id_especialidad = @id_especialidad;
END;
go
-- INSERTAR SEDE
CREATE PROCEDURE Clinica.InsertSede (
    @nombre_sede VARCHAR(255),
    @direccion_sede VARCHAR(255)
)
AS
BEGIN
    INSERT INTO Clinica.Sede (
     nombre_sede, direccion_sede
    )
    VALUES (
         @nombre_sede, @direccion_sede
    );
END;
go
-- UPDATE SEDE
CREATE PROCEDURE Clinica.UpdateSede (
    @id_sede INT,
    @nombre_sede VARCHAR(255),
    @direccion_sede VARCHAR(255)
)
AS
BEGIN
    UPDATE Clinica.Sede
    SET nombre_sede = @nombre_sede, direccion_sede = @direccion_sede
    WHERE id_sede = @id_sede;
END;
go
-- ELIMINAR SEDE FISICO
CREATE PROCEDURE Clinica.DeleteSede (
    @id_sede INT
)
AS
BEGIN
    DELETE FROM Clinica.Sede
    WHERE id_sede = @id_sede;
END;
go
-- INSERTAR RELACION TURNO MEDICO
CREATE PROCEDURE Clinica.InsertRelacionTurnoMedico (
    @id_turno INT,
    @fecha DATETIME,
    @id_medico INT,
    @id_especialidad INT,
    @direccion_atencion VARCHAR(255),
    @id_estudio INT,
    @id_tipo_turno INT
)
AS
BEGIN
    INSERT INTO Clinica.Relacion_Turno_Medico (
        id_turno, fecha, id_medico, id_especialidad, direccion_atencion, id_estudio, id_tipo_turno
    )
    VALUES (
        @id_turno, @fecha, @id_medico, @id_especialidad, @direccion_atencion, @id_estudio, @id_tipo_turno
    );
END;
go
-- UPDATE RELACION TURNO MEDICO
CREATE PROCEDURE Clinica.UpdateRelacionTurnoMedico (
    @id_turno INT,
    @fecha DATETIME,
    @id_medico INT,
    @id_especialidad INT,
    @direccion_atencion VARCHAR(255),
    @id_estudio INT,
    @id_tipo_turno INT
)
AS
BEGIN
    UPDATE Clinica.Relacion_Turno_Medico
    SET fecha = @fecha, id_medico = @id_medico, id_especialidad = @id_especialidad, 
        direccion_atencion = @direccion_atencion, id_estudio = @id_estudio, id_tipo_turno = @id_tipo_turno
    WHERE id_turno = @id_turno;
END;
go
-- ELIMINAR RELACION TURNO MEDICO FISICO
CREATE PROCEDURE Clinica.DeleteRelacionTurnoMedico (
    @id_turno INT
)
AS
BEGIN
    DELETE FROM Clinica.Relacion_Turno_Medico
    WHERE id_turno = @id_turno;
END;
go
-- INSERTAR TURNO
CREATE PROCEDURE Clinica.InsertTurno (
    @id_estado INT,
    @nombre_estado VARCHAR(50)
)
AS
BEGIN
    INSERT INTO Clinica.Turno (
   id_estado, nombre_estado
    )
    VALUES (
       @id_estado, @nombre_estado
    );
END;
go
-- UPDATE TURNO
CREATE PROCEDURE Clinica.UpdateTurno (
    @id_turno INT,
    @id_estado INT,
    @nombre_estado VARCHAR(50)
)
AS
BEGIN
    UPDATE Clinica.Turno
    SET id_estado = @id_estado, nombre_estado = @nombre_estado
    WHERE id_turno = @id_turno;
END;
go
-- ELIMINAR TURNO FISICO
CREATE PROCEDURE Clinica.DeleteTurno (
    @id_turno INT
)
AS
BEGIN
    DELETE FROM Clinica.Turno
    WHERE id_turno = @id_turno;
END;
go
-- INSERTAR LISTA SDE
CREATE PROCEDURE Clinica.InsertListaSede (
    @id_sede INT,
    @id_medico INT,
    @hora_inicio TIME
)
AS
BEGIN
    INSERT INTO Clinica.Lista_Sede (
        id_sede, id_medico, hora_inicio
    )
    VALUES (
        @id_sede, @id_medico, @hora_inicio
    );
END;
go
-- UPDATE LISTA SEDE
CREATE PROCEDURE Clinica.UpdateListaSede (
    @id_sede INT,
    @id_medico INT,
    @hora_inicio TIME
)
AS
BEGIN
    UPDATE Clinica.Lista_Sede
    SET hora_inicio = @hora_inicio
    WHERE id_sede = @id_sede AND id_medico = @id_medico;
END;
go
-- ELIMINAR LISTA SEDE FISICO
CREATE PROCEDURE Clinica.DeleteListaSede (
    @id_sede INT,
    @id_medico INT
)
AS
BEGIN
    DELETE FROM Clinica.Lista_Sede
    WHERE id_sede = @id_sede AND id_medico = @id_medico;
END;
go


-- SP medicos.csv
CREATE PROCEDURE [Clinica].[ImportarMedicosDesdeCSV]
AS
BEGIN
    CREATE TABLE #temp_medicos (
	    apellido VARCHAR(255),
        nombre VARCHAR(255),
		nombre_especialidad varchar(255),
        nro_matricula VARCHAR(50)
    );

    -- Importar datos CSV a la tabla temporal
    BULK INSERT #temp_medicos
    FROM 'C:\Ruta\medicos.csv' -- Ruta del archivo hardcodeada
    WITH (
        FIELDTERMINATOR = ';',  
        ROWTERMINATOR = '\n',  
		DATAFILETYPE = 'char',
		CODEPAGE = '65001',
        FIRSTROW = 2           
    );
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
    BULK INSERT #temp_pacientes
    FROM 'C:\Ruta\Pacientes.csv' -- Ruta del archivo hardcodeada
    WITH (
        FIELDTERMINATOR = ';',  
        ROWTERMINATOR = '\n',  
		DATAFILETYPE = 'char',
		CODEPAGE = '65001',
        FIRSTROW = 2            
    );

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
AS
BEGIN
    CREATE TABLE #temp_prestadores (
        nombre_prestador VARCHAR(255),
        plan_prestador VARCHAR(255)
    );

    -- Importar datos CSV a la tabla temporal
    BULK INSERT #temp_prestadores
    FROM 'C:\Ruta\prestador.csv' -- Ruta del archivo hardcodeada
    WITH (
        FIELDTERMINATOR = ';',  
        ROWTERMINATOR = '\n',  
		DATAFILETYPE = 'char',
		CODEPAGE = '65001',
        FIRSTROW = 2             
    );

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
AS
BEGIN
    CREATE TABLE #temp_sedes (
        nombre_sede VARCHAR(255),
		direccion_sede VARCHAR(255),
		localidad_sede VARCHAR(255),
        provincia_sede VARCHAR(255),
    );

    -- Importar datos CSV a la tabla temporal
    BULK INSERT #temp_sedes
    FROM 'C:\Ruta\sedes.csv' -- Ruta del archivo hardcodeada
    WITH (
        FIELDTERMINATOR = ';',  
        ROWTERMINATOR = '\n',  
		DATAFILETYPE = 'char',
		CODEPAGE = '65001',
        FIRSTROW = 2              
    );

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
create PROCEDURE GenerarXMLTurnosAtendidos
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
            Clinica.Relacion_Turno_Medico RTM
            INNER JOIN Clinica.Paciente P ON RTM.id_historia_clinica = P.id_historia_clinica
            INNER JOIN Clinica.Medico M ON RTM.id_medico = M.id_medico
            INNER JOIN Clinica.Especialidad E ON RTM.id_especialidad = E.id_especialidad
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
go
CREATE PROCEDURE [Clinica].[ImportarAutorizacionesDesdeJSON]
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

	-- Cargar el contenido del archivo JSON en la variable @json
	SELECT @json = convert(varchar(max), coalesce(BulkColumn,'' collate Latin1_General_100_CI_AS_SC_UTF8 )) collate SQL_Latin1_General_CP1_CI_AS
	FROM OPENROWSET (BULK 'C:\Ruta\Centro_Autorizaciones.Estudios Clinicos.json', SINGLE_BLOB) AS j;

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
-- FIN
