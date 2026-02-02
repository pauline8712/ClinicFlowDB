using ClinicFlowApp.Models;
using System.Collections.Generic;
using System.Numerics;

namespace ClinicFlowDB2.Models
{
    public class Clinic
    {
        public int ClinicID { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string City { get; set; }

        public ICollection<Doctor> Doctors { get; set; }
        public ICollection<Appointment> Appointments { get; set; }
    }
}
