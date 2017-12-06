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
    public partial class Couse_TaskInfoDal : HZ_BaseDal<Couse_TaskInfo>, ICouse_TaskInfoDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            RowCount = 0;
            List<SqlParameter> pms = new List<SqlParameter>();
            DataTable dt = new DataTable();
            try
            {
                int StartIndex = 0;
                int EndIndex = 0;
                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                string CourseID = ht["CourseID"].SafeToString();
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select TK.*,convert(varchar(16),TK.CreateTime,21) as CreateTime_Format,chap.* ");
                if (ht.ContainsKey("UserIdCard") && !string.IsNullOrEmpty(ht["UserIdCard"].SafeToString()))
                {
                    sbSql4org.Append(@" ,case when TK.CreateUID=@UserIdCard then 1 else 0 end as IsCreate ");
                    pms.Add(new SqlParameter("@UserIdCard", ht["UserIdCard"].ToString()));
                }
                if (ht.ContainsKey("StuIDCard") && !string.IsNullOrEmpty(ht["StuIDCard"].SafeToString()))
                {
                    sbSql4org.Append(@" ,(select count(1) from Course_TaskRel where TaskID=TK.ID and CreateUID=@StuIDCard) as ComCount
                                        ,case when (select count(1) where @ClassID in(select value from func_split(TK.StuRange,',')))>0 then 1 else 0 end as IsHasTask ");
                    pms.Add(new SqlParameter("@StuIDCard", ht["StuIDCard"].SafeToString()));
                    pms.Add(new SqlParameter("@ClassID", ht["ClassID"].SafeToString()));
                }
                else
                {
                    sbSql4org.Append(@" ,(select count(1) from Course_TaskRel where TaskID=TK.ID) as ComCount ");
                }
                sbSql4org.Append(@" from(select task.*,rinfo.Name as RelName,0 as RelOtherField,'学资源' as TaskType
                                    from Couse_TaskInfo task 
                                    inner join Couse_Resource res on task.RelationID=res.ID
                                    inner join ResourcesInfo rinfo on res.ResourcesID=rinfo.ID where task.Type=0
                                    union
                                    select task.*,paper.Title as RelName,paper.Klpoint as RelOtherField,'试卷' as TaskType
                                    from Couse_TaskInfo task 
                                    inner join Exam_ExamPaper paper on task.RelationID=paper.ID and paper.Type=1 where task.Type=1
                                    union
                                    select task.*,tpc.Name as RelName,0 as RelOtherField,'讨论' as TaskType
                                    from Couse_TaskInfo task 
                                    inner join Topic tpc on task.RelationID=tpc.Id where task.Type=2
                                    union
                                    select task.*,work.Name as RelName,work.PointID as RelOtherField,'作业' as TaskType
                                    from Couse_TaskInfo task
                                    inner join Course_Work work on task.RelationID=work.Id where task.Type=3
                                    union
                                    select task.*,ques.Title as RelName,ques.Klpoint as RelOtherField,'调查问卷' as TaskType
                                    from Couse_TaskInfo task 
                                    inner join Exam_ExamPaper ques on task.RelationID=ques.ID and ques.Type=4 where task.Type=4) TK 
                                    left join (select content.ID as SingChapterID,
                                    (case when convert(nvarchar,chapter.ID) is null then '' else convert(nvarchar,chapter.ID)+'|' end
                                    +case when convert(nvarchar,knot.ID) is null then '' else +convert(nvarchar,knot.ID)+'|' end
                                    +isnull(convert(nvarchar,content.ID),'')) as ComChapterID ,
                                    isnull(chapter.Name,'') ChapterName,isnull(knot.Name,'') KnotName,isnull(content.Name,'') ContentHName 
                                    from Course_Chapter content 
                                    left join Course_Chapter knot on content.Pid=knot.ID
                                    left join Course_Chapter chapter on knot.Pid=chapter.ID) chap on chap.ComChapterID=TK.ChapterID ");                
                sbSql4org.Append(@" where TK.IsDelete=0 ");
                if (CourseID.Length > 0)
                {
                    sbSql4org.Append(" and TK.CourseID=@CourseID ");
                    pms.Add(new SqlParameter("@CourseID", CourseID));
                }
                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].ToString()))
                {
                    sbSql4org.Append(" and TK.Name like N'%' + @Name + '%' ");
                    pms.Add(new SqlParameter("@Name", ht["Name"].ToString()));
                }
                if (ht.ContainsKey("ChapterID") && !string.IsNullOrEmpty(ht["ChapterID"].SafeToString()))
                {
                    sbSql4org.Append(" and '|'+TK.ChapterID+'|'  like N'|' + @ChapterID + '|%' ");
                    pms.Add(new SqlParameter("@ChapterID", ht["ChapterID"].SafeToString()));
                }
                dt = SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", where, "", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }

        #region 获取课程的进度信息
        public DataTable GetCourseProgressInfo(Hashtable ht)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            DataTable dt = new DataTable();
            try
            {                
                string CourseID = ht["CourseID"].SafeToString();
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select sum(task.Weight) as AllWeight,count(1) as AllCount ");
                if (ht.ContainsKey("StuIDCard") && !string.IsNullOrEmpty(ht["StuIDCard"].SafeToString()))
                {
                    sbSql4org.Append(@" ,sum(case when rel.Id is not null then task.Weight else 0 end) as ComWeight,
                                        ,sum(case when rel.Id is not null then 1 else 0 end) as ComCount ");
                }
                sbSql4org.Append(@" from Couse_TaskInfo task ");
                if (ht.ContainsKey("StuIDCard") && !string.IsNullOrEmpty(ht["StuIDCard"].SafeToString()))
                {
                    sbSql4org.Append(@" left join Course_TaskRel rel on rel.TaskID=task.ID and rel.CreateUID=@StuIDCard ");
                    pms.Add(new SqlParameter("@StuIDCard", ht["StuIDCard"].SafeToString()));
                }
                sbSql4org.Append(@" where task.IsDelete=0 ");                
                if (CourseID.Length > 0)
                {
                    sbSql4org.Append(" and task.CourseID=@CourseID ");
                    pms.Add(new SqlParameter("@CourseID", CourseID));
                }
                if (ht.ContainsKey("ChapterID") && !string.IsNullOrEmpty(ht["ChapterID"].SafeToString()))
                {
                    sbSql4org.Append(" and '|'+task.ChapterID+'|'  like N'|' + @ChapterID + '|%' ");
                    pms.Add(new SqlParameter("@ChapterID", ht["ChapterID"].SafeToString()));
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
      
        #region 获取学生任务完成信息
        public DataTable GetStuTaskCompleteInfo(Hashtable ht)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            DataTable dt = new DataTable();
            try
            {
                string CourseID = ht["CourseID"].SafeToString();
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select distinct count(1) as ComCount,isnull(sum(task.Weight),0) as ComWeight ");
                string isGroupIDCard = ht["IsGroupIDCard"].SafeToString();
                if (isGroupIDCard == "1")
                {
                    sbSql4org.Append(",rel.CreateUID ");
                }
                sbSql4org.Append(@" from Course_TaskRel rel
	                                inner join Couse_TaskInfo task on rel.TaskID=task.ID and task.IsDelete=0 
                                    where 1=1 ");                            
                if (CourseID.Length > 0)
                {
                    sbSql4org.Append(" and task.CourseID=@CourseID ");
                    pms.Add(new SqlParameter("@CourseID", CourseID));
                }
                if (ht.ContainsKey("ChapterID") && !string.IsNullOrEmpty(ht["ChapterID"].SafeToString()))
                {
                    sbSql4org.Append(" and '|'+task.ChapterID+'|'  like N'|' + @ChapterID + '|%' ");
                    pms.Add(new SqlParameter("@ChapterID", ht["ChapterID"].SafeToString()));
                }
                if (ht.ContainsKey("TaskID") && !string.IsNullOrEmpty(ht["TaskID"].SafeToString()))
                {
                    sbSql4org.Append(@" and task.ID=@TaskID ");
                    pms.Add(new SqlParameter("@TaskID", ht["TaskID"].SafeToString()));
                }
                if (ht.ContainsKey("StuIDCard") && !string.IsNullOrEmpty(ht["StuIDCard"].SafeToString()))
                {
                    sbSql4org.Append(" and rel.CreateUID=@StuIDCard ");
                    pms.Add(new SqlParameter("@StuIDCard", ht["StuIDCard"].ToString()));
                }
                if (isGroupIDCard == "1")
                {
                    sbSql4org.Append(@" group by rel.CreateUID ");  
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

        #region 获取完成某任务的人数
        public int GetComCountByTaskID(int taskid)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            int comCount = 0;
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select count(1) from Course_TaskRel where 1=1 ");               
                if (taskid> 0)
                {
                    sbSql4org.Append(" and TaskID=@TaskID ");
                    pms.Add(new SqlParameter("@TaskID", taskid));
                }
                comCount = Convert.ToInt32(SQLHelp.ExecuteScalar(sbSql4org.ToString(), CommandType.Text, pms.ToArray()));
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return comCount;
        }
        #endregion 
    }
}
