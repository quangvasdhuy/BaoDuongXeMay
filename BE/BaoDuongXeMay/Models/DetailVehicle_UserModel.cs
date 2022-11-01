using System;

namespace BaoDuongXeMay.Models
{
    public class DetailVehicle_UserModel
    {
        public Guid VehicleID { get; set; }
        public int UserID { get; set; }
        public float KM_Current { get; set; }
    }
}
