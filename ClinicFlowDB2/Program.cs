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
    }
}
