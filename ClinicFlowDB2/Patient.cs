using ClinicFlowDB2;
using System;
using System.Collections.Generic;

namespace ClinicFlowApp.Models
{
    public class Patient
    {
        public int PatientID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public DateTime CreatedAt { get; set; }

        public ICollection<Appointment> Appointments { get; set; }
    }
}
