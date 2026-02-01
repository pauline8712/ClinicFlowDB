-- 06_views.sql

-- Public view: visar patienter utan känslig information
CREATE OR REPLACE VIEW vw_public_patients AS
SELECT
    PatientID,
    FirstName,
    LastName,
    CreatedAt
FROM Patients; 

-- Report view: antal bokningar per patient
CREATE OR REPLACE VIEW vw_patient_appointment_report AS
SELECT
    p.PatientID,
    p.FirstName || ' ' || p.LastName AS PatientName,
    COUNT(a.AppointmentID) AS TotalAppointments
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID
GROUP BY p.PatientID, p.FirstName, p.LastName;