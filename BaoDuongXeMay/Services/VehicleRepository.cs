using BaoDuongXeMay.Data;
using BaoDuongXeMay.Models;
using System.Collections.Generic;
using System.Linq;

namespace BaoDuongXeMay.Services
{
    public class VehicleRepository : IVehicleRepository
    {
        private readonly MyDbContext _context;

        public VehicleRepository(MyDbContext context)
        {
            _context = context;
        }
        public List<VehiclesModel> GetAll(string search)
        {
            var allVehicle = _context.Vehicles.AsQueryable();
            if (!string.IsNullOrEmpty(search))
            {
                allVehicle = allVehicle.Where(hh => hh.VehicleName.Contains(search));
            }  

            var result = allVehicle.Select(hh => new VehiclesModel
            {
                VehicleId = hh.VehicleID,
                VehicleName = hh.VehicleName,
                Description =  hh.Description,
                CategoryVehicleName = hh.VehicleName
            });
            return result.ToList();
        }
    }
}
