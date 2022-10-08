using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BaoDuongXeMay.Data
{
    public class Unit
    {
        [Key]
       public Guid UnitID { get; set; }
        [Required]
       public string UnitName { get; set; }
        public ICollection<DetaillNAU> DetailNaus { get; set; }
        public Unit()
        {
            DetailNaus = new List<DetaillNAU>();
        }
    }
}
