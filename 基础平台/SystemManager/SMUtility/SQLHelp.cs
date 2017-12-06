using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace SMUtility

{
    public static class SQLHelp
    {
        private static readonly string conStr = ConfigurationManager.ConnectionStrings["connStr"].ConnectionString;

        #region 返回执行增加、删除、修改操作后造成影响的行数
        /// <summary>
        /// 返回执行增加、删除、修改操作后造成影响的行数
        /// </summary>
        /// <param name="sql">要执行的Sql语句</param>
        /// <param name="cmdType">要执行的命令类型</param>
        /// <param name="pms">传入的参数</param>
        /// <returns></returns>
        public static int ExecuteNonQuery(string sql, CommandType cmdType, params SqlParameter[] pms)
        {
            int count = 0;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    PrepareCommand(cmd, con, null, cmdType, pms);
                    count= cmd.ExecuteNonQuery();
                    cmd.Parameters.Clear();
                }
            }
            return count;
        }
        #endregion
        #region 在事务中执行，返回执行增加、删除、修改操作后造成影响的行数
        /// <summary>
        /// 在事务中执行，返回执行增加、删除、修改操作后造成影响的行数
        /// </summary>
        /// <param name="sql">要执行的Sql语句</param>
        /// <param name="cmdType">要执行的命令类型</param>
        /// <param name="pms">传入的参数</param>
        /// <returns></returns>
        public static int ExecuteNonQuery(SqlTransaction trans, string sql, CommandType cmdType, params SqlParameter[] pms)
        {
            int count = 0;
            SqlCommand cmd = new SqlCommand(sql, trans.Connection);
            PrepareCommand(cmd, trans.Connection, trans, cmdType, pms);
            count=cmd.ExecuteNonQuery();
            cmd.Parameters.Clear();
            return count;
        }
        #endregion

        #region 返回数据库查询结果首行首列的值
        /// <summary>
        /// 返回数据库查询结果首行首列的值
        /// </summary>
        /// <param name="sql">要执行的Sql语句</param>
        /// <param name="cmdType">要执行的命令类型</param>
        /// <param name="pms">传入的参数</param>
        /// <returns></returns>
        public static object ExecuteScalar(string sql, CommandType cmdType, params SqlParameter[] pms)
        {
            object obj = null;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {                    
                    PrepareCommand(cmd, con, null, cmdType, pms);
                    obj= cmd.ExecuteScalar();
                    cmd.Parameters.Clear();
                }
            }
            return obj;
        }
        #endregion
        #region 在事务中执行，返回数据库查询结果首行首列的值
        /// <summary>
        /// 在事务中执行，返回数据库查询结果首行首列的值
        /// </summary>
        /// <param name="sql">要执行的Sql语句</param>
        /// <param name="cmdType">null</param>
        /// <param name="pms">传入的参数</param>
        /// <returns></returns>
        public static object ExecuteScalar(SqlTransaction trans, string sql, CommandType cmdType, params SqlParameter[] pms)
        {
            object obj = null;
            SqlCommand cmd = new SqlCommand(sql, trans.Connection);
            PrepareCommand(cmd, trans.Connection, trans, cmdType, pms);
            obj= cmd.ExecuteScalar();
            cmd.Parameters.Clear();
            return obj;
        }
        #endregion

        #region 返回SqlDataReader对象
        /// <summary>
        /// 返回SqlDataReader对象
        /// </summary>
        /// <param name="sql">要执行的Sql语句</param>
        /// <param name="cmdType">要执行的命令类型</param>
        /// <param name="pms">传入的参数</param>
        /// <returns></returns>
        public static SqlDataReader ExecuteReader(string sql, CommandType cmdType, params SqlParameter[] pms)
        {
            SqlConnection con = new SqlConnection(conStr);
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                try
                {
                    PrepareCommand(cmd, con, null, cmdType, pms);
                    return cmd.ExecuteReader(CommandBehavior.CloseConnection);
                }
                catch (Exception)
                {
                    con.Close();
                    con.Dispose();
                    throw;
                }
            }
        }
        #endregion
        #region 在事务中执行，返回SqlDataReader对象
        /// <summary>
        /// 在事务中执行，返回SqlDataReader对象
        /// </summary>
        /// <param name="sql">要执行的Sql语句</param>
        /// <param name="cmdType">要执行的命令类型</param>
        /// <param name="pms">传入的参数</param>
        /// <returns></returns>
        public static SqlDataReader ExecuteReader(SqlTransaction trans, string sql, CommandType cmdType, params SqlParameter[] pms)
        {
            SqlCommand cmd = new SqlCommand(sql, trans.Connection);
            PrepareCommand(cmd, trans.Connection, trans, cmdType, pms);
            SqlDataReader rdr = cmd.ExecuteReader();
            return rdr;
        }
        #endregion

        #region 封装一个返回DataTable对象的方法
        /// <summary>
        /// 封装一个返回DataTable对象的方法
        /// </summary>
        /// <param name="sql">要执行的Sql语句</param>
        /// <param name="cmdType">要执行的命令类型</param>
        /// <param name="pms">传入的参数</param>
        /// <returns></returns>
        public static DataTable ExecuteDataTable(string sql, CommandType cmdType, params SqlParameter[] pms)
        {
            DataSet ds = new DataSet();
            using (SqlDataAdapter adapter = new SqlDataAdapter(sql, conStr))
            {
                adapter.SelectCommand.CommandType = cmdType;
                if (pms != null)
                {
                    adapter.SelectCommand.Parameters.AddRange(pms);
                }
                adapter.Fill(ds, "data");
            }
            return ds.Tables[0];
        }
        #endregion
        #region 在事务中执行，封装一个返回DataTable对象的方法
        public static DataTable ExecuteDataTable(SqlTransaction trans, string sql, CommandType cmdType, params SqlParameter[] pms)
        {
            DataSet ds = new DataSet();
            SqlCommand cmd = new SqlCommand(sql, trans.Connection);
            PrepareCommand(cmd, trans.Connection, trans, cmdType, pms);
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            adapter.Fill(ds, "data");
            return ds.Tables[0];
        }
        #endregion

        #region 开启事务
        public static SqlTransaction BeginTransaction()
        {
            SqlConnection myConnection = new SqlConnection(conStr);
            myConnection.Open();
            SqlTransaction tran = myConnection.BeginTransaction();
            return tran;
        }
        #endregion

        #region 生成要执行的命令
        /// <summary>
        /// 生成要执行的命令
        /// </summary>
        private static void PrepareCommand(SqlCommand cmd, SqlConnection conn, SqlTransaction trans, CommandType cmdType,SqlParameter[] pms)
        {
            if (conn.State != ConnectionState.Open)
                conn.Open();
            if (trans != null)
                cmd.Transaction = trans;
            cmd.CommandType = cmdType;
            if (pms != null)
            {
                cmd.Parameters.AddRange(pms);
            }
        }
        #endregion

        #region 分页查询
        /// <summary>
        /// 分页查询
        /// </summary>
        /// <param name="pageIndex">当前查询页</param>
        /// <param name="pagesize">每页记录集数量</param>
        /// <param name="fdname">用于定位记录的主键(惟一键)字段,可以是逗号分隔的多个字段</param>
        /// <param name="filedName">以逗号分隔的要显示的字段列表,如果不指定,则显示所有字段</param>
        /// <param name="TableName">查询表名</param>
        /// <param name="WhereStr">条件语句(可为空)</param>
        /// <param name="OrderByStr">以逗号分隔的排序字段列表,可以指定在字段后面指定DESC/ASC用于指定排序顺序(可为空)</param>
        /// <param name="pageCount">输出总页数</param>
        /// <param name="recordcount">记录集总数</param>
        /// <returns></returns>
        public static DataTable pageSearch(int pageIndex, int pagesize, string fdname, string filedName, string TableName, string WhereStr, string OrderByStr, out int pageCount, out int recordcount)
        {
            DataSet dbs = new DataSet();
            using (SqlConnection SqlConn = new SqlConnection(conStr))
            {
                if (SqlConn.State != ConnectionState.Open) { SqlConn.Open(); }
                if (pageIndex <= 0)
                {
                    pageIndex = 1;
                }
                using (SqlCommand command = new SqlCommand("proc_ShowPages", SqlConn))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@PageSize", SqlDbType.Int));
                    command.Parameters.Add(new SqlParameter("@PageIndex", SqlDbType.Int));
                    command.Parameters.Add(new SqlParameter("@FieldKey", SqlDbType.VarChar, 8000));
                    command.Parameters.Add(new SqlParameter("@FieldShow", SqlDbType.VarChar, 8000));
                    command.Parameters.Add(new SqlParameter("@TableName", SqlDbType.VarChar, 8000));
                    if (!string.IsNullOrEmpty(WhereStr)) {
                        command.Parameters.Add(new SqlParameter("@Where", SqlDbType.VarChar, 8000));
                    } if (!string.IsNullOrEmpty(OrderByStr))
                    {
                        command.Parameters.Add(new SqlParameter("@FieldOrder", SqlDbType.VarChar, 8000));
                    }
                    command.Parameters.Add(new SqlParameter("@TotalCount", SqlDbType.Int));
                    command.Parameters.Add(new SqlParameter("@TotalPageCount", SqlDbType.Int));
                    command.UpdatedRowSource = UpdateRowSource.None;
                    command.Parameters["@PageSize"].Value = pagesize;
                    command.Parameters["@PageIndex"].Value = pageIndex;
                    command.Parameters["@FieldKey"].Value = fdname;
                    command.Parameters["@FieldShow"].Value = filedName;
                    command.Parameters["@TableName"].Value = TableName;
                    if (!string.IsNullOrEmpty(WhereStr))
                    {
                        command.Parameters["@Where"].Value = WhereStr;
                    } if (!string.IsNullOrEmpty(OrderByStr))
                    {
                        command.Parameters["@FieldOrder"].Value = OrderByStr;
                    }
                    command.Parameters["@TotalCount"].Direction = ParameterDirection.Output;
                    command.Parameters["@TotalPageCount"].Direction = ParameterDirection.Output;
                    SqlDataAdapter sda = new SqlDataAdapter();
                    sda.SelectCommand = command;
                    sda.SelectCommand.ExecuteNonQuery();
                    recordcount = int.Parse(sda.SelectCommand.Parameters["@TotalCount"].Value.ToString());
                    pageCount = int.Parse(sda.SelectCommand.Parameters["@TotalPageCount"].Value.ToString());
                    sda.Fill(dbs, "data");

                }
            }
            return dbs.Tables[0];
        }

       #endregion
        #region 分页
        /// <summary>
        /// 获取记录总数
        /// </summary>
        /// <param name="strWhere">条件</param>
        /// <returns>记录总数</returns>
        public static int GetRecordCount(string TableName, string strWhere, SqlParameter[] parms4org)
        {
            StringBuilder sbSql = new StringBuilder();
            sbSql.Append("select count(1) FROM " + TableName +" T");
            if (strWhere.Trim() != "")
            {
                sbSql.Append(" where 1=1" + strWhere);
            }

            object obj = ExecuteScalar(sbSql.ToString(), CommandType.Text, parms4org);

            if (obj == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(obj);
            }
        }

        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        /// <param name="strWhere">条件</param>
        /// <param name="orderby">排序</param>
        /// <param name="startIndex">起始行数</param>
        /// <param name="endIndex">结束行数</param>
        /// <returns>DataSet</returns>
        public static DataTable GetListByPage(string TableName, string strWhere, string orderby, int startIndex, int endIndex, SqlParameter[] parms4org,out int rowCount, bool IsPage)
        {
            StringBuilder sbSql = new StringBuilder();
            sbSql.Append("SELECT * FROM ( ");
            sbSql.Append(" SELECT ROW_NUMBER() OVER (");
            if (!string.IsNullOrEmpty(orderby.Trim()))
            {
                sbSql.Append("order by T." + orderby);
            }
            else
            {
                sbSql.Append("order by T.ID desc");
            }
            sbSql.Append(")AS rowNum, T.*  from " + TableName + " T ");
            if (!string.IsNullOrEmpty(strWhere.Trim()))
            {
                sbSql.Append(" WHERE 1=1 " + strWhere);
            }
            sbSql.Append(" ) TT");
            if (IsPage)
            {
                sbSql.AppendFormat(" WHERE TT.rowNum between {0} and {1}", startIndex, endIndex);

            }
            rowCount = GetRecordCount(TableName, strWhere, parms4org);
            return ExecuteDataTable(sbSql.ToString(), CommandType.Text, parms4org);
        }
        #endregion
    }
}
