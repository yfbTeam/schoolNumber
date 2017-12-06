using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSIBLL
{
    public interface IBaseService<T> where T : class ,new()
    {
        bool Add(T entity);
        //int Insert(T entity);

        bool Update(T entity);

        bool DeleteFalse(int id);

        int DeleteBatchFalse(params int[] ids);

        bool Delete(int id);

        int DeleteBatch(params string[] ids);

        T GetEntityById(int id);
       // bool CheckForeignKey(T entity, string field, string value);

        List<T> GetEntityListByField(string filed, string value);

        DataTable GetEntityOfPage(int pageIndex, int pagesize, string fdname, string filedName, string WhereStr, string OrderByStr, out int pageCount, out int recordcount);

        //bool CheckForeignKey(string field, string value);

        DataTable GetData(string where, string order);

    }
}
