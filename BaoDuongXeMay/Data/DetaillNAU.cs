﻿using System;

namespace BaoDuongXeMay.Data
{
    public class DetaillNAU
    {
        public Guid AccessaryID { get; set; }
        public Guid UnitID { get; set; }
        public Guid VehicleID { get; set; }
        public int Km_Min { get; set; }
        public int Km_Max { get; set; }
        public int CountPerforation { get; set; }

        //relationship
        public Accessary Accessary { get; set; }
        public Unit Unit { get; set; }
        public Vehicle Vehicle { get; set; }
    }
}
