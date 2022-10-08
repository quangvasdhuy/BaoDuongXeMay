using System.ComponentModel.DataAnnotations;

namespace BaoDuongXeMay.Models
{
    public class LoginModel
    {
        [Required]
        [MaxLength(100)]
        public string Username { get; set; }
        [Required, MaxLength(250)]
        public string Password { get; set; }
    }
}
