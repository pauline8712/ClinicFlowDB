-- 06_views.sql
-- Skapa minst 2 views:
-- 1?? Public View (döljer känsliga kolumner)
-- 2?? Report View som Console App kan använda

-- ---------------------
-- 1?? Public View
-- Vi visar patienters namn men inte e-post eller telefon
CREATE VIEW PublicPatients AS
SELECT PatientID, FirstName + ' ' + LastName AS PatientName
FROM Patients;

-- ---------------------
-- 2?? Report ;View
-- Patienter med flest besök (Top 10)
CREATE VIEW TopPatientsByVisits AS
SELECT TOP 10
    p.PatientID,
    p.FirstName + ' ' + p.LastName AS PatientName,
    COUNT(a.AppointmentID) AS VisitCount
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID
GROUP BY p.PatientID, p.FirstName, p.LastName
ORDER BY VisitCount DESC;

