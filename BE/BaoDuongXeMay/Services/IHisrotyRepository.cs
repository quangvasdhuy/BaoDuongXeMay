using BaoDuongXeMay.Models;
using System.Collections.Generic;
using System;

namespace BaoDuongXeMay.Services
{
    public interface IHisrotyRepository
    {
        List<HistoryVM> GetAll();
        HistoryVM GetByID(Guid id);
        HistoryVM Add(Historynotdate loai);
        HistoryVM Update(HistoryVM loai, Guid id);
        void Delete(Guid id);
    }
}
