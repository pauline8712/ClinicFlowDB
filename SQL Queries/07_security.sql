--Security
-- Skapar login på server-nivå
CREATE LOGIN ClinicFlowReadUser 
WITH PASSWORD = 'ReadOnlyPass123';

-- Byter till rätt databas
USE Flow;

-- Skapar user i databasen kopplad till login
CREATE USER ClinicFlowReadUser 
FOR LOGIN ClinicFlowReadUser;

-- 4? Skapa en egen roll 
CREATE ROLE ClinicFlowReadRole;

-- Lägger användaren i rollen
ALTER ROLE ClinicFlowReadRole 
ADD MEMBER ClinicFlowReadUser;

-- Ger SELECT-rättigheter ENDAST på views
GRANT SELECT ON PublicPatients TO ClinicFlowReadRole;
GRANT SELECT ON TopPatientsByVisits TO ClinicFlowReadRole;
