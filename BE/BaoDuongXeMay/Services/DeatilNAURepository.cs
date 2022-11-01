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
                AccessaryID = lo.AccessaryID,
                UnitID = lo.UnitID,
                VehicleID = lo.VehicleID
            });
            return loais.ToList();
        }

        public DetailNAUModel Add(DetailNAUVM lo)
        {
            var _loai = new DetaillNAU
            {
                Km_Min = lo.Km_Min,
                Km_Max = lo.Km_Max,
                CountPerforation = lo.CountPerforation,
                AccessaryID = lo.AccessaryID,
                UnitID = lo.UnitID,
                VehicleID = lo.VehicleID
            };
            _context.Add(_loai);
            _context.SaveChanges();

            return new DetailNAUModel
            {
                IDDetailNAU = _loai.IDDetailNAU,
                Km_Min = _loai.Km_Min,
                Km_Max = _loai.Km_Max,
                CountPerforation = _loai.CountPerforation,
                AccessaryID = _loai.AccessaryID,
                UnitID = _loai.UnitID,
                VehicleID = _loai.VehicleID
            };
        }

        public DetailNAUModel GetByID(Guid id)
        {
            var loai = _context.DetaillNAUs.FirstOrDefault(lo => lo.IDDetailNAU == id);
            if (loai != null)
            {
                return new DetailNAUModel
                {
                    IDDetailNAU = loai.IDDetailNAU,
                    Km_Min = loai.Km_Min,
                    Km_Max = loai.Km_Max,
                    CountPerforation = loai.CountPerforation,
                    AccessaryID = loai.AccessaryID,
                    UnitID = loai.UnitID,
                    VehicleID = loai.VehicleID
                };
            }
            return null;
        }

        public void Update(DetailNAUModel loai)
        {
            var _loai = _context.DetaillNAUs.FirstOrDefault(lo => lo.IDDetailNAU == loai.IDDetailNAU);
            loai.Km_Min = _loai.Km_Min;
            loai.Km_Max = _loai.Km_Max;
            loai.CountPerforation = _loai.CountPerforation;
            loai.AccessaryID = _loai.AccessaryID;
            loai.UnitID = _loai.UnitID;
            loai.VehicleID = _loai.VehicleID;
            _context.SaveChanges();
        }
    }
}
