using ClinicFlowApp.Models;

namespace ClinicFlowDB2.Models
{
    public class AppointmentTreatment
    {
        public int AppointmentTreatmentID { get; set; }

        public int AppointmentID { get; set; }
        public Appointment Appointment { get; set; }

        public int TreatmentID { get; set; }
        public Treatment Treatment { get; set; }
    }
}
