using SMSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSIDAL
{

    public interface IBaseDal_HZ<T> where T : class ,new()
    {
        int Add(T entity);

        //int Insert(T entity);

        bool Update(T entity, SqlTransaction trans = null);

        bool DeleteFalse(T entity, int id);

        int DeleteBatchFalse(T entity, params int[] ids);

        bool Delete(T entity, int id);

        int DeleteBatch(T entity, params string[] ids);

        T GetEntityById(T entity, int id);
        bool GetInfoById(T entity, int id);

        List<T> GetEntityListByField(T entity, string filed, string value);
        //IQueryable<T> LoadEntities(Func<T, bool> whereLambda);//规约设计模式。 where a>10

        //IQueryable<T> LoadPageEntities<S>(int pageSize, int pageIndex, out int total,
        //                                          Func<T, bool> whereLambda
        //                                          , Func<T, S> orderbyLambda, bool isAsc);
        //DataTable GetEntityOfPage(int pageIndex, int pagesize, string fdname, string filedName, T entity, string WhereStr, string OrderByStr, out int pageCount, out int recordcount);

        //bool CheckForeignKey(T entity, string field, string value);
        //DataTable GetData(T entity, string where, string order);
        //int GetRecordCount(string TableName, string strWhere, SqlParameter[] parms4org);
        DataTable GetListByPage(Hashtable ht,out int RowCount, bool IsPage = true,string Where = "");
        //JsonModel GetListByPage(Hashtable ht, string Where, string FiledName, bool IsPage);
        //JsonModel GetListByPage(Hashtable ht, string Where, string FiledName, string orderby, bool IsPage);

    }
}
