using System;

namespace BaoDuongXeMay.Models
{
    public class DetailNAUVM
    {
        public Guid AccessaryID { get; set; }
        public Guid UnitID { get; set; }
        public Guid VehicleID { get; set; }
        public int Km_Min { get; set; }
        public int Km_Max { get; set; }
        public int CountPerforation { get; set; }
    }
}
