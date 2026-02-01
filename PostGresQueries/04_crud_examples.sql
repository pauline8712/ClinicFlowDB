-- 04_crud_examples.sql
-- ---------------------
-- Patients (huvudentitet)
-- ---------------------
-- INSERT
INSERT INTO Patients (FirstName, LastName, Email, Phone)
VALUES 
    ('Emma', 'Karlsson', 'emma@gmail.com', '0754003452');

-- SELECT
SELECT FirstName, LastName, Email, Phone
FROM Patients;

-- UPDATE
UPDATE Patients
SET Phone = '0701234567'
WHERE PatientID = 1;

-- DELETE (FK-säker: ta bort kopplingar först)
DELETE FROM AppointmentTreatments
WHERE AppointmentID IN (
    SELECT AppointmentID FROM Appointments WHERE PatientID = 1
);

DELETE FROM Appointments
WHERE PatientID = 1;

DELETE FROM Patients
WHERE PatientID = 1;


-- ---------------------
-- Doctors
-- ---------------------
-- SELECT
SELECT FirstName, LastName, Specialization, ClinicID
FROM Doctors
WHERE Specialization = 'General Medicine';

-- ---------------------
-- Clinics
-- ---------------------
-- SELECT
SELECT Name, Address, City
FROM Clinics
WHERE City = 'Stockholm';

-- ---------------------
-- Treatments
-- ---------------------
-- UPDATE
UPDATE Treatments
SET DurationMinutes = 45
WHERE TreatmentID = 1;

-- ---------------------
-- Appointments & Kopplingstabell
-- ---------------------
-- DELETE från kopplingstabellen först
DELETE FROM AppointmentTreatments
WHERE AppointmentTreatmentID = 2;

-- Sedan kan vi ta bort appointment
DELETE FROM Appointments
WHERE AppointmentID = 1;