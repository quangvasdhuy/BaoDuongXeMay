using BaoDuongXeMay.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace BaoDuongXeMay.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class VehicleController : ControllerBase
    {
        private readonly IVehicleRepository _vehicleRepository;
        public VehicleController(IVehicleRepository vehicleRepository)

        {
            _vehicleRepository = vehicleRepository;
        }

        [HttpGet]
        public IActionResult GetAllProducts(string search)
        {
            try
            {
                var result = _vehicleRepository.GetAll(search);
                return Ok(result);
            }
            catch
            {
                return BadRequest("Khong tim thay san pham can tim");
            }
        }
    }
}
