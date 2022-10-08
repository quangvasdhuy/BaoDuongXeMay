using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BaoDuongXeMay.Data
{
    [Table("User")]
    public class User
    {
        [Key]
        public int UserID { get; set; }
        public string Name { get; set; }
        [Required]
        [MaxLength(100)]
        public string Username { get; set; }
        public string Email { get; set; }
        [Required, MaxLength(250)]
        public string Password { get; set; }
        
    }
}
