using System;
using System.Collections.Generic;
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
        public string Username { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Image { get; set; }

        public ICollection<DetailVehicle_User> DetailVehicle_Users { get; set; }

        public User()
        {
            DetailVehicle_Users = new List<DetailVehicle_User>();
        }
    }
}
