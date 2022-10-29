using System;

namespace BaoDuongXeMay.Models
{
    public class DetailNAUModel
    {
        public Guid IDDetailNAU { get; set; }
        public string AccessaryName { get; set; }
        public string UnitName { get; set; }
        public string VehicleName { get; set; }
        public int Km_Min { get; set; }
        public int Km_Max { get; set; }
        public int CountPerforation { get; set; }
    }
}
