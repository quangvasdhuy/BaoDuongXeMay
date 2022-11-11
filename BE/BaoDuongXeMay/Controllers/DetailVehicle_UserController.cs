using BaoDuongXeMay.Models;
using BaoDuongXeMay.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;

namespace BaoDuongXeMay.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DetailVehicle_UserController : ControllerBase
    {
        private readonly IDetailVehicle_UserRepository _detailVehicle_UserRepository;
        public DetailVehicle_UserController(IDetailVehicle_UserRepository detailVehicle_UserRepository)

        {
            _detailVehicle_UserRepository = detailVehicle_UserRepository;
        }
        [HttpGet]
        public IActionResult GetAllDetailVehicle_User()
        {
            try
            {
                var result = _detailVehicle_UserRepository.GetAll();
                return Ok(result);
            }
            catch
            {
                return BadRequest("Khong tim thay san pham can tim");
            }
        }

        [HttpPost]
        public IActionResult Add(DetailVehicle_UserModel loai)
        {
            try
            {
                return Ok(_detailVehicle_UserRepository.Add(loai));
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
                var data = _detailVehicle_UserRepository.GetByID(id);
                if (data != null)
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
        public IActionResult Update(DetailVehicle_UserVM loai, Guid id)
        {
            if (id != loai.IDDeatil)
            {
                return BadRequest();
            }
            try
            {
                _detailVehicle_UserRepository.Update(loai, id);
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
                _detailVehicle_UserRepository.Delete(id);
                return NoContent();
            }
            catch
            {
                return BadRequest();
            }
        }
    }
}
