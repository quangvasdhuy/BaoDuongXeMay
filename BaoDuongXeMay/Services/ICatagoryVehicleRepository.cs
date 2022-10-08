using BaoDuongXeMay.Models;
using System;
using System.Collections.Generic;

namespace BaoDuongXeMay.Services
{
    public interface ICatagoryVehicleRepository
    {
        List<CategoryVehicleVM> GetAll();
        CategoryVehicleVM GetByID(Guid id);
        // CategoryVehicleVM GetByName(string name);
        CategoryVehicleVM Add(CategoryVehicleModel loai);
        void Update(CategoryVehicleVM loai);
        void Delete(Guid id);
    }
}
