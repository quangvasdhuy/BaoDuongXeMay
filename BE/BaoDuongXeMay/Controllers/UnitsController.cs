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
    public class UnitsController : ControllerBase
    {
        private readonly MyDbContext _context;

        public UnitsController(MyDbContext context)
        {
            _context = context;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var listUnits = _context.Units.ToList();
            return Ok(listUnits);
        }
        [HttpGet("{id}")]
        public IActionResult GetById(Guid id)
        {
            var oneItem = _context.Units.SingleOrDefault(mo => mo.UnitID == id);
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
        public IActionResult CreateNew(UnitModel model)
        {
            try
            {
                var newItem = new Unit
                {
                    UnitID = new Guid(),
                    UnitName = model.UnitName,
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
        public IActionResult UpdateById(Guid id, UnitModel model)
        {
            var updateById = _context.Units.SingleOrDefault(mo => mo.UnitID == id);
            if (updateById != null)
            {
                updateById.UnitName = model.UnitName;
                _context.SaveChanges();
                return NoContent();
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteUnitItem(Guid id)
        {
            var deleteItem = _context.Units.SingleOrDefault(mo => mo.UnitID == id);

            if (deleteItem == null)
            {
                return BadRequest();
            }

            _context.Units.Remove(deleteItem);
            _context.SaveChanges();

            return NoContent();
        }

        //[Route("GetAllVehicle")]
        //[HttpGet]
        //public IActionResult GetAllSubject()
        //{
        //    var dsVehicles = _context.Vehicles.ToList();
        //    return Ok(dsVehicles);
        //}
    }
}
