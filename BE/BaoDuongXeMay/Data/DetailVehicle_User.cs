using System;
using System.Collections.Generic;

namespace BaoDuongXeMay.Data
{
    public class DetailVehicle_User
    {
        public Guid IDDeatil { get; set; }
        public Guid VehicleID { get; set; }
        public int UserID { get; set; }
        public float KM_Current { get; set; }

        //relationship
        public User User { get; set; }
        public Vehicle Vehicle { get; set; }

        public ICollection<History> Histories { get; set; }

        public DetailVehicle_User()
        {
            Histories = new List<History>();

        }
    }
}
