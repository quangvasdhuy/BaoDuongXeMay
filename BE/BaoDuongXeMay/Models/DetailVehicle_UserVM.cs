using System;

namespace BaoDuongXeMay.Models
{
    public class DetailVehicle_UserVM
    {
        public Guid IDDeatil { get; set; }
        public Guid VehicleID { get; set; }
        public int UserID { get; set; }
        public float KM_Current { get; set; }
        public float KM_Old { get; set; }
    }
}
