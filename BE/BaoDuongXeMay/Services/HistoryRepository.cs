using BaoDuongXeMay.Data;
using BaoDuongXeMay.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;

namespace BaoDuongXeMay.Services
{
    public class HistoryRepository : IHisrotyRepository
    {
        private readonly MyDbContext _context;
        public HistoryRepository(MyDbContext context)
        {
            _context = context;
        }
        public HistoryVM Add(HistoryModel loai)
        {
            var _loai = new History
            {
                IDDeatil = loai.IDDeatil,
                IDDetailNAU = loai.IDDetailNAU,
                TotalCost = loai.TotalCost,
                RepairDate = loai.RepairDate
            };
            _context.Add(_loai);
            _context.SaveChanges();

            return new HistoryVM
            {
                IDDeatil = _loai.IDDeatil,
                IdHistory = _loai.IdHistory,
                IDDetailNAU = _loai.IDDetailNAU,
                TotalCost = _loai.TotalCost,
                RepairDate = _loai.RepairDate
            };
        }

        public void Delete(Guid id)
        {
            var loai = _context.Histories.FirstOrDefault(lo => lo.IdHistory == id);
            if (loai != null)
            {
                _context.Remove(loai);
                _context.SaveChanges();
            }
        }

        public List<HistoryVM> GetAll()
        {
            var loais = _context.Histories.Select(lo => new HistoryVM
            {
                IDDeatil = lo.IDDeatil,
                IdHistory = lo.IdHistory,
                IDDetailNAU = lo.IDDetailNAU,
                TotalCost = lo.TotalCost,
                RepairDate = lo.RepairDate
            });
            return loais.ToList();
        }

        public HistoryVM GetByID(Guid id)
        {
            var loai = _context.Histories.FirstOrDefault(lo => lo.IDDeatil == id);
            if (loai != null)
            {
                return new HistoryVM
                {
                    IDDeatil = loai.IDDeatil,
                    IdHistory = loai.IdHistory,
                    IDDetailNAU = loai.IDDetailNAU,
                    TotalCost = loai.TotalCost,
                    RepairDate = loai.RepairDate
                };
            }
            return null;
        }

        public void Update(HistoryVM loai)
        {
            throw new NotImplementedException();
        }
    }
}
