using BaoDuongXeMay.Models;
using BaoDuongXeMay.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;

namespace BaoDuongXeMay.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategotyVehicleController : ControllerBase
    {
        private readonly ICatagoryVehicleRepository _catagoryVehiclerepository;

        public CategotyVehicleController(ICatagoryVehicleRepository catagoryVehiclerepository)
        {
            _catagoryVehiclerepository = catagoryVehiclerepository;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            try
            {
                return Ok(_catagoryVehiclerepository.GetAll());
            }
            catch 
            {
                return BadRequest();
            }
        }

        [HttpGet("{id}")]
        public IActionResult GetById(Guid id)
        {
            try
            {
                var data =  _catagoryVehiclerepository.GetByID(id);
                if(data != null)
                {
                    return Ok(data);
                }
                else
                {
                    return NotFound();
                }
            }
            catch
            {
                return BadRequest();
            }
        }
        [HttpPut("{id}")]
        public IActionResult Update(Guid id, CategoryVehicleVM loai)
        {
            if (id != loai.CategoryVehicleID)
            {
                return BadRequest();
            }
            try
            {
                _catagoryVehiclerepository.Update(loai);
                return NoContent();
            }
            catch
            {
                return BadRequest();
            }
        }

        [HttpDelete("{id}")]
        public IActionResult Delete(Guid id)
        {
            try
            {
                _catagoryVehiclerepository.Delete(id);
                return Ok();
            }
            catch
            {
                return BadRequest();
            }
        }

        [HttpPost]
        public IActionResult Add(CategoryVehicleModel loai)
        {
            try
            {
                return Ok(_catagoryVehiclerepository.Add(loai));
            }
            catch
            {
                return BadRequest();
            }
        }
    }
}
