using BaoDuongXeMay.Data;
using BaoDuongXeMay.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Security.Cryptography;
using System.Threading.Tasks;

namespace BaoDuongXeMay.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly MyDbContext _context;
        private readonly AppSetting _appSettings;

        public UsersController(MyDbContext context, IOptionsMonitor<AppSetting> optionMonitor)
        {
            _context = context;
            _appSettings = optionMonitor.CurrentValue;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var listUsers = _context.Users.ToList();
            return Ok(listUsers);
        }
        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var oneItem = _context.Users.SingleOrDefault(mo => mo.UserID == id);
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
        public IActionResult CreateNew(UserModel model)
        {
            try
            {
                var newItem = new User
                {
                    Email = model.Email,
                    Name = model.Name,
                    Password = model.Password,
                    Username = model.Username,
                    Image = model.Image
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
        public IActionResult UpdateById(int id, UserModel model)
        {
            var updateById = _context.Users.SingleOrDefault(mo => mo.UserID == id);
            if (updateById != null)
            {
                updateById.Name = model.Name;
                updateById.Password = model.Password;
                updateById.Email = model.Email;
                updateById.Username = model.Username;
                updateById.Image = model.Image;
                _context.SaveChanges();
                return NoContent();
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteUserById(int id)
        {
            var removeItem = _context.Users.SingleOrDefault(mo => mo.UserID == id);

            if (removeItem == null)
            {
                return BadRequest();
            }

            _context.Users.Remove(removeItem);
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

        [HttpPost("Login")]
        public ActionResult Validate(LoginModel model)
        {
            var user = _context.Users.SingleOrDefault(p => p.Username == model.Username && model.Password == p.Password);
            if(user == null)
            {
                return Ok(new ApiResponse
                {
                    Success = false,
                    Message = "Invalid Username/password"
                });
            }
            return Ok(new ApiResponse
            {
                Success = true,
                Message = "Authenticaton success",
                Data = GenerateToken(user)
            });
        }

        private async Task<TokenModel> GenerateToken(User user)
        {
            var jwtTokenHandler = new JwtSecurityTokenHandler();
            var secretKetBytes = Encoding.UTF8.GetBytes(_appSettings.SecretKey);

            var tokenDescription = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                    new Claim(ClaimTypes.Name, user.Name),
                    new Claim(JwtRegisteredClaimNames.Email, user.Email),
                    new Claim(JwtRegisteredClaimNames.Sub, user.Email),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                    new Claim("Username", user.Username),
                    new Claim("Id", user.UserID.ToString()),

                    //roles

                }),
                Expires = DateTime.UtcNow.AddSeconds(20),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey
                (secretKetBytes), SecurityAlgorithms.HmacSha512Signature)
            };
            var token = jwtTokenHandler.CreateToken(tokenDescription);

            var accessToken = jwtTokenHandler.WriteToken(token);
            var refreshToken = GenerateRefreshToken();

            //Luu Database
            var refreshTokenEntity = new RefreshToken
            {
                Id = Guid.NewGuid(),
                JwtId = token.Id,
                Token = refreshToken,
                IsUsed = false,
                IsRevoked = false,
                IssuedAt = DateTime.UtcNow,
                ExpiredAt = DateTime.UtcNow.AddHours(1)
            };

            await _context.AddAsync(refreshTokenEntity);
            await _context.SaveChangesAsync();
            return new TokenModel
            {
                AccessToken = accessToken,
                RefreshToken = refreshToken
            };
        }

        private string GenerateRefreshToken()
        {
            var random = new byte[32];
            using (var rng = RandomNumberGenerator.Create())
            {
                 rng.GetBytes(random);

                return Convert.ToBase64String(random);
            }
        }
    }
}
