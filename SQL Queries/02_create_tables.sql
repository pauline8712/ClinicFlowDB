--2. Skapar tabeller

-- Clinics
CREATE TABLE Clinics (
    ClinicID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Address NVARCHAR(200),
    City NVARCHAR(100)
);

-- Doctors
CREATE TABLE Doctors (
    DoctorID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Specialization NVARCHAR(100),
    ClinicID INT NOT NULL,
    CreatedAt DATETIME2 DEFAULT SYSDATETIME(),
    FOREIGN KEY (ClinicID) REFERENCES Clinics(ClinicID)
);

-- Patients
CREATE TABLE Patients (
    PatientID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    CreatedAt DATETIME2 DEFAULT SYSDATETIME()
);

-- Appointments
CREATE TABLE Appointments (
    AppointmentID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    ClinicID INT NOT NULL,
    AppointmentDate DATETIME2 NOT NULL,  
    Status NVARCHAR(20) NOT NULL
        CHECK (Status IN ('Booked','Completed','Cancelled')),
    CreatedAt DATETIME2 DEFAULT SYSDATETIME(),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (ClinicID) REFERENCES Clinics(ClinicID)
);

-- Treatments
CREATE TABLE Treatments (
    TreatmentID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(10,2),
    DurationMinutes INT
);

-- AppointmentTreatments
CREATE TABLE AppointmentTreatments (
    AppointmentTreatmentID INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentID INT NOT NULL,
    TreatmentID INT NOT NULL,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (TreatmentID) REFERENCES Treatments(TreatmentID)
);
