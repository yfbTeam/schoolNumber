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
    public partial class Exam_SubQuestionDal : HZ_BaseDal<Exam_SubQuestion>, IExam_SubQuestionDal
    {
        public override DataTable GetListByPage(Hashtable ht,out int RowCount, bool IsPage = true, string Where = "")
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
                sbSql4org.Append(@"select (select sum(1) from  Exam_SubQuestion where ID<=eq.ID)as Count,
                                     eq.ID,eq.Title,eq.Score,eq.Type as TypeID,
                                    eq.Content,eq.Answer,eq.Difficulty,eq.Klpoint,eq.Major,eq.Status,
                                    case eq.Status when 1 then '启用' else '禁用' END as StatusShow,
                                    case eq.Difficulty when 1 then '简单' when 2 then '中等' else '困难' end as DifficultyShow,
                                    eq.Author,convert(varchar(10),eq.CreateTime,21) as CreateTime,
                                    et.Title as [Type],et.QType,et.Template,
                                    eq.IsShowAnalysis,case eq.IsShowAnalysis when 1 then '显示' else '不显示' END as IsShowAnalysisShow
                                    from Exam_SubQuestion as eq
                                    left join Exam_ExamType et on et.ID=eq.Type
                                    where 1=1 and Style=0 ");
                if (ht.ContainsKey("Status") && !string.IsNullOrEmpty(ht["Status"].SafeToString()))
                {
                    sbSql4org.Append(" and  eq.Status=@Status ");
                    pms.Add(new SqlParameter("@Status", ht["Status"].SafeToString()));
                }
                if (ht.ContainsKey("MajorId") && !string.IsNullOrEmpty(ht["MajorId"].SafeToString()))
                {
                    sbSql4org.Append(" and eq.Major like  @MajorId ");
                    pms.Add(new SqlParameter("@MajorId", ht["MajorId"].SafeToString()));
                }
                if (ht.ContainsKey("KlpointID") && !string.IsNullOrEmpty(ht["KlpointID"].SafeToString()))
                {
                    sbSql4org.Append(" and eq.Klpoint=@KlpointID ");
                    pms.Add(new SqlParameter("@KlpointID", ht["KlpointID"].SafeToString()));
                }
                if (ht.ContainsKey("Type") && !string.IsNullOrEmpty(ht["Type"].SafeToString()))
                {
                    sbSql4org.Append(" and eq.Type=@Type ");
                    pms.Add(new SqlParameter("@Type", ht["Type"].SafeToString()));
                }
                if (ht.ContainsKey("Title") && !string.IsNullOrEmpty(ht["Title"].SafeToString()))
                {
                    sbSql4org.Append(" and eq.Title like N'%' + @Title + '%' ");
                    pms.Add(new SqlParameter("@Title", ht["Title"].SafeToString()));
                }
                if (ht.ContainsKey("Difficult") && !string.IsNullOrEmpty(ht["Difficult"].SafeToString()))
                {
                    sbSql4org.Append(" and eq.Difficulty=@Difficult ");
                    pms.Add(new SqlParameter("@Difficult", ht["Difficult"].SafeToString()));
                }
                if (ht.ContainsKey("Style") && !string.IsNullOrEmpty(ht["Style"].SafeToString()))
                {
                    sbSql4org.Append(" and eq.Style=@Style ");
                    pms.Add(new SqlParameter("@Style", ht["Style"].SafeToString()));
                }
                if (ht.ContainsKey("Questions") && !string.IsNullOrEmpty(ht["Questions"].SafeToString()))
                {
                    sbSql4org.Append(" and (eq.Questions=@Questions  or @Questions='0') ");
                    pms.Add(new SqlParameter("@Questions", ht["Questions"].SafeToString()));
                }
                return SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", Where, "", StartIndex, EndIndex, IsPage, pms.ToArray(),out RowCount);
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }

        }
        public DataTable GetList(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                    sbSql4org.Append(@"select COUNT(*) as sum,et.Title,sum(es.Score) as score from Exam_SubQuestion as es left join Exam_ExamType as et on es.Type=et.ID where 1=1");
                    if (ht.ContainsKey("Difficulty") && !string.IsNullOrEmpty(ht["Difficulty"].SafeToString()))
                    {
                        sbSql4org.Append(" and es.Difficulty=@Difficulty ");
                        pms.Add(new SqlParameter("@Difficulty", ht["Difficulty"].SafeToString()));
                    }
                    else { sbSql4org.AppendFormat(" and es.ID in ({0})", ht["ID"].ToString()); }
                    if (ht.ContainsKey("Klpoint") && !string.IsNullOrEmpty(ht["Klpoint"].SafeToString()))
                    {
                        sbSql4org.Append(" and es.Klpoint=@Klpoint ");
                        pms.Add(new SqlParameter("@Klpoint", ht["Klpoint"].SafeToString()));
                    }
                    sbSql4org.Append("  group by (et.Title)  ");
                    return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }
        public DataTable GetListADD(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select * from Exam_SubQuestion as es where 1=1");
                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and es.ID in ({0})", ht["ID"].ToString());
                }
                return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
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
                sbSql4org.Append(@"select es.ID from Exam_SubQuestion as es left join Exam_ExamType as et on es.Type=et.ID where 1=1");
                if (ht.ContainsKey("Title") && !string.IsNullOrEmpty(ht["Title"].SafeToString()))
                {
                    sbSql4org.Append(" and et.Title=@Title ");
                    pms.Add(new SqlParameter("@Title", ht["Title"].SafeToString()));
                }
                return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }
        public DataTable GetListrandomone(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select es.ID,es.Type,et.QType,es.Score from Exam_SubQuestion as es left join Exam_ExamType as et on es.Type=et.ID where 1=1");
                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    sbSql4org.Append("  and es.ID=@ID ");
                    pms.Add(new SqlParameter("@ID", ht["ID"].SafeToString()));
                }
                return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }
        public DataTable GetListtimu(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@" select es.Author,es.Answer,es.Analysis,es.Title,es.Type,es.Analysis,es.Difficulty,es.IsShowAnalysis,es.Score from Exam_SubQuestion as es left join Exam_ExamType as et on es.Type=et.ID where 1=1");
                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and es.ID in ({0})", ht["ID"].ToString());

                }
                if (ht.ContainsKey("Title") && !string.IsNullOrEmpty(ht["Title"].SafeToString()))
                {
                    sbSql4org.Append(" and et.Title=@Title ");
                    pms.Add(new SqlParameter("@Title", ht["Title"].SafeToString()));
                }
                return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
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
