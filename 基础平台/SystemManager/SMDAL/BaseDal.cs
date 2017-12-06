using SMUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace SMDAL
{
    public class BaseDal<T> where T : class , new()
    {
        #region 增删改查的辅助方法
        /// <summary>
        /// 添加数据的辅助方法
        /// </summary>
        /// <param name="entity">要添加的实体对象</param>
        /// <param name="sql">返回添加的SQL语句</param>
        /// <returns>返回Parameter的集合</returns>
        public List<SqlParameter> DalAddHelp(T entity, out string sql)
        {
            Type ty = entity.GetType();
            StringBuilder strFirst = new StringBuilder();
            StringBuilder strSecond = new StringBuilder();
            PropertyInfo[] pros = ty.GetProperties();
            List<SqlParameter> pms = new List<SqlParameter>();
            for (int i = 0; i < pros.Count(); i++)
            {
                if (ty.GetProperties()[i].Name.ToUpper() != "ID")
                {
                    strFirst.Append(pros[i].Name + ",");
                    strSecond.Append("@" + pros[i].Name + ",");
                    SqlParameter para = new SqlParameter("@" + pros[i].Name, pros[i].GetValue(entity, null) == null ? DBNull.Value : pros[i].GetValue(entity, null));
                    pms.Add(para);
                }
            }
            sql = string.Format("insert into {0}({1}) values({2});select @@identity", ty.Name, strFirst.ToString().TrimEnd(','), strSecond.ToString().TrimEnd(','));
            return pms;
        }

        /// <summary>
        /// 更新数据的辅助方法
        /// </summary>
        /// <param name="entity">要更新的实体对象</param>
        /// <param name="sql">返回更新的SQL语句</param>
        /// <returns>返回Parameter的集合</returns>
        public List<SqlParameter> DalUpdateHelp(T entity, out string sql)
        {

            Type ty = entity.GetType();
            StringBuilder strFirst = new StringBuilder();

            PropertyInfo[] pros = ty.GetProperties();
            List<SqlParameter> pms = new List<SqlParameter>();
            for (int i = 0; i < pros.Count(); i++)
            {
                if (ty.GetProperties()[i].Name.ToUpper() != "ID")
                {
                    strFirst.Append(pros[i].Name + "=@" + pros[i].Name + ",");
                }
                SqlParameter para = new SqlParameter("@" + pros[i].Name, pros[i].GetValue(entity, null) == null ? DBNull.Value : pros[i].GetValue(entity, null));
                pms.Add(para);

            }
            sql = string.Format("update {0} set {1} where id=@id", ty.Name, strFirst.ToString().TrimEnd(','));
            return pms;
        }

        /// <summary>
        /// 删除数据的辅助方法
        /// </summary>
        /// <param name="pros">要删除对象的属性集合</param>
        /// <param name="entity">要删除的实体</param>
        /// <returns>返回实体属性和属性值得对应集合</returns>
        private Dictionary<string, object> DalDeleteHelp(PropertyInfo[] pros, T entity)
        {
            Dictionary<string, object> dic = new Dictionary<string, object>();
            foreach (PropertyInfo pro in pros)
            {
                dic.Add(pro.Name, pro.GetValue(entity, null));
            }
            return dic;
        }

        /// <summary>
        /// 批量删除数据的辅助方法
        /// </summary>
        /// <param name="entity">对象实体</param>
        /// <param name="sql">要执行的SQL语句</param>
        /// <param name="ids">要删除的对象Id集合</param>
        /// <returns></returns>
        public List<SqlParameter> DalDeleteBatchHelp(T entity, out string sql, params int[] ids)
        {
            StringBuilder strFirst = new StringBuilder();
            List<SqlParameter> pms = new List<SqlParameter>();
            foreach (int item in ids)
            {
                strFirst.Append("@id" + item.ToString() + ",");
                pms.Add(new SqlParameter("@id" + item.ToString(), item));
            }
            sql = string.Format("delete from {0} where id in({1})", entity.GetType().Name, strFirst.ToString().TrimEnd(','));
            return pms;
        }
        #endregion


        /// <summary>
        /// 添加单条数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual int Add(T entity, SqlTransaction trans = null)
        {
            string sql = string.Empty;
            List<SqlParameter> pms = DalAddHelp(entity, out sql);
            if (trans == null)
            {
                return Convert.ToInt32(SQLHelp.ExecuteScalar(sql, System.Data.CommandType.Text, pms.ToArray()));
            }
            else
            {
                return Convert.ToInt32(SQLHelp.ExecuteScalar(trans,sql, System.Data.CommandType.Text, pms.ToArray()));
            }
        }

        /// <summary>
        /// 更新单挑数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual bool Update(T entity, SqlTransaction trans = null)
        {
            string sql = string.Empty;
            List<SqlParameter> pms = DalUpdateHelp(entity, out sql);
            if (trans == null)
            {
                return SQLHelp.ExecuteNonQuery(sql, System.Data.CommandType.Text, pms.ToArray()) > 0;
            }
            else
            {
                return SQLHelp.ExecuteNonQuery(trans,sql, System.Data.CommandType.Text, pms.ToArray()) > 0;
            }
        }

        /// <summary>
        /// 根据Id获取单条数据
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public virtual T GetEntityById(T entity, int id, SqlTransaction trans = null)
        {
            string sql = string.Format("select * from {0} where Id=@id", entity.GetType().Name);
            SqlParameter pms = new SqlParameter("@id", id);
            SqlDataReader reader = trans == null ? SQLHelp.ExecuteReader(sql, CommandType.Text, pms) : SQLHelp.ExecuteReader(trans,sql, CommandType.Text, pms);
            if (reader.HasRows)
            {
                PropertyInfo[] pros = entity.GetType().GetProperties();
                while (reader.Read())
                {

                    foreach (PropertyInfo item in pros)
                    {                       
                      item.SetValue(entity, reader.IsDBNull(reader.GetOrdinal(item.Name)) ? null: reader[item.Name]);
                    }
                }
            }
            else { entity = null; }
            return entity;
        }
        #region 判断名称是否已存在
        /// <summary>
        /// 判断名称是否已存在
        /// </summary>
        /// <param name="entity">实体</param>
        /// <param name="syskey">系统key</param>
        /// <param name="name">名称</param>
        /// <param name="Id">Id</param>
        /// <param name="fieldname">字段名称（默认为Name）</param>
        /// <param name="isJudgeSys">是否判断系统key（默认false）</param>
        /// <returns></returns>
        public virtual bool IsNameExists(T entity, string syskey, string name, Int32 Id, string fieldname, bool isJudgeSys)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            string sql = string.Format("select COUNT(1) from {0} where IsDelete=0 and {1}=@Name ", entity.GetType().Name, fieldname);
            if (isJudgeSys)
            {
                sql += " and SystemKey=@SystemKey ";
            }
            if (Id != 0)
            {
                sql +=" and Id!=@Id ";
            }
            pms.Add(new SqlParameter("@SystemKey", syskey));
            pms.Add(new SqlParameter("@Name", name));
            pms.Add(new SqlParameter("@Id", Id));
            object obj = SQLHelp.ExecuteScalar(sql, CommandType.Text, pms.ToArray());
            return int.Parse(obj.ToString()) > 0;
        }
        #endregion        
        public virtual List<T> GetEntityListByField(T entity, string filed, string value, SqlTransaction trans = null)
        {
            List<T> tlist = new List<T>();
            string sql = string.Format("select * from {0} where {1}=@id", entity.GetType().Name, filed);
            SqlParameter pms = new SqlParameter("@id", value);
            SqlDataReader reader = trans == null ? SQLHelp.ExecuteReader(sql, CommandType.Text, pms) : SQLHelp.ExecuteReader(trans, sql, CommandType.Text, pms);
            if (reader.HasRows)
            {
                PropertyInfo[] pros = entity.GetType().GetProperties();
                T newentity = new T();
                while (reader.Read())
                {
                    foreach (PropertyInfo item in pros)
                    {
                        item.SetValue(newentity, reader[item.Name]);
                    }
                    tlist.Add(newentity);
                }
            }
            return tlist;
        }

        /// <summary>
        /// 伪删除单条数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual bool DeleteFalse(T entity, int id, SqlTransaction trans = null)
        {
            string sql = string.Format("update {0} set IsDelete=1 where Id=@id", entity.GetType().Name);
            SqlParameter pms = new SqlParameter("@id", id);
            if (trans == null)
            {
                return SQLHelp.ExecuteNonQuery(sql, System.Data.CommandType.Text, pms) > 0;
            }
            else
            {
                return SQLHelp.ExecuteNonQuery(trans, sql, System.Data.CommandType.Text, pms) > 0;
            }
        }

        /// <summary>
        /// 批量伪删除数据
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public virtual int DeleteBatchFalse(T entity, params int[] ids)
        {
            return 0;

        }

        #region 删除单条数据 或 在事务中执行，删除单条数据
        /// <summary>
        ///  删除单条数据 或 在事务中执行，删除单条数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual bool Delete(T entity, int id, SqlTransaction trans=null)
        {
            string sql = string.Format("delete from {0} where id=@Id", entity.GetType().Name);
            SqlParameter pms = new SqlParameter("@Id", id);
            if (trans == null)
            {
                return SQLHelp.ExecuteNonQuery(sql, CommandType.Text, pms) > 0;
            }
            else
            {
                return SQLHelp.ExecuteNonQuery(trans,sql, CommandType.Text, pms) > 0;
            }            
        }
        #endregion             

        #region 根据传的字段名删除数据 或 在事务中执行，删除数据
        /// <summary>
        ///  根据传的字段名删除数据 或 在事务中执行，删除数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual bool Delete(T entity,string fieldname, int id, SqlTransaction trans = null)
        {
            string sql = string.Format("delete from {0} where " + fieldname + "=@Id", entity.GetType().Name);
            SqlParameter pms = new SqlParameter("@Id", id);
            if (trans == null)
            {
                return SQLHelp.ExecuteNonQuery(sql, CommandType.Text, pms) > 0;
            }
            else
            {
                return SQLHelp.ExecuteNonQuery(trans, sql, CommandType.Text, pms) > 0;
            }
        }
        #endregion             

        #region 批量删除数据
        /// <summary>
        /// 批量删除数据
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public virtual int DeleteBatch(T entity, params string[] ids)
        {
            string sql = string.Empty;
            int length = ids.Length;
            int[] intids = new int[length];
            for (int i = 0; i < ids.Length; i++)
            {
                string item = ids[i];
                intids[i] = int.Parse(item);
            }
            List<SqlParameter> pms = DalDeleteBatchHelp(entity, out sql, intids);
            return SQLHelp.ExecuteNonQuery(sql, CommandType.Text, pms.ToArray());
        }
        #endregion       
        #region 在事务中执行，批量删除数据
        public virtual int DeleteBatch(SqlTransaction trans, T entity, params string[] ids)
        {
            string sql = string.Empty;
            int length = ids.Length;
            int[] intids = new int[length];
            for (int i = 0; i < ids.Length; i++)
            {
                string item = ids[i];
                intids[i] = int.Parse(item);
            }
            List<SqlParameter> pms = DalDeleteBatchHelp(entity, out sql, intids);
            return SQLHelp.ExecuteNonQuery(trans,sql, CommandType.Text, pms.ToArray());
        }
        #endregion

        #region 获得事务对象
        /// <summary>
        /// 获得事务对象
        /// </summary>
        /// <returns></returns>
        public SqlTransaction GetTran()
        {
            return SQLHelp.BeginTransaction();
        }
        #endregion


        /// <summary>
        /// 根据条件获取所有数据
        /// </summary>
        /// <param name="entity">实体类</param>
        /// <param name="where">条件（例如：id>1）</param>
        /// <param name="order">排序（例如：createtime desc）</param>
        /// <returns></returns>
        public virtual DataTable GetData(T entity, string where, string order, SqlTransaction trans = null)
        {
            string sql = string.Format(@"select * from {0} ", entity.GetType().Name);
            StringBuilder strFirst = new StringBuilder();
            List<SqlParameter> pms = new List<SqlParameter>();
            if (!string.IsNullOrEmpty(where))
            {
                sql += string.Format(@" where {0}", where);
            }
            if (!string.IsNullOrEmpty(order))
            {
                sql += string.Format(@" Order by {0}", order);
            }
            DataTable dt = trans == null ? SQLHelp.ExecuteDataTable(sql, CommandType.Text, null) : SQLHelp.ExecuteDataTable(trans,sql, CommandType.Text, null);
            return dt;
        }

        /// <summary>
        /// 分页获取数据
        /// </summary>
        /// <param name="pageIndex">当前查询页</param>
        /// <param name="pagesize">每页记录集数量</param>
        /// <param name="fdname">用于定位记录的主键(惟一键)字段,可以是逗号分隔的多个字段</param>
        /// <param name="filedName">以逗号分隔的要显示的字段列表,如果不指定,则显示所有字段</param>
        /// <param name="TableName">实体类</param>
        /// <param name="WhereStr">条件语句(可为空)</param>
        /// <param name="OrderByStr">以逗号分隔的排序字段列表,可以指定在字段后面指定DESC/ASC用于指定排序顺序(可为空)</param>
        /// <param name="pageCount">输出总页数</param>
        /// <param name="recordcount">记录集总数</param>
        /// <returns></returns>
        public virtual DataTable GetEntityOfPage(int pageIndex, int pagesize, string fdname, string filedName, T entity, string WhereStr, string OrderByStr, out int pageCount, out int recordcount)
        {
            try
            {
                //拼接表名
                string tablename = "" + entity.GetType().Name;
                DataTable dt = SQLHelp.pageSearch(pageIndex, pagesize, fdname, filedName, tablename, WhereStr, OrderByStr, out pageCount, out recordcount);
                return dt;
            }
            catch (Exception exc)
            {
                throw new Exception(exc.Message);
            }
        }


        public virtual int GetRecordCount(string TableName, string strWhere, SqlParameter[] parms4org)
        {
            try
            {
                int RowCount = SQLHelp.GetRecordCount(TableName, strWhere, parms4org);
                return RowCount;
            }
            catch (Exception)
            {
                //写入日志
                //throw;
                return 0;
            }

        }
        public virtual DataTable GetListByPage(Hashtable ht,out int rowCount, bool IsPage)
        // string TableName, string strWhere, string orderby, int startIndex, int endIndex, SqlParameter[] parms4org)
        {
            SqlParameter[] parms4org = { };
            rowCount = 0;
            try
            {
                DataTable dt = SQLHelp.GetListByPage((string)ht["TableName"], "", "", Convert.ToInt32(ht["StartIndex"].ToString()), Convert.ToInt32(ht["EndIndex"].ToString()), parms4org,out rowCount, IsPage);
                return dt;
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;                
                return null;
            }

        }
    }
}
