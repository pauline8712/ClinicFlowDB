using ClinicFlowDB2;
using ClinicFlowDB2.Models;
using System;
using System.Collections.Generic;

namespace ClinicFlowApp.Models
{
    public class Appointment
    {
        public int AppointmentID { get; set; }
        public DateTime AppointmentDate { get; set; }
        public string Status { get; set; }
        public DateTime CreatedAt { get; set; }

        public int PatientID { get; set; }
        public Patient Patient { get; set; }

        public int DoctorID { get; set; }
        public Doctor Doctor { get; set; }

        public int ClinicID { get; set; }
        public Clinic Clinic { get; set; }

        public ICollection<AppointmentTreatment> AppointmentTreatments { get; set; }
    }
}
