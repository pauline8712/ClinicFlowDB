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
        }
    }
}
