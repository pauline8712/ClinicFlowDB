# ClinicFlow App
Scenario
-----

ClinicFlow is a console application simulating a clinic management system. The app allows users to manage patients, doctors, clinics, appointments, and treatments.

The project aims to demonstrate:

Relational databases with SQL Server

CRUD operations (Create, Read, Update, Delete)

Using Entity Framework Core with Database First

Console-based applications in C#

The application simplifies management of patient appointments and provides reports, showing the relationships between patients, doctors, clinics, and treatments.

Installation and Setup
-----
1. SQL Files and Database

To create the database and populate it with sample data, run the SQL files in the following order in SQL Server Management Studio (SSMS):

1_create_database.sql
Creates the database ClinicFlowDB.

2_create_tables.sql
Creates tables: Clinics, Doctors, Patients, Appointments, Treatments, AppointmentTreatments.

3_insert_testdata.sql
Inserts sample data for clinics, doctors, patients, appointments, and treatments.

4_crud_examples.sql
Examples of CRUD operations (INSERT, SELECT, UPDATE, DELETE).

5_queries_joins.sql
Advanced queries with JOIN, GROUP BY, and reports.

6_views.sql
Creates two views:

PublicPatients (hides sensitive columns)

TopPatientsByVisits (patients with the most visits)

7_security.sql
Creates a read-only user and role for the views.

Tip: Run each file separately and in order. In SSMS, right-click the database → New Query → run the scripts.

Scaffold Database First with Entity Framework
-----

To connect your C# application to the database:

Open Visual Studio 2022.

Open Package Manager Console (Tools > NuGet Package Manager > Package Manager Console).

Run the following command (replace server and database if needed):

Scaffold-DbContext "Server=.\SQLEXPRESS;Database=ClinicFlowDB;Trusted_Connection=True;TrustServerCertificate=True;" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models -Context ClinicFlowContext


-OutputDir Models specifies where the model classes are generated.

-Context ClinicFlowContext specifies the name of the DbContext class.

This generates all models and relationships from the database (Database First).

Running the Application
-----

Open Program.cs in the ClinicFlowApp project.

Ensure the connection string in ClinicFlowContext matches your server and database:

options.UseSqlServer(@"Server=.\SQLEXPRESS;Database=ClinicFlowDB;Trusted_Connection=True;TrustServerCertificate=True;");


Run the program (Ctrl + F5).

The main menu should appear:

===== ClinicFlow Menu =====
1. List Patients
2. List Doctors
3. Create Appointment
4. Update Appointment Status
5. Delete Appointment
6. Reports
0. Exit

Example Menu Flow
List Patients
-----

Choose 1. List Patients

The program displays all patients with name, email, and phone.

Create Appointment
-----

Choose 3. Create Appointment

Enter PatientID, DoctorID, and date (yyyy-MM-dd HH:mm)

The appointment is saved with status Booked.

Update Appointment Status
-----

Choose 4. Update Appointment Status

Enter AppointmentID

Update the status to Scheduled, Completed, or Cancelled.

Delete Appointment
-----

Choose 5. Delete Appointment

Enter AppointmentID

The appointment is removed from the database.

Reports: Top Patients
-----

Choose 6. Reports → 1. Top Patients by Appointments

Displays the 5 patients with the most appointments.
