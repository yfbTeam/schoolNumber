using SMSIDAL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSDAL
{
    public partial class EnterpriseJobDal : HZ_BaseDal<EnterpriseJob>, IEnterpriseJobDal
    {
        #region 分页获取岗位信息重写
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
                    str.Append(" and Name=" + ht["Name"].SafeToString());
                }
                if (ht.ContainsKey("EnterID") && !string.IsNullOrEmpty(ht["EnterID"].SafeToString()))
                {
                    str.Append(" and EnterID=" + ht["EnterID"].SafeToString());
                }
                if (ht.ContainsKey("IsDelete") && !string.IsNullOrEmpty(ht["IsDelete"].SafeToString()))
                {
                    str.Append(" and IsDelete=" + ht["IsDelete"].SafeToString());
                }
                if (ht.ContainsKey("CreateDate") && !string.IsNullOrEmpty(ht["CreateDate"].SafeToString()))
                {
                    str.Append(ht["CreateDate"].SafeToString());
                }
                if (ht.ContainsKey("keyWord") && !string.IsNullOrEmpty(ht["keyWord"].SafeToString()))
                {
                    str.Append(ht["keyWord"].SafeToString());
                }
                if (ht.ContainsKey("CatagoryID") && !string.IsNullOrEmpty(ht["CatagoryID"].SafeToString()))
                {
                    str.Append(" and CatagoryID='" + ht["CatagoryID"].SafeToString() + "'");
                }
                if (ht.ContainsKey("inIDs") && !string.IsNullOrWhiteSpace(ht["inIDs"].SafeToString()))
                {
                    str.Append(" and ID in (" + ht["inIDs"].SafeToString() + ")");
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

        public int MoreEditCourseForJob(Hashtable ht)
        {

            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                if (ht.ContainsKey("Operation") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["Operation"])))
                {
                    string[] strList = ht["CourseIds"].ToString().Split(',');
                    if (ht["Operation"].ToString() == "add")
                    {
                        sbSql4org.Append(" insert into JobClass(JobID,CourseID)");
                        for (int i = 0; i < strList.Length; i++)
                        {
                            if (i + 1 == strList.Length)
                                sbSql4org.Append(" select @JobID" + i + ",@CourseID" + i);
                            else
                                sbSql4org.Append(" select @JobID" + i + ",@CourseID" + i + " union all");
                            List.Add(new SqlParameter("@JobID" + i, ht["JobID"].ToString()));
                            List.Add(new SqlParameter("@CourseID" + i, strList[i]));
                        }
                    }
                    else if (ht["Operation"].ToString() == "del")
                    {
                        sbSql4org.Append(" delete from JobClass where ");
                        for (int i = 0; i < strList.Length; i++)
                        {
                            if (i == 0)
                                sbSql4org.Append(" (JobID=@JobID" + i + " and CourseID=@CourseID" + i + ")");
                            else
                                sbSql4org.Append(" or (CourseID=@CourseID" + i + " and JobID=@JobID" + i + ")");
                            List.Add(new SqlParameter("@JobID" + i, ht["JobID"].ToString()));
                            List.Add(new SqlParameter("@CourseID" + i, strList[i]));
                        }
                    }
                }
                int number = SQLHelp.ExecuteNonQuery(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return number;

            }
            catch (Exception ex)
            {
                return -1;
            }
        }

        #endregion
    }
}
