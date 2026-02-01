-- 03_seed_data.sql

-- Clinics (3)
INSERT INTO Clinics (Name, Address, City) VALUES
('City Health Clinic', 'Main Street 1', 'Stockholm'),
('North Care Center', 'Oak Road 12', 'Göteborg'),
('Wellness Point', 'Sunset Blvd 5', 'Malmö');


-- Patients (10)
INSERT INTO Patients (FirstName, LastName, Email, Phone) VALUES
('Anna', 'Svensson', 'anna.svensson@mail.com', '0701111111'),
('Erik', 'Johansson', 'erik.j@mail.com', '0702222222'),
('Maria', 'Lindberg', 'maria.l@mail.com', '0703333333'),
('Oskar', 'Nilsson', 'oskar.n@mail.com', '0704444444'),
('Sara', 'Karlsson', 'sara.k@mail.com', '0705555555'),
('Jonas', 'Pettersson', 'jonas.p@mail.com', '0706666666'),
('Elin', 'Andersson', 'elin.a@mail.com', '0707777777'),
('David', 'Berg', 'david.b@mail.com', '0708888888'),
('Emma', 'Holm', 'emma.h@mail.com', '0709999999'),
('Lucas', 'Fransson', 'lucas.f@mail.com', '0701234567');


-- Doctors (6)
INSERT INTO Doctors (FirstName, LastName, Specialization, ClinicID) VALUES
('Karin', 'Olsson', 'General Medicine', 1),
('Lars', 'Ekström', 'Dermatology', 1),
('Sofia', 'Nordin', 'Physiotherapy', 2),
('Andreas', 'Blom', 'Orthopedics', 2),
('Helena', 'Sjöberg', 'Dentistry', 3),
('Magnus', 'Wallin', 'Cardiology', 3);


-- Treatments (6)  ✅ secondary entity
INSERT INTO Treatments (Name, Price, DurationMinutes) VALUES
('General Checkup', 500, 30),
('Skin Consultation', 750, 45),
('Physiotherapy Session', 650, 50),
('Dental Cleaning', 900, 40),
('Heart Examination', 1200, 60),
('Orthopedic Assessment', 850, 45);


-- Appointments (10+) ✅ main entity
INSERT INTO Appointments (PatientID, DoctorID, ClinicID, AppointmentDate, Status) VALUES
(1, 1, 1, '2025-02-01 09:00', 'Completed'),
(2, 2, 1, '2025-02-01 10:00', 'Completed'),
(3, 3, 2, '2025-02-02 11:00', 'Booked'),
(4, 4, 2, '2025-02-02 13:00', 'Cancelled'),
(5, 5, 3, '2025-02-03 09:30', 'Completed'),
(6, 6, 3, '2025-02-03 11:30', 'Booked'),
(7, 1, 1, '2025-02-04 10:00', 'Completed'),
(8, 2, 1, '2025-02-04 14:00', 'Booked'),
(9, 3, 2, '2025-02-05 09:00', 'Completed'),
(10, 4, 2, '2025-02-05 15:00', 'Booked');


-- AppointmentTreatments (25) ✅ many-to-many
INSERT INTO AppointmentTreatments (AppointmentID, TreatmentID) VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 1),
(3, 3),
(3, 1),
(4, 6),
(5, 4),
(5, 1),
(6, 5),
(6, 1),
(7, 1),
(7, 3),
(8, 2),
(8, 1),
(9, 3),
(9, 6),
(9, 1),
(10, 6),
(10, 1),
(2, 3),
(3, 2),
(4, 1),
(5, 3),
(6, 2);