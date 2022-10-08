using BaoDuongXeMay.Data;
using BaoDuongXeMay.Models;
using BaoDuongXeMay.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Linq;

namespace BaoDuongXeMay.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class VehiclesController : ControllerBase
    {
        private readonly MyDbContext _context;
        //private readonly IVehicleRepository _vehicleRepository;

        public VehiclesController(MyDbContext context)
        {
            _context = context;
        }

        //public VehiclesController(IVehicleRepository vehicleRepository)
        //{
        //    _vehicleRepository = vehicleRepository;
        //}

        [HttpGet]
        public IActionResult GetAll()
        {
            var listVehicles = _context.Vehicles.ToList();
            return Ok(listVehicles);
        }
        [HttpGet("{id}")]
        public IActionResult GetById(Guid id)
        {
            var oneItem = _context.Vehicles.SingleOrDefault(mo => mo.VehicleID == id);
            if (oneItem != null)
            {
                return Ok(oneItem);
            }
            else
            {
                return BadRequest();
            }
        }

        
        [HttpPost]
        public IActionResult CreateNew(VehicleModel model)
        {
            try
            {
                var newItem = new Vehicle
                {
                    VehicleID = new Guid(),
                    Description = model.Description,
                    VehicleName = model.VehicleName,
                    CategoryVehicleID = model.CategoryVehicleID
                };
                _context.Add(newItem);
                _context.SaveChanges();
                return Ok(newItem);
            }
            catch
            {
                return BadRequest();
            }

        }
        [HttpPut("{id}")]
        public IActionResult UpdateById(Guid id, VehicleModel model)
        {
            var editItem = _context.Vehicles.SingleOrDefault(mo => mo.VehicleID == id);
            if (editItem != null)
            {
                editItem.VehicleName = model.VehicleName;
                editItem.Description = model.Description;
                _context.SaveChanges();
                return NoContent();
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteVehicleItem(Guid id)
        {
            var deleteItem = _context.Vehicles.SingleOrDefault(mo => mo.VehicleID == id);

            if (deleteItem == null)
            {
                return BadRequest();
            }

            _context.Vehicles.Remove(deleteItem);
            _context.SaveChanges();

            return NoContent();
        }

        [Route("GetAllCategoryVehicle")]
        [HttpGet]
        public IActionResult GetAllAllCategoryVehicle()
        {
            var dsChuong = _context.Vehicles.ToList();
            return Ok(dsChuong);
        }


    }
}
