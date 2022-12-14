using BaoDuongXeMay.Models;
using BaoDuongXeMay.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;

namespace BaoDuongXeMay.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HistoryController : ControllerBase
    {
        private readonly IHisrotyRepository _historyRepository;
        public HistoryController(IHisrotyRepository historyRepository)

        {
            _historyRepository = historyRepository;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            try
            {
                var result = _historyRepository.GetAll();
                return Ok(result);
            }
            catch
            {
                return BadRequest("Khong tim thay san pham can tim");
            }
        }

        [HttpPost]
        public IActionResult Add(HistoryModel loai)
        {
            try
            {
                return Ok(_historyRepository.Add(loai));
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
                var data = _historyRepository.GetByID(id);
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
        public IActionResult Update(HistoryVM loai, Guid id)
        {
            if (id != loai.IdHistory)
            {
                return BadRequest();
            }
            try
            {
                _historyRepository.Update(loai, id);
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
                _historyRepository.Delete(id);
                return Ok();
            }
            catch
            {
                return BadRequest();
            }
        }
    }
}
