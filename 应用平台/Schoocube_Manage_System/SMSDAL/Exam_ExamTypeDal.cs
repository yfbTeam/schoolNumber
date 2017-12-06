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
    public partial class Exam_ExamTypeDal : HZ_BaseDal<Exam_ExamType>, IExam_ExamTypeDal
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
                sbSql4org.Append(@"select ID,Title,QType,
                                    case QType when 1 then '主观' when 2 then '客观 ' END as QTypeShow,Template,
                                    case Template when 1 then '单选' when 2 then '多选' when 3 then '判断' else '文本框' END as TemplateShow,
                                    Status,case Status when 1 then '启用' else '禁用' END as StatusShow
                                    from Exam_ExamType 
                                    where 1=1 ");
                if (ht.ContainsKey("Status") && !string.IsNullOrEmpty(ht["Status"].ToString()))
                {
                    sbSql4org.Append(" and  Status=@Status ");
                    pms.Add(new SqlParameter("@Status", ht["Status"].ToString()));
                }                
                if (ht.ContainsKey("Title") && !string.IsNullOrEmpty(ht["Title"].ToString()))
                {
                    sbSql4org.Append(" and Title like N'%' + @Title + '%' ");
                    pms.Add(new SqlParameter("@Title", ht["Title"].ToString()));
                }
                if (ht.ContainsKey("OptionType") && !string.IsNullOrEmpty(ht["OptionType"].ToString()))
                {
                    sbSql4org.Append(" and Title <> '判断题' ");
                }
                return SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", Where, "ID Asc", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }

        }
        public DataTable GetListrandom(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select et.ID from Exam_ExamType as et where 1=1");
                if (ht.ContainsKey("Title") && !string.IsNullOrEmpty(ht["Title"].SafeToString()))
                {
                    sbSql4org.Append(" and et.Title=@Title ");
                    pms.Add(new SqlParameter("@Title", ht["Title"].SafeToString()));
                }
                return SQLHelp.ExecuteDataTable( sbSql4org.ToString() , CommandType.Text, pms.ToArray());
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
