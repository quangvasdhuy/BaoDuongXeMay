using BaoDuongXeMay.Models;
using System.Collections.Generic;

namespace BaoDuongXeMay.Services
{
    public interface IVehicleRepository
    {
        
        List<VehiclesModel> GetAll(string search);
    }
}
