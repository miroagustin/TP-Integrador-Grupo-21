-- SCRIPT PARA LA CREACION DE QUERYS CLINICA S.A
-- FECHA: 2024-06-11
-- GRUPO: 21
-- INTEGRANTES: FRAGASSI DONATELLA, MIRO AGUSTIN, ROJAS RODRIGUEZ CHRISTIAN RODRIGO, GARIN MATIAS

-- Test importacion
exec [Clinica].[ImportarAutorizacionesDesdeJSON] 'C:/Ruta/Centro_Autorizaciones.Estudios clinicos.json'
exec [Clinica].[ImportarSedesDesdeCSV] 'C:/Ruta/Sedes.csv'
exec [Clinica].[ImportarPacientesDesdeCSV] 'C:/Ruta/Pacientes.csv'
exec [Clinica].[ImportarMedicosDesdeCSV] 'C:/Ruta/medicos.csv'

--Test generar en base a los datos de prueba ingresados
Exec GenerarXMLTurnosAtendidos 'ObraSocial1','2024-06-10 10:00:00.000','2024-06-11 10:00:00.000'

EXEC Clinica.InsertarTurno
    @fecha = '2024-06-14 12:23:00', -- No en un intervalo de 15 minutos
    @id_medico = 1,
    @id_sede = 1,
    @id_estudio = 1,
    @id_tipo_turno = 1,
    @id_historia_clinica = 1,
    @id_estado = 1;
-- Esperado: Error 'La hora del turno debe ser en intervalos de 15 minutos: 00, 15, 30, 45.'

EXEC Clinica.InsertarTurno
    @fecha = '2024-06-14 12:00:00', -- Viernes
    @id_medico = 2, -- Suponiendo que este médico no atiende los viernes en esta sede
    @id_sede = 1,
    @id_estudio = 1,
    @id_tipo_turno = 1,
    @id_historia_clinica = 1,
    @id_estado = 1;
-- Esperado: Error 'El día de la semana para la fecha proporcionada no es válido para el médico y la sede especificados.'

EXEC Clinica.InsertarTurno
    @fecha = '2024-06-17 09:00:00', -- Lunes
    @id_medico = 3, -- Suponiendo que este médico atiende los lunes en esta sede
    @id_sede = 2,
    @id_estudio = 2,
    @id_tipo_turno = 2,
    @id_historia_clinica = 2,
    @id_estado = 2;
-- Esperado: Inserción exitosa sin errores.

EXEC Clinica.InsertarTurno
    @fecha = '2024-06-15 15:30:00', -- Sábado
    @id_medico = 1, -- Suponiendo que este médico no atiende los sábados en esta sede
    @id_sede = 3,
    @id_estudio = 3,
    @id_tipo_turno = 3,
    @id_historia_clinica = 3,
    @id_estado = 3;
-- Esperado: Error 'El día de la semana para la fecha proporcionada no es válido para el médico y la sede especificados.'

EXEC Clinica.InsertarTurno
    @fecha = '2024-06-19 11:15:00', -- Miércoles
    @id_medico = 4, -- Suponiendo que este médico atiende los miércoles en esta sede
    @id_sede = 4,
    @id_estudio = 4,
    @id_tipo_turno = 4,
    @id_historia_clinica = 4,
    @id_estado = 4;
-- Esperado: Inserción exitosa sin errores.
