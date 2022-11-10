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
                RepairDate = DateTime.Now,
                Km_accumulation = loai.Km_accumulation
            };
            _context.Add(_loai);
            _context.SaveChanges();

            return new HistoryVM
            {
                IDDeatil = _loai.IDDeatil,
                IdHistory = _loai.IdHistory,
                IDDetailNAU = _loai.IDDetailNAU,
                TotalCost = _loai.TotalCost,
                RepairDate = _loai.RepairDate,
                Km_accumulation = _loai.Km_accumulation
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
                RepairDate = lo.RepairDate,
                Km_accumulation = lo.Km_accumulation
            });
            return loais.ToList();
        }

        public HistoryVM GetByID(Guid id)
        {
            var loai = _context.Histories.FirstOrDefault(lo => lo.IdHistory == id);
            if (loai != null)
            {
                return new HistoryVM
                {
                    IDDeatil = loai.IDDeatil,
                    IdHistory = loai.IdHistory,
                    IDDetailNAU = loai.IDDetailNAU,
                    TotalCost = loai.TotalCost,
                    RepairDate = loai.RepairDate,
                    Km_accumulation = loai.Km_accumulation
                };
            }
            return null;
        }

        public HistoryVM Update(HistoryVM loai, Guid id)
        {
            var updateById = _context.Histories.SingleOrDefault(mo => mo.IdHistory == id);
            if (updateById != null)
            {
                updateById.IDDeatil = loai.IDDeatil;
                updateById.IDDetailNAU = loai.IDDetailNAU;
                updateById.TotalCost = loai.TotalCost;
                updateById.RepairDate = loai.RepairDate;
                updateById.Km_accumulation = loai.Km_accumulation;

                _context.SaveChanges();
                return new HistoryVM
                {
                    IDDeatil = updateById.IDDeatil,
                    IdHistory = updateById.IdHistory,
                    IDDetailNAU = updateById.IDDetailNAU,
                    TotalCost = updateById.TotalCost,
                    RepairDate = updateById.RepairDate,
                    Km_accumulation = updateById.Km_accumulation
                };
            }
            else
            {
                return null;
            }
        }
    }
}
