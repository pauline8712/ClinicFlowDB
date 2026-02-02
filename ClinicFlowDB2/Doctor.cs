using ClinicFlowDB2;
using ClinicFlowDB2.Models;
using System;
using System.Collections.Generic;

namespace ClinicFlowApp.Models
{
    public class Doctor
    {
        public int DoctorID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Specialization { get; set; }
        public DateTime CreatedAt { get; set; }

        public int ClinicID { get; set; }
        public Clinic Clinic { get; set; }

        public ICollection<Appointment> Appointments { get; set; }
    }
}
