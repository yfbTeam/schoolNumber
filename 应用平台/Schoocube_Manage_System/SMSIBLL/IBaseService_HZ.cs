using SMSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSIBLL
{
    public interface IBaseService_HZ<T> where T : class ,new()
    {
        JsonModel Add(T entity);

        JsonModel Update(T entity,SqlTransaction trans = null);

        JsonModel DeleteFalse(int id);

        JsonModel DeleteBatchFalse(params int[] ids);

        JsonModel Delete(int id);

        JsonModel DeleteBatch(params string[] ids);

        JsonModel GetEntityById(int id);
        // bool CheckForeignKey(T entity, string field, string value);

        JsonModel GetEntityListByField(string filed, string value);

        //JsonModel GetEntityOfPage(int pageIndex, int pagesize, string fdname, string filedName, string WhereStr, string OrderByStr, out int pageCount, out int recordcount);

        //bool CheckForeignKey(string field, string value);

        //JsonModel GetData(string where, string order);
        JsonModel GetPage(Hashtable ht, bool IsPage = true,string Where="");
        DataTable GetData(Hashtable ht, bool IsPage = true, string Where = "");

        //JsonModel GetPage(Hashtable ht, bool IsPage = true);

        bool GetInfoById(int id);
        //JsonModel GetPage(Hashtable ht, string Where, string FiledName, bool IsPage = true);
       // JsonModel GetPage(Hashtable ht, string Where, string FiledName, string orderby, bool IsPage = true);
    }
}
