using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BaoDuongXeMay.Data
{
    public class Accessary
    {
        [Key]
        public Guid AccessaryID { get; set; }
        [Required]
        public string AccessaryName { get; set; }
        public string Image { get; set; }
        public ICollection<DetaillNAU> DetailNaus { get; set; }
        public Accessary()
        {
            DetailNaus = new List<DetaillNAU>();
        }

    }
}
