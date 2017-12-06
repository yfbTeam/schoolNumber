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
    public partial class Exam_ExamPaperObjQDal : HZ_BaseDal<Exam_ExamPaperObjQ>, IExam_ExamPaperObjQDal
    {
        public DataTable GetList(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@" select COUNT(*) as sum,et.Title,sum(eq.Score) as score from Exam_ExamPaperObjQ as eq left join Exam_ExamType as et on eq.Type=et.ID where 1=1");
                if (ht.ContainsKey("ExampaperID") && !string.IsNullOrEmpty(ht["ExampaperID"].SafeToString()))
                {
                    sbSql4org.Append(" and eq.ExampaperID=@ExampaperID ");
                    pms.Add(new SqlParameter("@ExampaperID", ht["ExampaperID"].SafeToString()));
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
        public DataTable GetListtimu(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@" select eq.OrderID,eq.Score,et.Title,eq.ID,et.Template,eq.OptionA,eq.OptionB,eq.OptionC,eq.OptionD,eq.OptionE,eq.OptionF,eq.Type,eq.Content,eq.Analysis,eq.Answer,et.QType from Exam_ExamPaperObjQ as eq left join Exam_ExamType as et on eq.Type=et.ID where 1=1");
                if (ht.ContainsKey("ExampaperID") && !string.IsNullOrEmpty(ht["ExampaperID"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and eq.ExampaperID={0}", ht["ExampaperID"].ToString());

                }
                if (ht.ContainsKey("Title") && !string.IsNullOrEmpty(ht["Title"].SafeToString()))
                {
                    sbSql4org.Append(" and et.Title=@Title ");
                    pms.Add(new SqlParameter("@Title", ht["Title"].SafeToString()));
                }
                //sbSql4org.Append(" order by (OrderID) desc ");
                return SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, pms.ToArray());
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }
        public object addexams(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                string sql = string.Format(@" insert into Exam_ExamPaperObjQ(ExampaperID,Type,Content,OptionA,OptionB,OptionC,OptionD,OptionE,OptionF,Difficulty,Answer,Score,IsShowAnalysis,Analysis,OrderID) values('{0}',{1},'{2}','{3}','{4}','{5}','{6}','{7}','{8}',{9},'{10}',{11},{12},'{13}',{14})", ht["ExampaperID"].ToString(), ht["Type"].ToString(), ht["Content"].ToString(), ht["OptionA"].ToString(), ht["OptionB"].ToString(), ht["OptionC"].ToString(), ht["OptionD"].ToString(), ht["OptionE"].ToString(), ht["OptionF"].ToString(), ht["Difficulty"].ToString(), ht["Answer"].ToString(), ht["Score"].ToString(), ht["IsShowAnalysis"].ToString(), ht["Analysis"].ToString(), ht["OrderID"].ToString());
                return SQLHelp.ExecuteNonQuery(sql, CommandType.Text, pms.ToArray());
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
