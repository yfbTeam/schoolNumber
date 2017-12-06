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
    public partial class Course_WorkCorrectRelDal : HZ_BaseDal<Course_WorkCorrectRel>, ICourse_WorkCorrectRelDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage = true, string Where = "")
        {
            RowCount = 0;
            List<SqlParameter> pms = new List<SqlParameter>();
            int StartIndex = 0;
            int EndIndex = 0;
            if (IsPage)
            {
                StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
            }
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select rel.*,work.Name as WorkName,convert(varchar(10),work.EndTime,21) as EndTime_Format
                  ,case rel.ScoreStatus when 1 then '优' when 2 then '良' when 3 then '中' when 4 then '差' end as StoreLevel
                                   ,work.CouseID,co.Name as CouseName ");
                sbSql4org.Append(" from Course_WorkCorrectRel rel  ");
                sbSql4org.Append(@" left join Course_Work work on work.Id=rel.WorkId and work.IsDelete=0
                                    left join Course co on co.ID=work.CouseID ");
                sbSql4org.Append(" where 1=1 ");
                if (ht.ContainsKey("CouseID") && !string.IsNullOrEmpty(ht["CouseID"].ToString()))
                {
                    sbSql4org.Append(" and work.CouseID=@CouseID ");
                    pms.Add(new SqlParameter("@CouseID", ht["CouseID"].ToString()));
                }
                if (ht.ContainsKey("WorkId") && !string.IsNullOrEmpty(ht["WorkId"].ToString()))
                {
                    sbSql4org.Append(" and work.Id=@WorkId ");
                    pms.Add(new SqlParameter("@WorkId", ht["WorkId"].ToString()));
                }
                if (ht.ContainsKey("TerIDCard") && !string.IsNullOrEmpty(ht["TerIDCard"].ToString()))
                {
                    sbSql4org.Append(" and work.CreateUID=@TerIDCard ");
                    pms.Add(new SqlParameter("@TerIDCard", ht["TerIDCard"].ToString()));
                }
                if (ht.ContainsKey("StuIDCard") && !string.IsNullOrEmpty(ht["StuIDCard"].ToString()))
                {
                    sbSql4org.Append(" and rel.CreateUID=@StuIDCard ");
                    pms.Add(new SqlParameter("@StuIDCard", ht["StuIDCard"].ToString()));
                }
                if (ht.ContainsKey("CorrectStatus") && !string.IsNullOrEmpty(ht["CorrectStatus"].ToString()))
                {
                    sbSql4org.Append(" and rel.CorrectUID is " + ht["CorrectStatus"].ToString());
                }
                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].ToString()))
                {
                    sbSql4org.Append(" and work.Name like N'%' + @Name + '%' ");
                    pms.Add(new SqlParameter("@Name", ht["Name"].ToString()));
                }
                if (ht.ContainsKey("ChapterID") && !string.IsNullOrEmpty(ht["ChapterID"].SafeToString()))
                {
                    sbSql4org.Append(" and '|'+work.ChapterID+'|'  like N'|' + @ChapterID + '|%' ");
                    pms.Add(new SqlParameter("@ChapterID", ht["ChapterID"].ToString()));
                }
                if (ht.ContainsKey("PointID") && !string.IsNullOrEmpty(ht["PointID"].ToString()))
                {
                    sbSql4org.Append(" and work.PointID=@PointID ");
                    pms.Add(new SqlParameter("@PointID", ht["PointID"].ToString()));
                }
                return SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", Where, "", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }

        #region 上传作业
        public int AddWorkCorrectRel(Course_WorkCorrectRel entity, string classid)
        {
            int result = 0;
            SqlParameter[] param = {
                                       new SqlParameter("@WorkId", entity.WorkId),
                                       new SqlParameter("@Contents", entity.Contents),
                                       new SqlParameter("@Attachment", entity.Attachment),
                                       new SqlParameter("@CreateUID", entity.CreateUID),
                                       new SqlParameter("@ClassID",classid)
                                   };
            object obj = SQLHelp.ExecuteScalar("AddWorkCorrectRel", CommandType.StoredProcedure, param);
            result = Convert.ToInt32(obj);
            return result;
        }
        #endregion

        #region 根据作业id获取提交作业的学生
        public DataTable GetCorrectRelByWorkId(string workId)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            DataTable dt = new DataTable();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select CreateUID from Course_WorkCorrectRel where 1=1 ");
                if (!string.IsNullOrEmpty(workId))
                {
                    sbSql4org.Append(@" and WorkId=@WorkId ");
                    pms.Add(new SqlParameter("@WorkId", workId));
                }                
                dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
        #endregion
    }
}
