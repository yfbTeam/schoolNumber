using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SMSIDAL;
using SMSModel;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using SMSUtility;

namespace SMSDAL
{
    public partial class Exam_ExamAnswerDal : HZ_BaseDal<Exam_ExamAnswer>, IExam_ExamAnswerDal
    {
        public object addExamAnswer(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                string sql = string.Format(@" insert into Exam_ExamAnswer(ExamID,QuestionID,ExampaperID,Type,Answer,Score) values({0},{1},{2},{3},'{4}',{5})", ht["ExamID"].ToString(), ht["QuestionID"].ToString(), ht["ExampaperID"].ToString(), ht["Type"].ToString(), ht["Answer"].ToString(), ht["Score"].ToString());
                return SQLHelp.ExecuteNonQuery(sql, CommandType.Text, pms.ToArray());
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }
        public DataTable GetListEPQ(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@" select eq.Content,eq.Type,eq.OptionA,eq.OptionB,eq.OptionC,eq.OptionD,eq.OptionE,eq.OptionF,eq.Answer,ea.Score as mescore,ea.Answer as meAnswer,eq.Score from Exam_ExamAnswer ea left join Exam_ExamPaperObjQ eq on ea.QuestionID=eq.ID where 1=1");
                if (ht.ContainsKey("Type") && !string.IsNullOrEmpty(ht["Type"].SafeToString()))
                {
                    sbSql4org.Append(" and ea.Type=@Type ");
                    pms.Add(new SqlParameter("@Type", ht["Type"].SafeToString()));
                }
                if (ht.ContainsKey("ExamID") && !string.IsNullOrEmpty(ht["ExamID"].SafeToString()))
                {
                    sbSql4org.Append(" and ea.ExamID=@ExamID ");
                    pms.Add(new SqlParameter("@ExamID", ht["ExamID"].SafeToString()));
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
        public DataTable GetList(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select SUM(Score) as examscoree from Exam_ExamAnswer where 1=1");
                if (ht.ContainsKey("ExamID") && !string.IsNullOrEmpty(ht["ExamID"].SafeToString()))
                {
                    sbSql4org.Append("  and  ExamID=@ExamID ");
                    pms.Add(new SqlParameter("@ExamID", ht["ExamID"].SafeToString()));
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

        public DataTable GetListEPS(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@" select ea.QuestionID,eq.Analysis,eq.Content,eq.Type,eq.Answer,ea.Score as mescore,ea.Answer as meAnswer,eq.Score from Exam_ExamAnswer ea left join Exam_ExamPaperSubQ eq on ea.QuestionID=eq.ID where 1=1");
                if (ht.ContainsKey("Type") && !string.IsNullOrEmpty(ht["Type"].SafeToString()))
                {
                    sbSql4org.Append(" and ea.Type=@Type ");
                    pms.Add(new SqlParameter("@Type", ht["Type"].SafeToString()));
                }
                if (ht.ContainsKey("ExamID") && !string.IsNullOrEmpty(ht["ExamID"].SafeToString()))
                {
                    sbSql4org.Append(" and ea.ExamID=@ExamID ");
                    pms.Add(new SqlParameter("@ExamID", ht["ExamID"].SafeToString()));
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
        public DataTable GetListTitle(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select ep.Title from Exam_ExamPaper as ep left join Exam_ExamAnswer as ea on ea.ExampaperID=ep.ID where 1=1 ");
                if (ht.ContainsKey("ExampaperID") && !string.IsNullOrEmpty(ht["ExampaperID"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and ea.ExampaperID={0})", ht["ExampaperID"].ToString());

                }
                sbSql4org.Append("  group by(ep.Title)  ");
                return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }
        public object upExam_ExamAnswer(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                string sql = string.Format(@" update Exam_ExamAnswer set Score={0} where ExamID={1} and QuestionID={2} and Type={3}", ht["Score"].ToString(), ht["ExamID"].ToString(), ht["QuestionID"].ToString(), ht["Type"].ToString());
                return SQLHelp.ExecuteNonQuery(sql, CommandType.Text, pms.ToArray()); ;
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
