using ClinicFlowDB2;
using ClinicFlowDB2.Models;
using System.Collections.Generic;

namespace ClinicFlowApp.Models
{
    public class Treatment
    {
        public int TreatmentID { get; set; }
        public string Name { get; set; }
        public decimal? Price { get; set; }
        public int? DurationMinutes { get; set; }

        public ICollection<AppointmentTreatment> AppointmentTreatments { get; set; }
    }
}
