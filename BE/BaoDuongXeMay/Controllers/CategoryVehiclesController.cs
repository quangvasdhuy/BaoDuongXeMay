using BaoDuongXeMay.Data;
using BaoDuongXeMay.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Linq;

namespace BaoDuongXeMay.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoryVehicleController : ControllerBase
    {
        private readonly MyDbContext _context;

        public CategoryVehicleController(MyDbContext context)
        {
            _context = context;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var listCategoryVehicles = _context.CategoryVehicles.ToList();
            return Ok(listCategoryVehicles);
        }
        [HttpGet("{id}")]
        public IActionResult GetById(Guid id)
        {
            var oneItem = _context.CategoryVehicles.SingleOrDefault(mo => mo.CategoryVehicleID == id);
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
        public IActionResult CreateNew(CategoryVehicleModel model)
        {
            try
            {
                var newItem = new CategoryVehicle
                {
                    CategoryVehicleID = new Guid(),
                    CategoryVehicleName = model.CategoryVehicleName,
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
        public IActionResult UpdateById(Guid id, CategoryVehicleModel model)
        {
            var updateById = _context.CategoryVehicles.SingleOrDefault(mo => mo.CategoryVehicleID == id);
            if (updateById != null)
            {
                updateById.CategoryVehicleName = model.CategoryVehicleName;
                _context.SaveChanges();
                return NoContent();
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteExerciseItem(Guid id)
        {
            var monItem = _context.CategoryVehicles.SingleOrDefault(mo => mo.CategoryVehicleID == id);

            if (monItem == null)
            {
                return BadRequest();
            }

            _context.CategoryVehicles.Remove(monItem);
            _context.SaveChanges();

            return NoContent();
        }

        [Route("GetAllVehicle")]
        [HttpGet]
        public IActionResult GetAllSubject()
        {
            var dsVehicles = _context.Vehicles.ToList();
            return Ok(dsVehicles);
        }
    }
}
