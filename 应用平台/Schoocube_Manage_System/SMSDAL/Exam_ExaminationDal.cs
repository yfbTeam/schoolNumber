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
    public partial class Exam_ExaminationDal : HZ_BaseDal<Exam_Examination>, IExam_ExaminationDal
    {
        //我的试卷总查询
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage = true, string Where = "")
        {
            RowCount = 0;
            List<SqlParameter> pms = new List<SqlParameter>();
            int StartIndex = 0;
            int EndIndex = 0;
            if (IsPage)
            {
                StartIndex = Convert.ToInt32(ht["StartIndex"].SafeToString());
                EndIndex = Convert.ToInt32(ht["EndIndex"].SafeToString());
            }
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select ep.WorkBeginTime,ep.WorkEndTime,ex.CreateUID,ex.UserName,ex.AnswerEndTime,ex.AnswerBeginTime,ep.ID,ex.ID as rids,case ep.Type when 1 then '考试' when 2 then '测试' when 3 then '作业' when 4 then '调查问卷' end as typeid,case ex.[Status] when 1 then '未阅' when 2 then '已阅' end as Statushow,
                                    ex.Title,ep.Title as epname,ep.FullScore,ep.ExamTime,case Difficulty when 1 then '简单' when 2 then '中等' else '困难' end as Difficultyshow,
                                    convert(varchar(10),ep.CreateTime,21) as CreateTime_Format ,Author from Exam_ExamPaper as ep left join Exam_Examination as ex on ex.ExampaperID=ep.ID where IsRelease=1 and 1=1");
                if (ht.ContainsKey("Status") && !string.IsNullOrEmpty(ht["Status"].ToString()))
                {
                    sbSql4org.Append(" and ex.Status = @Status ");
                    pms.Add(new SqlParameter("@Status", ht["Status"].ToString()));
                }
                if (ht.ContainsKey("ClassID") && !string.IsNullOrEmpty(ht["ClassID"].ToString()))
                {
                    string str = ht["ClassID"].ToString();
                    string[] sstr = str.Split('|');
                    sbSql4org.Append(" and ");
                    sbSql4org.Append(" ( ");
                    for (int i = 0; i < sstr.Count(); i++)
                    {
                        sbSql4org.AppendFormat("    ClassID like '%{0}%' ", sstr[i]);
                        sbSql4org.Append(" or");
                    }
                    string sb = sbSql4org.ToString().Substring(0, sbSql4org.ToString().Length - 2);
                    StringBuilder stringBuilder = new StringBuilder(sb);
                    sbSql4org = stringBuilder;
                    sbSql4org.Append(" ) ");
                }
                if (ht.ContainsKey("Book") && !string.IsNullOrEmpty(ht["Book"].ToString()))
                {
                    string str = ht["Book"].ToString();
                    string[] sstrb = str.Split(',');
                    sbSql4org.Append(" and ");
                    sbSql4org.Append(" ( ");
                    for (int i = 0; i < sstrb.Count(); i++)
                    {
                        sbSql4org.AppendFormat("    Book like '{0}' ", sstrb[i]);
                        sbSql4org.Append(" or");
                    }
                    string sbk = sbSql4org.ToString().Substring(0, sbSql4org.ToString().Length - 2);
                    StringBuilder stringBuilder1 = new StringBuilder(sbk);
                    sbSql4org = stringBuilder1;
                    sbSql4org.Append(" ) ");
                }
                if (ht.ContainsKey("Type") && !string.IsNullOrEmpty(ht["Type"].ToString()))
                {
                    sbSql4org.Append(" and ep.Type=@Type ");
                    pms.Add(new SqlParameter("@Type", ht["Type"].ToString()));
                }
                if (ht.ContainsKey("tStatus") && !string.IsNullOrEmpty(ht["tStatus"].ToString()))
                {
                    sbSql4org.Append(" and ex.Status in (@tStatus) ");
                    pms.Add(new SqlParameter("@tStatus", ht["tStatus"].ToString()));
                }
                if (ht.ContainsKey("Title") && !string.IsNullOrEmpty(ht["Title"].ToString()))
                {
                    sbSql4org.Append(" and ep.Title like N'%' + @Title + '%' ");
                    pms.Add(new SqlParameter("@Title", ht["Title"].ToString()));
                }
                if (ht.ContainsKey("noCreateUID") && !string.IsNullOrEmpty(ht["noCreateUID"].ToString()))
                {
                    sbSql4org.Append(" and ep.ID not in (select ExampaperID from Exam_Examination where CreateUID=@noCreateUID and Status<>0) and ep.Status = 1 ");
                    pms.Add(new SqlParameter("@noCreateUID", ht["noCreateUID"].ToString()));
                }

                if (ht.ContainsKey("CreateUID") && !string.IsNullOrEmpty(ht["CreateUID"].ToString()))
                {
                    sbSql4org.Append(" and ex.CreateUID=@CreateUID and ex.Status<>0");
                    pms.Add(new SqlParameter("@CreateUID", ht["CreateUID"].ToString()));
                }
                if (ht.ContainsKey("ExampaperID") && !string.IsNullOrEmpty(ht["ExampaperID"].ToString()))
                {
                    sbSql4org.Append(" and ex.ExampaperID=@ExampaperID ");
                    pms.Add(new SqlParameter("@ExampaperID", ht["ExampaperID"].ToString()));
                }
                return SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", Where, "", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
            }
            catch (Exception ex)
            {

                return null;
            }
        }
        public object upExam_Examination(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                string sql = string.Format(@" update Exam_Examination set Status={0} where ID={1}", ht["Status"].ToString(), ht["ID"].ToString());
                return SQLHelp.ExecuteNonQuery(sql, CommandType.Text, pms.ToArray()); ;
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
                sbSql4org.Append(@"select em.UserName,em.Title,em.Score from Exam_Examination as em where 1=1 and em.Status=2");
                if (ht.ContainsKey("hCreateUID") && !string.IsNullOrEmpty(ht["hCreateUID"].SafeToString()))
                {
                    sbSql4org.Append("  and  em.CreateUID=@hCreateUID ");
                    pms.Add(new SqlParameter("@hCreateUID", ht["hCreateUID"].SafeToString()));
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
        public object addExamination(Hashtable ht, string Where = "")
        {
            int result = 0;

            try
            {
                string sqlstr = string.Format(@" select count(1) from Exam_Examination where Title='" + ht["Title"].ToString() + "' and CreateUID='" + ht["CreateUID"].ToString() + "'");
                object objN = SQLHelp.ExecuteScalar(sqlstr, CommandType.Text, null);
                if (objN.SafeToString() == "0")
                {
                    List<SqlParameter> pms = new List<SqlParameter>();

                    string sql = string.Format(@" insert into Exam_Examination(Title,CreateUID,UserName,ExampaperID,Score,Status,Marker,AnswerBeginTime,AnswerEndTime) values('{0}','{1}','{2}',{3},{4},{5},{6},'{7}','{8}')  select  ident_current('Exam_Examination') as id", ht["Title"].ToString(), ht["CreateUID"].ToString(), ht["UserName"].ToString(), ht["ExampaperID"].ToString(), ht["Score"].ToString(), ht["Status"].ToString(), ht["Marker"].ToString(), ht["AnswerBeginTime"].ToString(), ht["AnswerEndTime"].ToString());
                    SQLHelp.ExecuteNonQuery(sql, CommandType.Text, pms.ToArray());
                    int i = Convert.ToInt32(GetId());
                    SqlParameter[] param = {
                                       new SqlParameter("@RelationID", i),
                                       new SqlParameter("@Type", 1),// 1试卷；4调查问卷
                                       new SqlParameter("@ClassID", ht["classid"].ToString()),
                                       new SqlParameter("@CreateUID", ht["CreateUID"].ToString()),
                                       new SqlParameter("@IsCommit",1)
                                   };
                    object obj = SQLHelp.ExecuteScalar("AddCourse_TaskRel", CommandType.StoredProcedure, param);
                    result = Convert.ToInt32(obj);

                }
                return result;

            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }
        public object GetId()
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            string sql = "select  ident_current('Exam_Examination') as id";
            return SQLHelp.ExecuteScalar(sql, CommandType.Text, pms.ToArray());
        }

        #region 统计考试成绩
        public DataTable GetStuScore(Hashtable ht, out int RowCount, bool IsPage = true, string Where = "")
        {
            RowCount = 0;
            List<SqlParameter> pms = new List<SqlParameter>();
            int StartIndex = 0;
            int EndIndex = 0;
            if (IsPage)
            {
                StartIndex = Convert.ToInt32(ht["StartIndex"].SafeToString());
                EndIndex = Convert.ToInt32(ht["EndIndex"].SafeToString());
            }
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select UserName,Score,Title,ID,createTime from Exam_Examination where status=2 ");
                if (ht.ContainsKey("StarDate") && !string.IsNullOrEmpty(ht["StarDate"].ToString()))
                {
                    sbSql4org.Append(" and AnswerBeginTime>'" + ht["StarDate"].ToString() + "'");
                }
                if (ht.ContainsKey("EndDate") && !string.IsNullOrEmpty(ht["EndDate"].ToString()))
                {
                    sbSql4org.Append(" and AnswerEndTime<'" + ht["EndDate"].ToString() + "'");

                }
                if (ht.ContainsKey("RequestType") && !string.IsNullOrEmpty(ht["RequestType"].ToString()))
                {
                    sbSql4org.AppendFormat(" and ExampaperID in (select ID from Exam_ExamPaper where Type=" + ht["RequestType"] + ")");
                }
                if (ht.ContainsKey("RequestCourseName") && !string.IsNullOrEmpty(ht["RequestCourseName"].ToString()))
                {
                    sbSql4org.AppendFormat(" and ExampaperID in (select relationID from Couse_TaskInfo where type=1 and CourseID=" + ht["RequestCourseName"] + ")");
                }

                return SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", Where, "", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
            }
            catch (Exception ex)
            {

                return null;
            }
        }
        #endregion

        public DataTable GetNewRecordForOrder(Hashtable ht, ref int rows)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();

                sbSql4org.Append(@"select UserName,Score,Title from Exam_Examination where status=2 ");
                if (ht.ContainsKey("StarDate") && !string.IsNullOrEmpty(ht["StarDate"].ToString()))
                {
                    sbSql4org.Append(" and AnswerBeginTime>'" + ht["StarDate"].ToString() + "'");
                }
                if (ht.ContainsKey("EndDate") && !string.IsNullOrEmpty(ht["EndDate"].ToString()))
                {
                    sbSql4org.Append(" and AnswerEndTime<'" + ht["EndDate"].ToString() + "'");

                }
                if (ht.ContainsKey("RequestType") && !string.IsNullOrEmpty(ht["RequestType"].ToString()))
                {
                    sbSql4org.AppendFormat(" and ExampaperID in (select ID from Exam_ExamPaper where Type=" + ht["RequestType"] + ")");
                }
                if (ht.ContainsKey("RequestCourseName") && !string.IsNullOrEmpty(ht["RequestCourseName"].ToString()))
                {
                    sbSql4org.AppendFormat(" and ExampaperID in (select relationID from Couse_TaskInfo where type=1 and CourseID=" + ht["RequestCourseName"] + ")");
                }
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, null);
                rows = dt.Rows.Count;
                return dt;
            }
            catch (Exception ex)
            {
                rows = 0;
                return null;
            }
        }
    }
}
