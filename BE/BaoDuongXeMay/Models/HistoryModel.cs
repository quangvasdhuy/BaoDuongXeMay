using System;

namespace BaoDuongXeMay.Models
{
    public class HistoryModel
    {
        public Guid IDDetailNAU { get; set; }
        public Guid IDDeatil { get; set; }

        public DateTime RepairDate { get; set; }
        public float TotalCost { get; set; }
    }
}
