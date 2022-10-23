using System.ComponentModel.DataAnnotations;

namespace BaoDuongXeMay.Models
{
    public class AccessaryModel
    {
        [Required]
        public string AccessaryName { get; set; }
        public string Image { get; set; }
    }
}
