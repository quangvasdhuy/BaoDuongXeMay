using System.ComponentModel.DataAnnotations;

namespace BaoDuongXeMay.Models
{
    public class CategoryVehicleModel
    {
        [Required]
        public string CategoryVehicleName { get; set; }
    }
}
