-- 05_queries_joins.sql
-- Avancerade SELECT-queries med JOIN, GROUP BY, rapporter
-- Anpassad för SQL Server

-- 1?? LISTA ALLA BOKNINGAR MED PATIENT + LÄKARE + KLINIK
-- (JOIN query #1)
SELECT
    a.AppointmentID,
    a.AppointmentDate,
    a.Status,
    p.FirstName + ' ' + p.LastName AS PatientName,
    d.FirstName + ' ' + d.LastName AS DoctorName,
    c.Name AS ClinicName
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID
JOIN Clinics c ON a.ClinicID = c.ClinicID;


-- 2?? BOKNINGAR MED TILLHÖRANDE BEHANDLINGAR
-- (JOIN query #2, många-till-många)
SELECT
    a.AppointmentID,
    a.AppointmentDate,
    t.Name AS TreatmentName,
    t.Price
FROM Appointments a
JOIN AppointmentTreatments at ON a.AppointmentID = at.AppointmentID
JOIN Treatments t ON at.TreatmentID = t.TreatmentID;


-- 3?? LÄKARE OCH DERAS KLINIKER
-- (JOIN query #3)
SELECT
    d.DoctorID,
    d.FirstName + ' ' + d.LastName AS DoctorName,
    d.Specialization,
    c.Name AS ClinicName,
    c.City
FROM Doctors d
JOIN Clinics c ON d.ClinicID = c.ClinicID;


-- 4?? PATIENTER OCH ANTALET BOKNINGAR DE HAR
-- (JOIN query #4 + GROUP BY + aggregat)
SELECT
    p.PatientID,
    p.FirstName + ' ' + p.LastName AS PatientName,
    COUNT(a.AppointmentID) AS TotalAppointments
FROM Patients p
LEFT JOIN Appointments a ON p.PatientID = a.PatientID
GROUP BY p.PatientID, p.FirstName, p.LastName;


-- 5?? ANTAL BOKNINGAR PER KLINIK
-- (GROUP BY + aggregat #2)
SELECT
    c.Name AS ClinicName,
    COUNT(a.AppointmentID) AS TotalAppointments
FROM Clinics c
LEFT JOIN Appointments a ON c.ClinicID = a.ClinicID
GROUP BY c.Name
ORDER BY TotalAppointments DESC;


-- 6?? ALLA KOMPLETTERADE BOKNINGAR SORTERADE PÅ DATUM
-- (WHERE + ORDER BY)
SELECT
    AppointmentID,
    AppointmentDate,
    Status
FROM Appointments
WHERE Status = 'Completed'
ORDER BY AppointmentDate DESC;


-- 7?? RAPPORT: LÄKARE OCH TOTAL INTÄKT FRÅN BEHANDLINGAR
-- (Exempel på rapportfråga)
SELECT
    d.DoctorID,
    d.FirstName + ' ' + d.LastName AS DoctorName,
    SUM(t.Price) AS TotalRevenue
FROM Doctors d
JOIN Appointments a ON d.DoctorID = a.DoctorID
JOIN AppointmentTreatments at ON a.AppointmentID = at.AppointmentID
JOIN Treatments t ON at.TreatmentID = t.TreatmentID
GROUP BY d.DoctorID, d.FirstName, d.LastName
ORDER BY TotalRevenue DESC;


-- 8?? RAPPORT: KLINIKER OCH ANTAL BEHANDLINGAR
SELECT
    c.Name AS ClinicName,
    COUNT(at.AppointmentTreatmentID) AS TotalTreatments
FROM Clinics c
JOIN Appointments a ON c.ClinicID = a.ClinicID
JOIN AppointmentTreatments at ON a.AppointmentID = at.AppointmentID
GROUP BY c.Name
ORDER BY TotalTreatments DESC;
