-- SCRIPT PARA LA CREACION DE QUERYS CLINICA S.A
-- FECHA: 2024-06-11
-- GRUPO: 21
-- INTEGRANTES: FRAGASSI DONATELLA, MIRO AGUSTIN, ROJAS RODRIGUEZ CHRISTIAN RODRIGO, GARIN MATIAS

-- IMPORTACION DE DATOS A CLINICA S.A

-- 1. IMPORTAR MEDICOS DESDE CSV
-- Este procedimiento importa datos de médicos desde un archivo CSV y los inserta en las tablas correspondientes.
EXEC Clinica.ImportarMedicosDesdeCSV;

-- 2. INSERTAR PACIENTES
-- Insertar registros en la tabla de Pacientes.
EXEC Clinica.InsertPaciente 
    @nombre = 'Juan',
    @apellido = 'Perez',
    @apellido_materno = 'Gomez',
    @fecha_nacimiento = '1980-01-01',
    @tipo_documento = 'DNI',
    @nro_documento = '12345678',
    @sexo_biologico = 'Masculino',
    @genero = 'Masculino',
    @nacionalidad = 'Argentina',
    @foto_perfil = NULL,
    @mail = 'juan.perez@example.com',
    @telefono = '123456789',
    @telefono_contacto_alternativo = '987654321',
    @telefono_laboral = '1122334455',
    @fecha_registro = GETDATE(),
    @fecha_actualizacion = NULL,
    @usuario_actualizacion = NULL;

-- 3. ACTUALIZAR PACIENTES
-- Actualizar registros en la tabla de Pacientes.
EXEC Clinica.UpdatePaciente 
    @id_historia_clinica = 1,
    @nombre = 'Juan',
    @apellido = 'Perez',
    @apellido_materno = 'Gomez',
    @fecha_nacimiento = '1980-01-01',
    @tipo_documento = 'DNI',
    @nro_documento = '12345678',
    @sexo_biologico = 'Masculino',
    @genero = 'Masculino',
    @nacionalidad = 'Argentina',
    @foto_perfil = NULL,
    @mail = 'juan.perez@example.com',
    @telefono = '123456789',
    @telefono_contacto_alternativo = '987654321',
    @telefono_laboral = '1122334455',
    @fecha_registro = GETDATE(),
    @fecha_actualizacion = GETDATE(),
    @usuario_actualizacion = 1;

-- 4. ELIMINAR PACIENTE LOGICAMENTE
-- Eliminar un paciente de manera lógica.
EXEC Clinica.DeletePaciente 
    @id_historia_clinica = 1;

-- 5. INSERTAR ESTUDIOS
-- Insertar registros en la tabla de Estudios.
EXEC Clinica.InsertEstudio 
    @fecha = '2024-06-01',
    @nombre_estudio = 'Radiografía',
    @autorizado = 1,
    @documento_resultado = NULL,
    @imagen_resultado = NULL;

-- 6. ACTUALIZAR ESTUDIOS
-- Actualizar registros en la tabla de Estudios.
EXEC Clinica.UpdateEstudio 
    @id_estudio = 1,
    @fecha = '2024-06-01',
    @nombre_estudio = 'Radiografía',
    @autorizado = 1,
    @documento_resultado = NULL,
    @imagen_resultado = NULL;

-- 7. ELIMINAR ESTUDIOS LOGICAMENTE
-- Eliminar un estudio de manera lógica.
EXEC Clinica.DeleteEstudio 
    @id_estudio = 1;

-- 8. INSERTAR COBERTURAS
-- Insertar registros en la tabla de Coberturas.
EXEC Clinica.InsertCobertura 
    @imagen_credencial = NULL,
    @nro_socio = '789123',
    @fecha_registro = GETDATE();

-- 9. ACTUALIZAR COBERTURAS
-- Actualizar registros en la tabla de Coberturas.
EXEC Clinica.UpdateCobertura 
    @id_cobertura = 1,
    @imagen_credencial = NULL,
    @nro_socio = '789123',
    @fecha_registro = GETDATE();

-- 10. ELIMINAR COBERTURA FISICAMENTE
-- Eliminar una cobertura de manera física.
EXEC Clinica.DeleteCobertura 
    @id_cobertura = 1;

-- 11. INSERTAR PRESTADORES
-- Insertar registros en la tabla de Prestadores.
EXEC Clinica.InsertPrestador 
    @nombre_prestador = 'OSDE',
    @plan_prestador = '210';

