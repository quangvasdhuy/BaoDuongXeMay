using System;

namespace BaoDuongXeMay.Data
{
    public class History
    {
        public Guid IdHistory { get; set; }
        public Guid IDDetailNAU { get; set; }
        public Guid IDDeatil { get; set; }

        public DateTime RepairDate  { get; set; }
        public float TotalCost { get; set; }

        //relationship
        public DetaillNAU DetaillNAU { get; set; }
        public DetailVehicle_User DetailVehicle_User { get; set; }
        
    }
}
