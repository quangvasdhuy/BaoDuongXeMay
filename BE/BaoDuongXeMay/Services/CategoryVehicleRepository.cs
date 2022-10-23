using BaoDuongXeMay.Data;
using BaoDuongXeMay.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BaoDuongXeMay.Services
{
    public class CategoryVehicleRepository : ICatagoryVehicleRepository
    {
        private readonly MyDbContext _context;

        public CategoryVehicleRepository(MyDbContext context)
        {
            _context = context;
        }
        public CategoryVehicleVM Add(CategoryVehicleModel loai)
        {
            var _loai = new CategoryVehicle
            {
                CategoryVehicleName = loai.CategoryVehicleName,
                Image = loai.Image,
            };
            _context.Add(_loai);
            _context.SaveChanges();

            return new CategoryVehicleVM
            {
                CategoryVehicleID = _loai.CategoryVehicleID,
                CategoryVehicleName = _loai.CategoryVehicleName, 
                Image = _loai.Image,
            };
        }

        public void Delete(Guid id)
        {
            var loai = _context.CategoryVehicles.FirstOrDefault(lo => lo.CategoryVehicleID == id);
            if (loai != null)
            {
                _context.Remove(loai);
                _context.SaveChanges();
            }
        }

        public List<CategoryVehicleVM> GetAll()
        {
            var loais = _context.CategoryVehicles.Select(lo => new CategoryVehicleVM {
                CategoryVehicleID = lo.CategoryVehicleID,
                CategoryVehicleName = lo.CategoryVehicleName,
                Image = lo.Image
            });
            return loais.ToList();
        }

        public CategoryVehicleVM GetByID(Guid id)
        {
            var loai = _context.CategoryVehicles.FirstOrDefault(lo => lo.CategoryVehicleID == id);
            if (loai != null) {
                return new CategoryVehicleVM
                {
                    CategoryVehicleID = loai.CategoryVehicleID,
                    CategoryVehicleName = loai.CategoryVehicleName,
                    Image = loai.Image
                };
            }
            return null;
        }

        public void Update(CategoryVehicleVM loai)
        {
            var _loai = _context.CategoryVehicles.FirstOrDefault(lo => lo.CategoryVehicleID == loai.CategoryVehicleID);
            loai.CategoryVehicleName = _loai.CategoryVehicleName;
            loai.Image = _loai.Image;
            _context.SaveChanges();
        }
    }
}