-- 12. ACTUALIZAR PRESTADORES
-- Actualizar registros en la tabla de Prestadores.
EXEC Clinica.UpdatePrestador 
    @id_prestador = 1,
    @nombre_prestador = 'OSDE',
    @plan_prestador = '310';

-- 13. ELIMINAR PRESTADOR FISICAMENTE
-- Eliminar un prestador de manera física.
EXEC Clinica.DeletePrestador 
    @id_prestador = 1;

-- 14. INSERTAR DOMICILIOS
-- Insertar registros en la tabla de Domicilios.
EXEC Clinica.InsertDomicilio 
    @calle = 'San Martin',
    @numero = '1234',
    @piso = '2',
    @departamento = 'B',
    @codigo_postal = '1000',
    @provincia = 'Buenos Aires',
    @localidad = 'CABA';

-- 15. ACTUALIZAR DOMICILIOS
-- Actualizar registros en la tabla de Domicilios.
EXEC Clinica.UpdateDomicilio 
    @id_domicilio = 1,
    @calle = 'San Martin',
    @numero = '1234',
    @piso = '2',
    @departamento = 'B',
    @codigo_postal = '1000',
    @provincia = 'Buenos Aires',
    @localidad = 'CABA';

-- 16. ELIMINAR DOMICILIO FISICAMENTE
-- Eliminar un domicilio de manera física.
EXEC Clinica.DeleteDomicilio 
    @id_domicilio = 1;

-- 17. INSERTAR TIPOS DE TURNO
-- Insertar registros en la tabla de Tipos de Turno.
EXEC Clinica.InsertTipoTurno 
    @nombre_tipo_turno = 'Consulta General';

-- 18. ACTUALIZAR TIPOS DE TURNO
-- Actualizar registros en la tabla de Tipos de Turno.
EXEC Clinica.UpdateTipoTurno 
    @id_tipo_turno = 1,
    @nombre_tipo_turno = 'Consulta Especializada';

-- 19. ELIMINAR TIPO DE TURNO FISICAMENTE
-- Eliminar un tipo de turno de manera física.
EXEC Clinica.DeleteTipoTurno 
    @id_tipo_turno = 1;

-- 20. INSERTAR MEDICOS
-- Insertar registros en la tabla de Médicos.
EXEC Clinica.InsertMedico 
    @nombre = 'Carlos',
    @apellido = 'Gomez',
    @nro_matricula = '123456';

-- 21. ACTUALIZAR MEDICOS
-- Actualizar registros en la tabla de Médicos.
EXEC Clinica.UpdateMedico 
    @id_medico = 1,
    @nombre = 'Carlos',
    @apellido = 'Gomez',
    @nro_matricula = '654321';

-- 22. ELIMINAR MEDICO FISICAMENTE
-- Eliminar un médico de manera física.
EXEC Clinica.DeleteMedico 
    @id_medico = 1;

-- 23. INSERTAR ESPECIALIDADES
-- Insertar registros en la tabla de Especialidades.
EXEC Clinica.InsertEspecialidad 
    @nombre_especialidad = 'Cardiología';

-- 24. ACTUALIZAR ESPECIALIDADES
-- Actualizar registros en la tabla de Especialidades.
EXEC Clinica.UpdateEspecialidad 
    @id_especialidad = 1,
    @nombre_especialidad = 'Neurología';

-- 25. ELIMINAR ESPECIALIDAD FISICAMENTE
-- Eliminar una especialidad de manera física.
EXEC Clinica.DeleteEspecialidad 
    @id_especialidad = 1;

-- 26. INSERTAR SEDES
-- Insertar registros en la tabla de Sedes.
EXEC Clinica.InsertSede 
    @nombre_sede = 'Central',
    @direccion_sede = 'Av. Siempreviva 123';

-- 27. ACTUALIZAR SEDES
-- Actualizar registros en la tabla de Sedes.
EXEC Clinica.UpdateSede 
    @id_sede = 1,
    @nombre_sede = 'Central',
    @direccion_sede = 'Av. Siempreviva 456';

-- 28. ELIMINAR SEDE FISICAMENTE
-- Eliminar una sede de manera física.
EXEC Clinica.DeleteSede 
    @id_sede = 1;

-- 29. INSERTAR RELACIONES TURNO MEDICO
-- Insertar registros en la tabla de Relaciones Turno-Médico.
EXEC Clinica.InsertRelacionTurno
