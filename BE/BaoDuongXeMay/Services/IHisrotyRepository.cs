using BaoDuongXeMay.Models;
using System.Collections.Generic;
using System;

namespace BaoDuongXeMay.Services
{
    public interface IHisrotyRepository
    {
        List<HistoryVM> GetAll();
        HistoryVM GetByID(Guid id);
        HistoryVM Add(HistoryModel loai);
        void Update(HistoryVM loai);
        void Delete(Guid id);
    }
}
