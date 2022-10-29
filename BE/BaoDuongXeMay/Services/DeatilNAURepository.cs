using BaoDuongXeMay.Data;
using BaoDuongXeMay.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BaoDuongXeMay.Services
{
    public class DeatilNAURepository : IDetailNAURepository
    {
        private readonly MyDbContext _context;

        public DeatilNAURepository(MyDbContext context)
        {
            _context = context;
        }
        public List<DetailNAUModel> GetAll()
        {
            var loais = _context.DetaillNAUs.Select(lo => new DetailNAUModel
            {
                IDDetailNAU = lo.IDDetailNAU,
                Km_Min = lo.Km_Min,
                Km_Max = lo.Km_Max,
                CountPerforation = lo.CountPerforation,
                AccessaryName = lo.Accessary.AccessaryName,
                UnitName = lo.Unit.UnitName,
                VehicleName = lo.Vehicle.VehicleName
            });
            return loais.ToList();
        }

        //public DetailNAUModel GetByID(Guid id)
        //{
        //    //var loai = _context.DetaillNAUs.FirstOrDefault(lo => lo.IDDetailNAU == id);
        //    //if (loai != null)
        //    //{
        //    //    return new DetailNAUModel
        //    //    {
        //    //        IDDetailNAU = loai.IDDetailNAU,
        //    //        Km_Min = loai.Km_Min,
        //    //        Km_Max = loai.Km_Max,
        //    //        CountPerforation = loai.CountPerforation,
        //    //    };
        //    //}
        //    return null;
        //}
    }
}
