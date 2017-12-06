using SMSIDAL;
using SMSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SMSUtility;
using System.Data.SqlClient;

namespace SMSDAL
{
    public partial class EnterpriseDal : HZ_BaseDal<Enterprise>, IEnterpriseDal
    {
        #region 分页获取企业信息重写
        /// <summary>
        /// 分页获取企业信息重写
        /// </summary>
        /// <param name="ht"></param>
        /// <param name="IsPage"></param>
        /// <param name="where"></param>
        /// <returns></returns>
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            RowCount = 0;
            DataTable dt = new DataTable();
            try
            {
                string TableName = ht["TableName"].SafeToString();
                StringBuilder str = new StringBuilder();
                //                str.Append(@"select a.*,cast(CoursePrice as decimal(12,0)) as Price,case a.EvalueTimes when 0 then 0 else CourseEvalue/EvalueTimes end as Evalue,
                //                               (select count(1) from Topic tpc where tpc.IsDelete=0 and tpc.Type=0 and tpc.CouseID=a.ID) as TopicCount
                //                                from Course a where 1=1");

                int StartIndex = 0;
                int EndIndex = 0;
                //string Where = "";
                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    str.Append(" and ID = " + ht["ID"].SafeToString());
                }
                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].SafeToString()))
                {
                    str.Append(" and Name like '%" + ht["Name"].SafeToString() + "%'");
                }

                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                dt = SQLHelp.GetListByPage(TableName, str.ToString(), "", StartIndex, EndIndex, IsPage, null, out RowCount);
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
        #endregion
        #region 删除企业信息
        /// <summary>
        /// 删除企业信息
        /// </summary>
        /// <param name="Enid"></param>
        /// <returns></returns>
        public string DelEnterprise(int Enid)
        {
            string result = "";
            SqlParameter[] param = { 
                                       new SqlParameter("@Enid",Enid)                                      
                                   };
            object obj = SQLHelp.ExecuteScalar("DelEnterprise", CommandType.StoredProcedure, param);
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;
        }
        #endregion
        #region 企业岗位树形列表
        StringBuilder sbjson = new StringBuilder();
        /// <summary>
        /// 文件夹根节点
        /// </summary>
        /// <param name="pid"></param>

        public string BindtvNodes()
        {
            string strsql = "select * from Enterprise";
            DataTable En = SQLHelp.ExecuteDataTable(strsql, CommandType.Text, null);
            foreach (DataRow dr in En.Rows)
            {
                string name = dr["Name"].ToString();

                sbjson.Append("{\"id\": " + dr["ID"] + ",\"root\":\"" + dr["ID"] + "\", \"pId\": 0, \"name\":\"" + name + "\", \"type\":\"1\"},");

                AddtvChildNodes(int.Parse(dr["ID"].SafeToString()));
            }
            return sbjson.SafeToString();
        }
        /// <summary>
        /// 树形目录子节点
        /// </summary>
        /// <param name="t"></param>
        private void AddtvChildNodes(int EnterID)
        {
            string strsql = "select * from EnterpriseJob where EnterID=" + EnterID;
            DataTable job = SQLHelp.ExecuteDataTable(strsql, CommandType.Text, null);
            foreach (DataRow dr in job.Rows)
            {
                string name = dr["Name"].ToString();

                sbjson.Append("{\"id\":" + EnterID + "" + dr["ID"] + ",\"root\": \"" + dr["ID"] + "\", \"pId\": " + EnterID + ", \"name\":\"" + name + "\", \"type\":\"2\"},");
            }
        }
        #endregion

        #region 分页获取岗位问答信息
        /// <summary>
        /// 分页获取岗位问答信息
        /// </summary>
        /// <param name="ht"></param>
        /// <param name="IsPage"></param>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable GetJobLibrary(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            RowCount = 0;
            DataTable dt = new DataTable();
            try
            {
                StringBuilder str = new StringBuilder();
                //str.Append(@"select b.ID,a.Contents as ask,b.contents as anwer,a.CreateTime as StartTime,b.CreateTime as EndTime,b.CreateUID,c.Name  from JobTopic a,JobTopic_Comment b,EnterpriseJob c where b.topicid=a.id and c.ID=a.JobID");
                str.Append(@"select b.ID,a.Contents as ask,b.contents as anwer,a.CreateTime as StartTime,b.CreateTime as EndTime,b.CreateUID,c.Name  from JobTopic a inner join EnterpriseJob c on c.ID=a.JobID  left join JobTopic_Comment b on b.topicid=a.id where 1=1 ");
                int StartIndex = 0;
                int EndIndex = 0;
                string Type = ht["Type"].SafeToString();
                if (Type == "1")
                {
                    str.Append(" and a.EnID=" + ht["ID"].SafeToString());
                }
                if (Type == "2")
                {
                    str.Append(" and a.JobID=" + ht["ID"].SafeToString());
                }

                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                dt = SQLHelp.GetListByPage("(" + str.ToString() + ")", "", "", StartIndex, EndIndex, IsPage, null, out RowCount);
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
        #endregion
        #region 推荐工作
        /// <summary>
        /// 推荐工作
        /// </summary>
        /// <param name="ht"></param>
        /// <param name="RowCount"></param>
        /// <param name="IsPage"></param>
        /// <param name="where"></param>
        /// <returns></returns>
        public DataTable GetJob(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            RowCount = 0;
            DataTable dt = new DataTable();
            try
            {
                StringBuilder str = new StringBuilder();
                str.Append(@"select b.ID,b.Name as JobName,a.Name as EnName,b.CreateTime,MajorIDs,CourseIDs from Enterprise a,EnterpriseJob b where b.EnterID=a.ID");

                int StartIndex = 0;
                int EndIndex = 0;
                //string Where = "";
                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    str.Append(" and ID = " + ht["ID"].SafeToString());
                }
                if (ht.ContainsKey("JobName") && !string.IsNullOrEmpty(ht["JobName"].SafeToString()))
                {
                    str.Append(" and b.Name like '%" + ht["JobName"].SafeToString() + "%'");
                }
                string Type = ht["Sort"].SafeToString();
                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                if (Type == "1")
                {
                    str.Append(" and b.ID in(select JobID from JobClass where id in (select id from course where courceType=2 and id in (select Courseid from [dbo].[ClassCourse] where classid=" +
                        ht["ClassID"].SafeToString() + ") " +
                        "union select courseid from Couse_Selstuinfo where StuNo='" + ht["StuNo"].SafeToString() + "'))");
                }
                dt = SQLHelp.GetListByPage("(" + str.ToString() + ")", "", "", StartIndex, EndIndex, IsPage, null, out RowCount);
                //dt.Columns.Add("isTrue", typeof(int));
                //int isTrue = 0;
                //foreach (DataRow dr in dt.Rows)
                //{
                //    string CourseIDs = dr["CourseIDs"].SafeToString();
                //    if (CourseIDs.Length > 0)
                //    {
                //        string strsql2 = "select * from (select id from course where courceType=2 and id in (select Courseid from [dbo].[ClassCourse] where classid=1) union " +
                //            "select courseid from Couse_Selstuinfo where StuNo='230704199010271013') a where " + dr["CourseIDs"] + " like '%'+cast(id as varchar(20))+'%'";
                //        object result = SQLHelp.ExecuteScalar(strsql2, CommandType.Text, null);
                //        if (result.SafeToString().Length>0)
                //        {
                //            isTrue = 1;
                //        }
                //        else
                //        {
                //            if (sort=="1")
                //            {
                //                dt.Rows.Remove(dr);
                //            }
                //            isTrue = 0;
                //        }
                //    }
                //    dr["isTrue"] = isTrue;
                //}
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
        #endregion

        public string AddJob(EnterpriseJob job)
        {
            SqlParameter[] param = { 
                                       new SqlParameter("@Name",job.Name),
                                       new SqlParameter("@EnterID", job.EnterID),
                                       new SqlParameter("@MajorIDs",job.MajorIDs),
                                       new SqlParameter("@CourseIDs", job.CourseIDs),
                                       new SqlParameter("@Introduction",job.Introduction),
                                       new SqlParameter("@CreateUID",job.CreateUID)
                                   };
            object obj = SQLHelp.ExecuteScalar("AddJob", CommandType.StoredProcedure, param);
            string result = "添加成功";
            if (obj.ToString().Length > 0)
            {
                result = obj.ToString();
            }
            return result;

        }
    }
}
