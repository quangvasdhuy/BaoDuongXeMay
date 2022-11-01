﻿using BaoDuongXeMay.Models;
using System.Collections.Generic;
using System;

namespace BaoDuongXeMay.Services
{
    public interface IDetailVehicle_UserRepository
    {
        List<DetailVehicle_UserVM> GetAll();
        DetailVehicle_UserVM GetByID(Guid id);
        DetailVehicle_UserVM Add(DetailVehicle_UserModel loai);
        void Update(DetailVehicle_UserVM loai);
        void Delete(Guid id);
    }
}
