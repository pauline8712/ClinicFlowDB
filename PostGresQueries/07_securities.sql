-- 07_security.sql

-- 1️⃣ Skapa användare med lösenord
CREATE ROLE readonly_user WITH LOGIN PASSWORD 'ReadonlyPass123';

-- 2️⃣ Ge CONNECT på databasen
GRANT CONNECT ON DATABASE "ClinicFlowDB" TO readonly_user;

-- 3️⃣ Ge USAGE på schemat (vanligtvis "public")
GRANT USAGE ON SCHEMA public TO readonly_user;

-- 4️⃣ Ge SELECT på vyn/vyerna
GRANT SELECT ON vw_public_patients TO readonly_user;
GRANT SELECT ON vw_patient_appointment_report TO readonly_user;
