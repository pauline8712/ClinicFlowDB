using ClinicFlowDB2.Models;
using ClinicFlowApp.Models;
using Microsoft.EntityFrameworkCore;
using System.Numerics;

namespace ClinicFlowDB2.Models
{
    public class ClinicFlowContext : DbContext
    {
        public DbSet<Clinic> Clinics { get; set; }
        public DbSet<Doctor> Doctors { get; set; }
        public DbSet<Patient> Patients { get; set; }
        public DbSet<Appointment> Appointments { get; set; }
        public DbSet<Treatment> Treatments { get; set; }
        public DbSet<AppointmentTreatment> AppointmentTreatments { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder options)
        {
            options.UseSqlServer(
                @"Server=.\SQLEXPRESS;Database=ClinicFlowDB;Trusted_Connection=True;TrustServerCertificate=True;");
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AppointmentTreatment>()
                .HasOne(at => at.Appointment)
                .WithMany(a => a.AppointmentTreatments)
                .HasForeignKey(at => at.AppointmentID);

            modelBuilder.Entity<AppointmentTreatment>()
                .HasOne(at => at.Treatment)
                .WithMany(t => t.AppointmentTreatments)
                .HasForeignKey(at => at.TreatmentID);
        }
    }
}
