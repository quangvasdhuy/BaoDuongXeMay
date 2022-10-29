using BaoDuongXeMay.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;

namespace BaoDuongXeMay.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DetailNAUController : ControllerBase
    {
        private readonly IDetailNAURepository _detailNAURepository;
        public DetailNAUController(IDetailNAURepository detailNAURepository)

        {
            _detailNAURepository = detailNAURepository;
        }
        [HttpGet]
        public IActionResult GetAllDetailNAU()
        {
            try
            {
                var result = _detailNAURepository.GetAll();
                return Ok(result);
            }
            catch
            {
                return BadRequest("Khong tim thay san pham can tim");
            }
        }

        //[HttpGet("{id}")]
        //public IActionResult GetById(Guid id)
        //{
        //    try
        //    {
        //        var data = _detailNAURepository.GetByID(id);
        //        if (data != null)
        //        {
        //            return Ok(data);
        //        }
        //        else
        //        {
        //            return NotFound();
        //        }
        //    }
        //    catch
        //    {
        //        return BadRequest();
        //    }
        //}

    }
}
