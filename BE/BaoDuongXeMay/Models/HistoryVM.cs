using System;

namespace BaoDuongXeMay.Models
{
    public class HistoryVM
    {
        public Guid IdHistory { get; set; }
        public Guid IDDetailNAU { get; set; }
        public Guid IDDeatil { get; set; }

        public DateTime RepairDate { get; set; }
        public float TotalCost { get; set; }
        public float Km_accumulation { get; set; }
    }
}
