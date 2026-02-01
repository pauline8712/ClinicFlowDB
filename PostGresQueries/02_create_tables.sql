-- 02_create_tables.sql
-- Clinics
CREATE TABLE Clinics (
    ClinicID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(200),
    City VARCHAR(100)
);

-- Doctors
CREATE TABLE Doctors (
    DoctorID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialization VARCHAR(100),
    ClinicID INT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (ClinicID) REFERENCES Clinics(ClinicID)
);

-- Patients
CREATE TABLE Patients (
    PatientID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    CreatedAt TIMESTAMP DEFAULT NOW()
);

-- Appointments
CREATE TABLE Appointments (
    AppointmentID SERIAL PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    ClinicID INT NOT NULL,
    AppointmentDate TIMESTAMP NOT NULL,
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('Booked','Completed','Cancelled')),
    CreatedAt TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (ClinicID) REFERENCES Clinics(ClinicID)
);

-- Treatments
CREATE TABLE Treatments (
    TreatmentID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2),
    DurationMinutes INT
);

-- Kopplingstabell AppointmentTreatments
CREATE TABLE AppointmentTreatments (
    AppointmentTreatmentID SERIAL PRIMARY KEY,
    AppointmentID INT NOT NULL,
    TreatmentID INT NOT NULL,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (TreatmentID) REFERENCES Treatments(TreatmentID)
);