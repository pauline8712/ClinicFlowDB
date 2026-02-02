using ClinicFlowApp.Models;
using ClinicFlowDB2.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;

class Program
{
    static void Main()
    {
        using var context = new ClinicFlowContext();

        if (context.Database.CanConnect())
            Console.WriteLine("Connected to ClinicFlowDB");

        bool exit = false;

        while (true)
        {
            Console.Clear();
            Console.WriteLine("\n===== ClinicFlow Menu =====");
            Console.WriteLine("1. List Patients");
            Console.WriteLine("2. List Doctors");
            Console.WriteLine("3. Create Appointment");
            Console.WriteLine("4. Update Appointment Status");
            Console.WriteLine("5. Delete Appointment");
            Console.WriteLine("6. Reports");
            Console.WriteLine("7. View Appointments"); 
            Console.WriteLine("0. Exit");
            Console.Write("Choose an option: ");


            string input = Console.ReadLine();

            switch (input)
            {
                case "1":
                    Console.Clear();
                    ListPatients(context);
                    break;
                case "2":
                    Console.Clear();
                    ListDoctors(context);
                    break;
                case "3":
                    Console.Clear();
                    CreateAppointment(context);
                    break;
                case "4":
                    Console.Clear();
                    UpdateAppointmentStatus(context);
                    break;
                case "5":
                    Console.Clear();
                    DeleteAppointment(context);
                    break;
                case "6":
                    Console.Clear();
                    ReportsMenu(context);
                    break;
                case "7":
                    Console.Clear();
                    ViewAppointments(context); // Nytt val
                    break;
                case "0":
                    exit = true;
                    Console.WriteLine("Exiting program...");
                    return;
                default:
                    Console.WriteLine("Invalid option. Try again.");
                    break;
            }


            if (!exit)
            {
                Console.WriteLine("\nPress Enter to return to menu...");
                Console.ReadLine(); 
            }

            //Hämtar alla patienter från databasen och skriver ut dem i konsolen
            static void ListPatients(ClinicFlowContext context)
            {
                var patients = context.Patients.ToList();
                Console.WriteLine("\nPatients:");
                foreach (var p in patients)
                {
                    Console.WriteLine($"{p.PatientID}: {p.FirstName} {p.LastName} | {p.Email} | {p.Phone}");
                }
            }

            static void ListDoctors(ClinicFlowContext context)
            {
                var doctors = context.Doctors.Include(d => d.Clinic).ToList();
                Console.WriteLine("\nDoctors:");
                foreach (var d in doctors)
                {
                    Console.WriteLine($"{d.DoctorID}: {d.FirstName} {d.LastName} | {d.Specialization} | Clinic: {d.Clinic.Name}");
                }
            }

            //Skapar en ny appointment i databasen
            static void CreateAppointment(ClinicFlowContext context)
            {
                Console.Clear();
                // Visa patienter
                ListPatients(context);
                Console.WriteLine();

                // Visa läkare
                ListDoctors(context);
                Console.WriteLine();

                Console.Write("Enter Patient ID: ");
                if (!int.TryParse(Console.ReadLine(), out int patientId))
                {
                    Console.WriteLine("Invalid number!");
                    return;
                }

                Console.Write("Enter Doctor ID: ");
                if (!int.TryParse(Console.ReadLine(), out int doctorId))
                {
                    Console.WriteLine("Invalid number!");
                    return;
                }

                Console.Write("Enter Appointment Date (yyyy-MM-dd HH:mm): ");
                string inputDate = Console.ReadLine();

                if (!DateTime.TryParse(inputDate, out DateTime date))
                {
                    Console.WriteLine("Invalid date format! Please use yyyy-MM-dd HH:mm");
                    return;
                }

                var appointment = new Appointment
                {
                    PatientID = patientId,
                    DoctorID = doctorId,
                    ClinicID = context.Doctors.Find(doctorId).ClinicID,
                    AppointmentDate = date,
                    Status = "Booked",
                    CreatedAt = DateTime.Now
                };

                context.Appointments.Add(appointment);
                context.SaveChanges();
                Console.WriteLine("Appointment created successfully!");

               
            }


            // Ny metod för att visa alla appointments med patient, doctor och clinic
            static void ViewAppointments(ClinicFlowContext context)
            {
                var appointments = context.Appointments
                    .Include(a => a.Patient)
                    .Include(a => a.Doctor)
                    .Include(a => a.Clinic)
                    .ToList();

                Console.WriteLine("\n===== All Appointments =====");
                foreach (var a in appointments)
                {
                    Console.WriteLine($"{a.AppointmentID}: {a.AppointmentDate:yyyy-MM-dd HH:mm} | Status: {a.Status} | Patient: {a.Patient.FirstName} {a.Patient.LastName} | Doctor: {a.Doctor.FirstName} {a.Doctor.LastName} | Clinic: {a.Clinic.Name}");
                }
            }


            static void UpdateAppointmentStatus(ClinicFlowContext context)
            {
                Console.Clear();

                // Visa appointments först
                ViewAppointments(context);

                Console.Write("\nEnter Appointment ID to update: ");
                if (!int.TryParse(Console.ReadLine(), out int id))
                {
                    Console.WriteLine("Invalid number!");
                    return;
                }

                var appointment = context.Appointments.Find(id);
                if (appointment == null)
                {
                    Console.WriteLine("Appointment not found!");
                    return;
                }

                Console.Write("Enter new Status (Scheduled, Completed, Cancelled): ");
                string status = Console.ReadLine();
                if (string.IsNullOrWhiteSpace(status))
                {
                    Console.WriteLine("Status cannot be empty!");
                    return;
                }

                appointment.Status = status;
                context.SaveChanges();
                Console.WriteLine("Appointment status updated!");

            }



            //Metoden tar bort en existerande appointment från databasen
            static void DeleteAppointment(ClinicFlowContext context)
            {
                Console.Clear();

                // Visa appointments först
                ViewAppointments(context);

                 Console.Write("\nEnter Appointment ID to delete: ");
                if (!int.TryParse(Console.ReadLine(), out int id))
                {
                    Console.WriteLine("Invalid number!");
                    return;
                }

                var appointment = context.Appointments.Find(id);
                if (appointment == null)
                {
                    Console.WriteLine("Appointment not found!");
                    return;
                }

                context.Appointments.Remove(appointment);
                context.SaveChanges();
                Console.WriteLine("Appointment deleted!");
            }



            //
            static void ReportsMenu(ClinicFlowContext context)
            {
                bool back = false;
                while (!back)
                {
                    Console.Clear();
                    Console.WriteLine("\n===== Reports Menu =====");
                    Console.WriteLine("1. Top Patients by Appointments");
                    Console.WriteLine("2. Appointments per Doctor");
                    Console.WriteLine("0. Back to Main Menu");
                    Console.Write("Choose a report: ");

                    string input = Console.ReadLine();
                    switch (input)
                    {
                        case "1":
                            Console.Clear();
                            TopPatientsReport(context);
                            break;
                        case "2":
                            Console.Clear();
                            AppointmentsPerDoctorReport(context);
                            break;
                        case "0":
                            return;
                        default:
                            Console.WriteLine("Invalid option. Try again.");
                            break;

                    }

                    if (!back)
                    {
                        Console.WriteLine("\nPress Enter to return to Reports Menu...");
                        Console.ReadLine(); // ÄNDRING: vänta innan nästa meny visas
                    }
                }
            }

            //Visar topp 5 patienter med mest appointments
            static void TopPatientsReport(ClinicFlowContext context)
            {
                var query = context.Patients
                    .Select(p => new
                    {
                        p.FirstName,
                        p.LastName,
                        AppointmentsCount = p.Appointments.Count
                    })
                    .OrderByDescending(p => p.AppointmentsCount)
                    .Take(5)
                    .ToList();

                Console.WriteLine("\nTop 5 Patients by Appointments:");
                foreach (var p in query)
                {
                    Console.WriteLine($"{p.FirstName} {p.LastName} - {p.AppointmentsCount} appointments");
                }
            }

            static void AppointmentsPerDoctorReport(ClinicFlowContext context)
            {
                var query = context.Doctors
                    .Select(d => new
                    {
                        d.FirstName,
                        d.LastName,
                        AppointmentCount = d.Appointments.Count
                    })
                    .ToList();

                Console.WriteLine("\nAppointments per Doctor:");
                foreach (var d in query)
                {
                    Console.WriteLine($"{d.FirstName} {d.LastName} - {d.AppointmentCount} appointments");
                }
            }
        }
    }
}
