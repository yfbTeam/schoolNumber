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
    public partial class Exam_ExamPaperDal : HZ_BaseDal<Exam_ExamPaper>, IExam_ExamPaperDal
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
                sbSql4org.Append(@"select ep.*,
                                    case ep.Status when 1 then '启用' else '禁用' END as StatusShow,ep.Title as Name,
                                    case ep.Type when 1 then '考试' when 2 then '测试' when 4 then '调查问卷' else '作业' end as TypeShow,
                                    case ep.Difficulty when 1 then '简单' when 2 then '中等' else '困难' end as DifficultyShow,
                                    convert(varchar(10),ep.CreateTime,21) as CreateTime_Format                                    
                                    from Exam_ExamPaper as ep
                                    where 1=1 ");
                if (ht.ContainsKey("Status") && !string.IsNullOrEmpty(ht["Status"].ToString()))
                {
                    sbSql4org.Append(" and  ep.Status=@Status ");
                    pms.Add(new SqlParameter("@Status", ht["Status"].ToString()));
                }
                //if (ht.ContainsKey("MajorId") && !string.IsNullOrEmpty(ht["MajorId"].ToString()))
                //{
                //    sbSql4org.Append(" and ep.Major like  N'%'+@MajorId + '%' ");
                //    pms.Add(new SqlParameter("@MajorId", ht["MajorId"].ToString()));
                //}
                if (ht.ContainsKey("KlpointID") && !string.IsNullOrEmpty(ht["KlpointID"].ToString()))
                {
                    sbSql4org.Append(" and ep.Klpoint=@KlpointID ");
                    pms.Add(new SqlParameter("@KlpointID", ht["KlpointID"].ToString()));
                }
                if (ht.ContainsKey("Book") && !string.IsNullOrEmpty(ht["Book"].ToString()))
                {
                    sbSql4org.Append(" and ep.Book like @Book ");
                    pms.Add(new SqlParameter("@Book", ht["Book"].ToString()));
                }
                if (ht.ContainsKey("Type") && !string.IsNullOrEmpty(ht["Type"].ToString()))
                {
                    sbSql4org.Append(" and ep.Type=@Type ");
                    pms.Add(new SqlParameter("@Type", ht["Type"].ToString()));
                }
                if (ht.ContainsKey("Title") && !string.IsNullOrEmpty(ht["Title"].ToString()))
                {
                    sbSql4org.Append(" and ep.Title like N'%' + @Title + '%' ");
                    pms.Add(new SqlParameter("@Title", ht["Title"].ToString()));
                }
                if (ht.ContainsKey("IsRelease") && !string.IsNullOrEmpty(ht["IsRelease"].ToString()))
                {
                    sbSql4org.Append(" and  ep.IsRelease=@IsRelease ");
                    pms.Add(new SqlParameter("@IsRelease", ht["IsRelease"].ToString()));
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
        public DataTable GetList(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select ex.Status,ex.UserName,ep.ID,ex.ID as exid,ep.FullScore,ep.ExamTime,ex.Title,ep.Title as name,ep.evaluate from Exam_ExamPaper ep left join Exam_Examination ex on ep.ID=ex.ExampaperID where 1=1");
                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and ep.ID in ({0})", ht["ID"].ToString());

                }
                if (ht.ContainsKey("CreateUID") && !string.IsNullOrEmpty(ht["CreateUID"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and ex.CreateUID = '{0}'", ht["CreateUID"].ToString());

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

        public object addexams(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                string sql = string.Format(@" insert into Exam_ExamPaper(Title,Klpoint,Book,Type,FullScore,ExamTime,Difficulty,Status,IsRelease,CreateTime,Author) values('{0}',{1},'{2}',{3},{4},{5},{6},{7},{8},'{9}','{10}')", ht["Title"].ToString(), ht["Klpoint"].ToString(), ht["Book"].ToString(), ht["Type"].ToString(), ht["FullScore"].ToString(), ht["ExamTime"].ToString(), ht["Difficulty"].ToString(), ht["Status"].ToString(), ht["IsRelease"].ToString(), DateTime.Now, ht["Author"].ToString());                
                SQLHelp.ExecuteNonQuery(sql, CommandType.Text, pms.ToArray());
                 int i = Convert.ToInt32(GetId());
                 return i;
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
        }
        public object upExam_ExamPaperDal(Hashtable ht, string Where = "")
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                string sql = string.Format(@" update Exam_ExamPaper set WorkBeginTime='{0}',WorkEndTime='{1}',ClassID='{2}',IsRelease={3},evaluate='{4}' where ID={5}", ht["WorkBeginTime"].ToString(), ht["WorkEndTime"].ToString(), ht["ClassID"].ToString(), ht["IsRelease"].ToString(), ht["evaluate"].ToString(), ht["ID"].ToString());
                return SQLHelp.ExecuteNonQuery(sql, CommandType.Text, pms.ToArray()); ;
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
            string sql = "select  ident_current('Exam_ExamPaper') as id";
            return SQLHelp.ExecuteScalar(sql, CommandType.Text, pms.ToArray());
        }

        /// <summary>
        /// 获取考试列表信息--分页
        /// 移动端
        /// </summary>
        /// <param name="ht"></param>
        /// <param name="RowCount"></param>
        /// <returns></returns>
        public DataTable GetListPageM(Hashtable ht, out int RowCount)
        {
            RowCount = 0;
            List<SqlParameter> pms = new List<SqlParameter>();
            int StartIndex = 0;
            int EndIndex = 0;

            StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
            EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());

            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select ep.ID,ep.Title,case ep.Type when 1 then '考试' when 2 then '测试' when 3 then '作业' end as type,ep.CreateTime,
cc.Name from (select ID,Title,Type,CreateTime,Klpoint,ClassID from Exam_ExamPaper) as ep left join
(select ID,Name from Course_Chapter) as cc on ep.Klpoint=cc.ID where ep.Type in (1,2) ");
                if (ht.ContainsKey("ClassID") && !string.IsNullOrEmpty(ht["ClassID"].ToString()))
                {
                    sbSql4org.Append(" and  ep.ClassID like @ClassID ");
                    pms.Add(new SqlParameter("@ClassID", "%," + ht["ClassID"].ToString() + ",%"));
                }
                
                return SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", "", "", StartIndex, EndIndex, true, pms.ToArray(), out RowCount);
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }

        }

        /// <summary>
        /// 获取问卷列表信息--分页
        /// 移动端
        /// </summary>
        /// <param name="ht"></param>
        /// <param name="RowCount"></param>
        /// <returns></returns>
        public DataTable GetListPageM_questionnaire(Hashtable ht, out int RowCount)
        {
            RowCount = 0;
            List<SqlParameter> pms = new List<SqlParameter>();
            int StartIndex = 0;
            int EndIndex = 0;

            StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
            EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());

            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select ep.ID,ep.Title,case ep.Type when 1 then '考试' when 2 then '测试' when 3 then '作业' when 4 then '问卷' end as type,ep.CreateTime,
cc.Name from (select ID,Title,Type,CreateTime,Klpoint,ClassID from Exam_ExamPaper) as ep left join
(select ID,Name from Course_Chapter) as cc on ep.Klpoint=cc.ID where ep.Type = 4 ");
                if (ht.ContainsKey("ClassID") && !string.IsNullOrEmpty(ht["ClassID"].ToString()))
                {
                    sbSql4org.Append(" and  ep.ClassID like @ClassID ");
                    pms.Add(new SqlParameter("@ClassID", "%," + ht["ClassID"].ToString() + ",%"));
                }

                return SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", "", "", StartIndex, EndIndex, true, pms.ToArray(), out RowCount);
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
