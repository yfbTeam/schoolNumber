using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMIDAL
{
    public interface IBaseDal<T> where T : class ,new()
    {
        int Add(T entity, SqlTransaction trans = null);

        bool Update(T entity, SqlTransaction trans = null);

        bool DeleteFalse(T entity, int id, SqlTransaction trans = null);

        int DeleteBatchFalse(T entity, params int[] ids);

        bool Delete(T entity, int id, SqlTransaction trans = null);

        int DeleteBatch(T entity, params string[] ids);
        int DeleteBatch(SqlTransaction trans, T entity, params string[] ids);

        T GetEntityById(T entity, int id, SqlTransaction trans = null);
        //IQueryable<T> LoadEntities(Func<T, bool> whereLambda);//规约设计模式。 where a>10

        //IQueryable<T> LoadPageEntities<S>(int pageSize, int pageIndex, out int total,
        //                                          Func<T, bool> whereLambda
        //                                          , Func<T, S> orderbyLambda, bool isAsc);
        DataTable GetEntityOfPage(int pageIndex, int pagesize, string fdname, string filedName, T entity, string WhereStr, string OrderByStr, out int pageCount, out int recordcount);

        DataTable GetData(T entity, string where, string order, SqlTransaction trans = null);
        int GetRecordCount(string TableName, string strWhere, SqlParameter[] parms4org);
        DataTable GetListByPage(Hashtable ht,out int rowCount,bool IsPage);

        bool IsNameExists(T entity, string syskey, string name, Int32 Id, string fieldname, bool isJudgeSys);
    }
}
