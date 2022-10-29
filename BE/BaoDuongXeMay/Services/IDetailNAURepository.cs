using BaoDuongXeMay.Models;
using System;
using System.Collections.Generic;

namespace BaoDuongXeMay.Services
{
    public interface IDetailNAURepository
    {
        List<DetailNAUModel> GetAll();
        //DetailNAUModel GetByID(Guid id);
    }
}
