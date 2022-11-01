using BaoDuongXeMay.Data;
using BaoDuongXeMay.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BaoDuongXeMay.Services
{
    public class DetailVehicle_UserRepository : IDetailVehicle_UserRepository
    {
        private readonly MyDbContext _context;
        public DetailVehicle_UserRepository(MyDbContext context)
        {
            _context = context;
        }
        public DetailVehicle_UserVM Add(DetailVehicle_UserModel loai)
        {
            var _loai = new DetailVehicle_User
            {
                KM_Current = loai.KM_Current,
                UserID = loai.UserID,
                VehicleID = loai.VehicleID
            };
            _context.Add(_loai);
            _context.SaveChanges();

            return new DetailVehicle_UserVM
            {
                IDDeatil = _loai.IDDeatil,
                KM_Current = _loai.KM_Current,
                UserID = _loai.UserID,
                VehicleID = _loai.VehicleID
            };
        }

        public void Delete(Guid id)
        {
            var loai = _context.DetailVehicle_Users.FirstOrDefault(lo => lo.IDDeatil == id);
            if (loai != null)
            {
                _context.Remove(loai);
                _context.SaveChanges();
            }
        }

        public List<DetailVehicle_UserVM> GetAll()
        {
            var loais = _context.DetailVehicle_Users.Select(lo => new DetailVehicle_UserVM
            {
                IDDeatil = lo.IDDeatil,
                VehicleID = lo.VehicleID,
                UserID = lo.UserID,
                KM_Current = lo.KM_Current
            });
            return loais.ToList();
        }

        public DetailVehicle_UserVM GetByID(Guid id)
        {
            var loai = _context.DetailVehicle_Users.FirstOrDefault(lo => lo.IDDeatil == id);
            if (loai != null)
            {
                return new DetailVehicle_UserVM
                {
                    IDDeatil = loai.IDDeatil,
                    VehicleID = loai.VehicleID,
                    UserID = loai.UserID,
                    KM_Current = loai.KM_Current
                };
            }
            return null;
        }

        public void Update(DetailVehicle_UserVM loai)
        {
            var _loai = _context.DetailVehicle_Users.FirstOrDefault(lo => lo.IDDeatil == loai.IDDeatil);
            loai.UserID = _loai.UserID;
            loai.KM_Current = _loai.KM_Current;
            loai.VehicleID = _loai.VehicleID;
            _context.SaveChanges();
        }
    }
}
