using SMModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMIBLL
{
    public interface IBaseService<T> where T : class ,new()
    {
        JsonModel Add(T entity);

        JsonModel Update(T entity);

        JsonModel DeleteFalse(int id);

        JsonModel DeleteBatchFalse(params int[] ids);

        JsonModel Delete(int id);

        JsonModel DeleteBatch(params string[] ids);

        JsonModel GetEntityById(int id);

        JsonModel GetEntityOfPage(int pageIndex, int pagesize, string fdname, string filedName, string WhereStr, string OrderByStr, out int pageCount, out int recordcount);

        JsonModel GetData(string where, string order);

        JsonModel IsNameExists(string syskey, string name, Int32 Id = 0, string fieldname = "Name", bool isJudgeSys = false);
    }
}
