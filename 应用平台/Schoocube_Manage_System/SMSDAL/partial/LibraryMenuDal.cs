using SMSUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSDAL
{
    public partial class LibraryMenuDal
    {
        #region 知识库菜单
        StringBuilder sbjson = new StringBuilder();
        /// <summary>
        /// 文件夹根节点
        /// </summary>
        /// <param name="pid"></param>

        public string BindtvNodes()
        {
            string strsql = "select * from LibraryMenu where pid=0";
            DataTable En = SQLHelp.ExecuteDataTable(strsql, CommandType.Text, null);
            foreach (DataRow dr in En.Rows)
            {
                string name = dr["Name"].ToString();

                sbjson.Append("{\"id\": " + dr["ID"] + ",\"root\":\"" + dr["ID"] + "\", \"pId\": 0, \"name\":\"" + name + "\"},");

                AddtvChildNodes(int.Parse(dr["ID"].SafeToString()));
            }
            return sbjson.SafeToString();
        }
        /// <summary>
        /// 树形目录子节点
        /// </summary>
        /// <param name="t"></param>
        private void AddtvChildNodes(int Pid)
        {
            string strsql = "select * from LibraryMenu where pid=" + Pid;
            DataTable job = SQLHelp.ExecuteDataTable(strsql, CommandType.Text, null);
            foreach (DataRow dr in job.Rows)
            {
                string name = dr["Name"].ToString();

                sbjson.Append("{\"id\":" + dr["ID"] + ",\"root\": \"" + dr["ID"] + "\", \"pId\": " + Pid + ", \"name\":\"" + name + "\"},");
                AddtvChildNodes(int.Parse(dr["ID"].SafeToString()));
            }
        }
        #endregion
        #region  删除知识库导航信息
        /// <summary>
        /// 删除知识库导航信息
        /// </summary>
        /// <param name="MenuID"></param>
        /// <returns></returns>
        public string DelMenu(string MenuID)
        {
            SqlParameter[] parm = { 
                                  new SqlParameter("@MenuID",MenuID),                                
                                  };
            object obj = SQLHelp.ExecuteScalar("DelMenu", CommandType.StoredProcedure, parm);
            return obj.SafeToString();
        }
        #endregion
    }
}
