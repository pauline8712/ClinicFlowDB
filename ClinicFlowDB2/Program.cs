using ClinicFlowApp.Models;
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
                Console.ReadLine(); // ÄNDRING: väntar på Enter så menyn inte blinkar direkt
            }
        }
    }
}
