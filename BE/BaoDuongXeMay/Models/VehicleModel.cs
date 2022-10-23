using BaoDuongXeMay.Data;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System;

namespace BaoDuongXeMay.Models
{
    public class VehicleModel
    {
        [Required]
        [MaxLength(255)]
        public string VehicleName { get; set; }
        public string Description { get; set; }
        public string Image { get; set; }

        public Guid? CategoryVehicleID { get; set; }
    }

    public class VehiclesModel
    {
        public Guid VehicleId { get; set; }
        public string VehicleName { get; set; }
        public string Description { get; set; }
        public string Image { get; set; }

        public string CategoryVehicleName { get; set; }
        
    }
}
