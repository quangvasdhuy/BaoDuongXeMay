﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BaoDuongXeMay.Data
{
    [Table("Vehicle")]
    public class Vehicle
    {
        [Key]
        public Guid VehicleID { get; set; }
        [Required]
        [MaxLength(255)]
        public string VehicleName { get; set; }
        public string Description { get; set; }

        public Guid? CategoryVehicleID { get; set; }
        [ForeignKey("CategoryVehicleID")]
        public CategoryVehicle CategoryVehicle { get; set; }
        public ICollection<DetaillNAU> DetailNaus { get; set; }
        public Vehicle()
        {
            DetailNaus = new List<DetaillNAU>();
        }
    }
}
