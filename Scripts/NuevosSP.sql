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
    @direccion_atencion VARCHAR(255),
    @id_estudio INT,
    @id_tipo_turno INT,
    @id_historia_clinica INT,
    @id_estado INT
AS
BEGIN
    INSERT INTO Clinica.Turno (
        fecha, id_medico, direccion_atencion,
        id_estudio, id_tipo_turno,
        id_historia_clinica, id_estado
    )
    VALUES (
        @fecha, @id_medico, @direccion_atencion,
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
    @direccion_atencion VARCHAR(255),
    @id_estudio INT,
    @id_tipo_turno INT,
    @id_historia_clinica INT,
    @id_estado INT
AS
BEGIN
    UPDATE Clinica.Turno
    SET
        fecha = @fecha,
        id_medico = @id_medico,
        direccion_atencion = @direccion_atencion,
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
