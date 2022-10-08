using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BaoDuongXeMay.Data
{
    public class CategoryVehicle
    {
        [Key]
        public Guid CategoryVehicleID { get; set; }
        [Required]
        public string CategoryVehicleName { get; set; }
        public virtual ICollection<Vehicle> Vehicles { get; set; }
        

    }
}
