-- ##################################################
-- Transact-SQL de copia de seguridad diferencial de la base de datos TMS en disco
-- Autor: Ernesto Sequeira.
-- fecha: 06-2017
-- ##################################################

USE TMS;
GO

-- Nombre de la base de datos que se resguardará
DECLARE @db VARCHAR(MAX)
SET @db = 'TMS'

-- Fecha para el formato del nombre del backup
DECLARE @date VARCHAR(MAX)
SET @date = CONVERT(VARCHAR(max), GETDATE(),102)

-- Ruta y nombre donde se copiará la base de datos
DECLARE @file VARCHAR(MAX)
SET @file ='Z:\BACKUP\TMSdb\'+@db+'-'+@date+'-diferencial.bak'

-- Proceso SQL Server de Differential Backup
BACKUP DATABASE @db
TO DISK = @file
   WITH DIFFERENTIAL
GO
