using SMSIDAL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace SMSDAL
{
    public class HZ_BaseDal<T> where T : class , new()
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
                if (ty.GetProperties()[i].Name.ToUpper() != "ID" && pros[i].GetValue(entity, null) != null)
                {
                    strFirst.Append(pros[i].Name + ",");
                    strSecond.Append("@" + pros[i].Name + ",");
                    SqlParameter para = new SqlParameter("@" + pros[i].Name, pros[i].GetValue(entity, null));
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
                if (ty.GetProperties()[i].Name.ToUpper() != "ID" && pros[i].GetValue(entity, null) != null)
                {
                    strFirst.Append(pros[i].Name + "=@" + pros[i].Name + ",");
                }

                if (pros[i].GetValue(entity, null) != null)
                {
                    SqlParameter para = new SqlParameter("@" + pros[i].Name, pros[i].GetValue(entity, null));
                pms.Add(para);
                }


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

        public virtual bool GetInfoById(T entity, int id)
        {
            string sql = "select * from " + entity + "where ID=" + id;
            return SQLHelp.ExecuteNonQuery(sql, System.Data.CommandType.Text, null) > 0;
        }
        /// <summary>
        /// 添加单条数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual int Add(T entity)
        {
            string sql = string.Empty;
            List<SqlParameter> pms = DalAddHelp(entity, out sql);
            return Convert.ToInt32(SQLHelp.ExecuteScalar(sql, System.Data.CommandType.Text, pms.ToArray()));

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
                return SQLHelp.ExecuteNonQuery(sql, System.Data.CommandType.Text, pms.ToArray()) > 0;
            else
                return SQLHelp.ExecuteNonQuery(trans, System.Data.CommandType.Text, sql, pms.ToArray()) > 0;
        }

        /// <summary>
        /// 根据Id获取单条数据
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public virtual T GetEntityById(T entity, int id)
        {
            try
            {
                string sql = string.Format("select * from {0} where Id=@id", entity.GetType().Name);
                SqlParameter pms = new SqlParameter("@id", id);
                SqlDataReader reader = SQLHelp.ExecuteReader(sql, CommandType.Text, pms);
                if (reader.HasRows)
                {
                    PropertyInfo[] pros = entity.GetType().GetProperties();
                    while (reader.Read())
                    {

                        foreach (PropertyInfo item in pros)
                        {
                            item.SetValue(entity, reader.IsDBNull(reader.GetOrdinal(item.Name)) ? null : reader[item.Name]);
                        }
                    }
                }
                else { entity = null; }
                return entity;
            }
            catch (Exception ex)
            {
                return null;
            }

        }

        public virtual List<T> GetEntityListByField(T entity, string filed, string value)
        {
            List<T> tlist = new List<T>();
            string sql = string.Format("select * from {0} where {1}=@id", entity.GetType().Name, filed);
            SqlParameter pms = new SqlParameter("@id", value);
            SqlDataReader reader = SQLHelp.ExecuteReader(sql, CommandType.Text, pms);
            if (reader.HasRows)
            {
                PropertyInfo[] pros = entity.GetType().GetProperties();
                while (reader.Read())
                {
                T newentity = new T();
                    foreach (PropertyInfo item in pros)
                    {
                        if(string.IsNullOrEmpty(reader[item.Name].SafeToString()))
                        {
                           // item.SetValue(newentity, "");

                        }
                        else { 
                        item.SetValue(newentity, reader[item.Name]);
                        }
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
        public virtual bool DeleteFalse(T entity, int id)
        {
            return false;
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


        /// <summary>
        /// 删除单条数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public virtual bool Delete(T entity, int id)
        {
            string sql = string.Format("delete from {0} where id=@Id", entity.GetType().Name);
            SqlParameter pms = new SqlParameter("@Id", id);
            return SQLHelp.ExecuteNonQuery(sql, CommandType.Text, pms) > 0;

        }

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



        /// <summary>
        /// 根据条件获取所有数据
        /// </summary>
        /// <param name="entity">实体类</param>
        /// <param name="where">条件（例如：id>1）</param>
        /// <param name="order">排序（例如：createtime desc）</param>
        /// <returns></returns>
        public virtual DataTable GetData(T entity, string where, string order)
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
            DataTable dt = SQLHelp.ExecuteDataTable(sql, CommandType.Text, null);
            return dt;
        }
        /*
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
        }*/

        /// <summary>
        /// 分页查询根据条件
        /// </summary>
        /// <param name="ht">查询条件</param>
        /// <returns>Model的List集合</returns>
        /*public virtual DataTable GetPage(string TableName, string strWhere, string orderby, int startIndex, int endIndex, bool IsPage, SqlParameter[] parms4org)
        {
            try
            {
                DataTable dt = SQLHelp.GetListByPage(TableName, strWhere, orderby, startIndex, endIndex, IsPage, parms4org);

                int RowCount = GetRecordCount(TableName, strWhere, parms4org);
                return dt;
            }
            catch (Exception)
            {
                //写入日志
                //throw;
                return null;
            }
        }
        public virtual int GetRecordCount(string TableName,  SqlParameter[] parms4org,string strWhere="", bool IsPage=true)
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

        }*/
        public virtual DataTable GetListByPage(Hashtable ht, out int RowCount,bool IsPage = true, string Where = "")// string TableName, string strWhere, string orderby, int startIndex, int endIndex, SqlParameter[] parms4org)
        {
            RowCount = 0;
            SqlParameter[] parms4org = { };
            int StartIndex = 0;
            int EndIndex = 0;
            if (IsPage)
            {
                StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
            }
            try
            {
                string order="";
                if (ht.ContainsKey("Order") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["Order"]))) order = ht["Order"].ToString();
                DataTable dt = SQLHelp.GetListByPage((string)ht["TableName"], Where, order, StartIndex, EndIndex, IsPage, parms4org, out RowCount);

                //DataTable dt = SQLHelp.GetListByPage(ht, parms4org);
                return dt;
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }

        }
        // string TableName, string strWhere, string orderby, int startIndex, int endIndex, SqlParameter[] parms4org)

      /*
        public virtual JsonModel GetListByPage(Hashtable ht, SqlParameter[] parms4org, string Where="", bool IsPage = true)// string TableName, string strWhere, string orderby, int startIndex, int endIndex, SqlParameter[] parms4org)
        {
            int StartIndex = 0;
            int EndIndex = 0;
            if (IsPage)
            {
                StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
            }

            BLLCommon common = new BLLCommon();
            try
            {
                int PageIndex = 0;
                int PageSize = 0;
                if (IsPage)
                {
                    //增加起始条数、结束条数
                    ht = common.AddStartEndIndex(ht);
                    PageIndex = Convert.ToInt32(ht["PageIndex"]);
                    PageSize = Convert.ToInt32(ht["PageSize"]);
                }

                DataTable modList = SQLHelp.GetListByPage((string)ht["TableName"], Where, "", StartIndex, EndIndex, IsPage, parms4org);

                //定义分页数据实体
                PagedDataModel<Dictionary<string, object>> pagedDataModel = null;
                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                if (modList.Rows.Count <= 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                    return jsonModel;
                }
                List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
                list = common.DataTableToList(modList);

                if (IsPage)
                {
                    //总条数
                    int RowCount = modList.Rows.Count;// CurrentDal.GetRecordCount(ht, null);

                    //总页数
                    int PageCount = (int)Math.Ceiling(RowCount * 1.0 / PageSize);
                    //将数据封装到PagedDataModel分页数据实体中
                    pagedDataModel = new PagedDataModel<Dictionary<string, object>>()
                    {
                        PageCount = PageCount,
                        PagedData = list,
                        PageIndex = PageIndex,
                        PageSize = PageSize,
                        RowCount = RowCount
                    };
                    //将分页数据实体封装到JSON标准实体中
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = pagedDataModel
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = list
                    };
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        public virtual JsonModel GetListByPage(Hashtable ht, string Where, string FiledName, bool IsPage)// string TableName, string strWhere, string orderby, int startIndex, int endIndex, SqlParameter[] parms4org)
        {
            SqlParameter[] parms4org = { };
            int StartIndex = 0;
            int EndIndex = 0;
            if (IsPage)
            {
                StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
            }

            BLLCommon common = new BLLCommon();
            try
            {
                int PageIndex = 0;
                int PageSize = 0;
                if (IsPage)
                {
                    //增加起始条数、结束条数
                    ht = common.AddStartEndIndex(ht);
                    PageIndex = Convert.ToInt32(ht["PageIndex"]);
                    PageSize = Convert.ToInt32(ht["PageSize"]);
                }
                bool isfiled = false;
                if (!string.IsNullOrEmpty(ht["FiledName"].SafeToString()))
                {
                    isfiled = true;
                }
                DataTable modList = SQLHelp.GetListByPage((string)ht["TableName"], Where, ht["OrderBy"].SafeToString(), StartIndex, EndIndex, IsPage, parms4org, FiledName);


                //定义分页数据实体
                PagedDataModel<string> pagedDataModel = null;
                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                if (modList.Rows.Count <= 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                    return jsonModel;
                }
                if (IsPage)
                {
                    List<string> list = new List<string>();
                    list.Add(common.DataTableToJson(modList));
                    //总条数
                    int RowCount = modList.Rows.Count;// CurrentDal.GetRecordCount(ht, null);

                    //总页数
                    int PageCount = (int)Math.Ceiling(RowCount * 1.0 / PageSize);
                    //将数据封装到PagedDataModel分页数据实体中
                    pagedDataModel = new PagedDataModel<string>()
                    {
                        PageCount = PageCount,
                        PagedData = list,
                        PageIndex = PageIndex,
                        PageSize = PageSize,
                        RowCount = RowCount
                    };
                    //将分页数据实体封装到JSON标准实体中
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = pagedDataModel
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = common.DataTableToJson(modList)
                    };
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }
        public virtual JsonModel GetListByPage(Hashtable ht, string Where, string FiledName, string orderby, bool IsPage)// string TableName, string strWhere, string orderby, int startIndex, int endIndex, SqlParameter[] parms4org)
        {
            SqlParameter[] parms4org = { };
            int StartIndex = 0;
            int EndIndex = 0;
            if (IsPage)
            {
                StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
            }

            BLLCommon common = new BLLCommon();
            try
            {
                int PageIndex = 0;
                int PageSize = 0;
                if (IsPage)
                {
                    //增加起始条数、结束条数
                    ht = common.AddStartEndIndex(ht);
                    PageIndex = Convert.ToInt32(ht["PageIndex"]);
                    PageSize = Convert.ToInt32(ht["PageSize"]);
                }
                bool isfiled = false;
                if (!string.IsNullOrEmpty(ht["FiledName"].SafeToString()))
                {
                    isfiled = true;
                }
                DataTable modList = SQLHelp.GetListByPage((string)ht["TableName"], Where, orderby, StartIndex, EndIndex, IsPage, parms4org, FiledName);


                //定义分页数据实体
                PagedDataModel<string> pagedDataModel = null;
                //定义JSON标准格式实体中
                JsonModel jsonModel = null;
                if (modList.Rows.Count <= 0)
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 999,
                        errMsg = "无数据",
                        retData = ""
                    };
                    return jsonModel;
                }
                if (IsPage)
                {
                    List<string> list = new List<string>();
                    list.Add(common.DataTableToJson(modList));
                    //总条数
                    int RowCount = modList.Rows.Count;// CurrentDal.GetRecordCount(ht, null);

                    //总页数
                    int PageCount = (int)Math.Ceiling(RowCount * 1.0 / PageSize);
                    //将数据封装到PagedDataModel分页数据实体中
                    pagedDataModel = new PagedDataModel<string>()
                    {
                        PageCount = PageCount,
                        PagedData = list,
                        PageIndex = PageIndex,
                        PageSize = PageSize,
                        RowCount = RowCount
                    };
                    //将分页数据实体封装到JSON标准实体中
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = pagedDataModel
                    };
                }
                else
                {
                    jsonModel = new JsonModel()
                    {
                        errNum = 0,
                        errMsg = "success",
                        retData = common.DataTableToJson(modList)
                    };
                }
                return jsonModel;
            }
            catch (Exception ex)
            {
                JsonModel jsonModel = new JsonModel()
                {
                    errNum = 400,
                    errMsg = ex.Message,
                    retData = ""
                };
                return jsonModel;
            }
        }*/
      
    }
}
