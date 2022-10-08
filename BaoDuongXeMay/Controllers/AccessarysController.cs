using BaoDuongXeMay.Data;
using BaoDuongXeMay.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Linq;

namespace BaoDuongXeMay.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccessaryController : ControllerBase
    {
        private readonly MyDbContext _context;

        public AccessaryController(MyDbContext context)
        {
            _context = context;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var listAccessaries = _context.Accessaries.ToList();
            return Ok(listAccessaries);
        }
        [HttpGet("{id}")]
        public IActionResult GetById(Guid id)
        {
            var oneItem = _context.Accessaries.SingleOrDefault(mo => mo.AccessaryID == id);
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
        [Authorize]
        public IActionResult CreateNew(AccessaryModel model)
        {
            try
            {
                var newItem = new Accessary
                {
                    AccessaryID = new Guid(),
                    AccessaryName = model.AccessaryName,
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
        public IActionResult UpdateById(Guid id, AccessaryModel model)
        {
            var updateById = _context.Accessaries.SingleOrDefault(mo => mo.AccessaryID == id);
            if (updateById != null)
            {
                updateById.AccessaryName = model.AccessaryName;
                _context.SaveChanges();
                return NoContent();
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteAccessaryItem(Guid id)
        {
            var deleteItem = _context.Accessaries.SingleOrDefault(mo => mo.AccessaryID == id);

            if (deleteItem == null)
            {
                return BadRequest();
            }

            _context.Accessaries.Remove(deleteItem);
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
