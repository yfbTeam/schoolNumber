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
    public partial class Couse_SelstuinfoDal : HZ_BaseDal<Couse_Selstuinfo>, ICouse_SelstuinfoDal
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
                string operSymbol = "";
                if (ht.ContainsKey("OperSymbol") && !string.IsNullOrEmpty(ht["OperSymbol"].ToString()))
                {
                    operSymbol = ht["OperSymbol"].ToString();
                }
                sbSql4org.Append(@"select distinct co.*,5 as StudyStuNum,cast(CoursePrice as decimal(12,1)) as Price,
                               (select count(1) from Topic tpc where tpc.IsDelete=0 and tpc.Type=0 and tpc.CouseID=co.ID) as TopicCount ");
                sbSql4org.Append(" ,'"+operSymbol+ "' as OperSymbol ");
                if (ht.ContainsKey("StuNo") && !string.IsNullOrEmpty(ht["StuNo"].ToString()))
                {
                    sbSql4org.Append(@" ,cevalue.Evalue,isnull(Task.AllCount,0) as AllCount,isnull(Task.AllWeight,0) as AllWeight,
	                                    isnull(Task.ComCount,0) as ComCount,isnull(Task.ComWeight,0) as ComWeight
                                       ,isnull(fav.ID,0) as FavoriteID ");
                }                
                sbSql4org.Append(@" from Course co ");
                if (ht.ContainsKey("StuNo") && !string.IsNullOrEmpty(ht["StuNo"].ToString()))
                {
                    sbSql4org.Append(@" left join System_Favorites fav on fav.RelationID=co.ID and fav.Creator=@StuNo and fav.Type=1
                                        left join (select task.CourseID,count(1) as AllCount,sum(task.Weight) as AllWeight
	                                    ,sum(Rel.ComCount) as ComCount,sum(task.Weight*Rel.ComCount) as ComWeight	
	                                    from (select task.*,rinfo.Name as RelName,0 as RelOtherField,'学资源' as TaskType
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
                                        inner join Exam_ExamPaper ques on task.RelationID=ques.ID and ques.Type=4 where task.Type=4) task
	                                    left join ( select TaskID,count(1) as ComCount from Course_TaskRel 
	                                    where CreateUID=@StuNo group by TaskID) Rel on Rel.TaskID=task.ID where task.IsDelete=0 group by task.CourseID
	                                    ) Task on Task.CourseID=co.ID left join Course_Evalue cevalue on co.ID=cevalue.CouseID and  cevalue.CreateUID=@StuNo");
                }
                sbSql4org.Append(@" where 1=1 ");
                sbSql4org.Append(@" and (co.IsOpen=1
                                or co.ID in (select CourseID from Couse_Selstuinfo where Status=1 and co.CourceType=2 and StuNo=@StuNo) ");
                pms.Add(new SqlParameter("@StuNo", ht["StuNo"].ToString()));
                sbSql4org.Append(@" or co.ID in(select CourseID from ClassCourse where co.CourceType=1 and ClassID=@ClassID)) ");
                pms.Add(new SqlParameter("@ClassID", ht["ClassID"].ToString()));
                if (!string.IsNullOrEmpty(operSymbol))
                {
                    sbSql4org.Append(" and co.EndTime" + operSymbol + "getdate() ");
                }
                if (ht.ContainsKey("CourseID") && !string.IsNullOrEmpty(ht["CourseID"].ToString()))
                {
                    sbSql4org.Append(" and co.ID=@CourseID ");
                    pms.Add(new SqlParameter("@CourseID", ht["CourseID"].ToString()));
                }
                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].ToString()))
                {
                    sbSql4org.Append(" and co.Name like N'%' + @Name + '%' ");
                    pms.Add(new SqlParameter("@Name", ht["Name"].ToString()));
                }
                if (ht.ContainsKey("StudyTerm") && !string.IsNullOrEmpty(ht["StudyTerm"].ToString()))
                {
                    sbSql4org.Append(" and co.StudyTerm =@StudyTerm");
                    pms.Add(new SqlParameter("@StudyTerm", ht["StudyTerm"].SafeToString()));
                }
                if (ht.ContainsKey("CourceType") && !string.IsNullOrEmpty(ht["CourceType"].ToString()))
                {
                    sbSql4org.Append(" and co.CourceType =@CourceType");
                    pms.Add(new SqlParameter("@CourceType", ht["CourceType"].SafeToString()));
                }
                if (ht.ContainsKey("IsCharge") && !string.IsNullOrEmpty(ht["IsCharge"].ToString()))
                {
                    sbSql4org.Append(" and co.IsCharge =@StudyTerm");
                    pms.Add(new SqlParameter("@IsCharge", ht["IsCharge"].SafeToString()));
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
        public DataTable GetDataByCourceID(string CourceID)
        {
            return SQLHelp.ExecuteDataTable("select * from Couse_Selstuinfo where CourseID='" + CourceID + "'", CommandType.Text, null);

        }
        public DataTable GetClassOrStuByCourceID(string courceID, string courseType)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            pms.Add(new SqlParameter("@CourseID", courceID));
            string sql = courseType == "1" ? "select ClassID as IDS from ClassCourse where CourseID=@CourseID" : "select StuNo as IDS from Couse_Selstuinfo where Status=1 and CourseID=@CourseID";
            return SQLHelp.ExecuteDataTable(sql, CommandType.Text, pms.ToArray());
        }
        /// <summary>
        /// <option value="1">所有课程</option>
        //<option value="2">已注册课程</option>
        //<option value="3">可匿名访问课程</option>
        //<option value="4">可注册课程</option>
        /// </summary>
        /// <param name="ht"></param>
        /// <param name="RowCount"></param>
        /// <param name="IsPage"></param>
        /// <returns></returns>
        public DataTable GetMyLessonsByType(Hashtable ht, out int RowCount, bool IsPage = true)
        {
            DataTable dt = new DataTable();
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
                string ClassID = ht["ClassID"].SafeToString();
                if (ClassID.Length==0)
                {
                    ClassID = "0";
                }
                string StuNo = ht["StuNo"].SafeToString();
                string Type = ht["CourseType"].SafeToString();
                string Name = ht["Name"].SafeToString();

                StringBuilder sbSql4org = new StringBuilder();

                sbSql4org.Append(@"select IsCharge,Name,ImageUrl,CourceType,LecturerName,CourseIntro,GradeName,ID,EndTime," + Type + " as CurrentType from [dbo].[Course] where 1=1 ");
                if (Name.Length>0)
                {
                    sbSql4org.Append(" and Name like '%" + Name + "%'");
                }
                switch (Type)
                {
                    case "1"://所有课程
                        sbSql4org.Append(@" and IsOpen=1 union
                                        select IsCharge,Name,ImageUrl,CourceType,LecturerName,CourseIntro,GradeName,ID,EndTime," + Type + " as CurrentType from [dbo].[Course] where CourceType=1 and id in (select courseid from [dbo].[ClassCourse] where [ClassID]=" + ClassID +
                                        ")union select IsCharge,Name,ImageUrl,CourceType,LecturerName,CourseIntro,GradeName,ID,EndTime," + Type + " as CurrentType from [dbo].[Course] where CourceType=2 and id in (select CourseID from [dbo].[Couse_Selstuinfo] where stuno='" + StuNo + "')");
                        break;
                    case "2"://已注册课程
                        sbSql4org.Append(@" and CourceType=2 and ID in (select CourseID from [dbo].[Couse_Selstuinfo] where stuno='" + StuNo + "')");
                        break;
                    case "3"://可匿名访问课程
                        sbSql4org.Append(@" and IsOpen=1");
                        break;
                    case "4"://可注册课程
                        sbSql4org.Append(@" and CourceType=2 and ID in (select courseid from [dbo].[ClassCourse] where [ClassID]="+ClassID+" and courseid not in (select CourseID from [dbo].[Couse_Selstuinfo] where stuno='" + StuNo + "'))");
                        break;
                    default:
                        break;
                }
                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    sbSql4org.Append(" and ID = " + ht["ID"].SafeToString());
                }
                dt = SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", "", "", StartIndex, EndIndex, IsPage, null, out RowCount);
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;
                return null;
            }
            return dt;
        }

        #region 获取班级课程
        public DataTable GetClassCourses(Hashtable ht)
        {

            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select distinct co.*,cast(CoursePrice as decimal(12,1)) as Price ");
                if (ht.ContainsKey("ShowClassID") && !string.IsNullOrEmpty(ht["ShowClassID"].ToString()))
                {
                    sbSql4org.Append(" ,case when clac.ID is null then 0 else 1 end as IsCheckCourse ");
                    pms.Add(new SqlParameter("@ShowClassID", ht["ShowClassID"].ToString()));
                }
                sbSql4org.Append(@" from Course co ");
                if (ht.ContainsKey("ShowClassID") && !string.IsNullOrEmpty(ht["ShowClassID"].ToString()))
                {
                    sbSql4org.Append(" left join ClassCourse clac on clac.CourseID=co.ID and clac.ClassID=@ShowClassID and clac.IsDelete=0 ");
                }
                sbSql4org.Append(@" where 1=1 ");
                sbSql4org.Append(@" and co.ID in(select CourseID from ClassCourse where 1=1  ");                
                if (ht.ContainsKey("ClassID") && !string.IsNullOrEmpty(ht["ClassID"].ToString()))
                {
                    sbSql4org.Append(" and ClassID=@ClassID ");
                    pms.Add(new SqlParameter("@ClassID", ht["ClassID"].ToString()));
                }
                sbSql4org.Append(")");
                if (ht.ContainsKey("GradeID") && !string.IsNullOrEmpty(ht["GradeID"].ToString()))
                {
                    sbSql4org.Append(" and co.Grade=@GradeID ");
                    pms.Add(new SqlParameter("@GradeID", ht["GradeID"].ToString()));
                }
                if (ht.ContainsKey("OperSymbol") && !string.IsNullOrEmpty(ht["OperSymbol"].ToString()))
                {
                    sbSql4org.Append(" and co.EndTime" + ht["OperSymbol"].ToString() + "getdate() ");
                }
                if (ht.ContainsKey("CourseID") && !string.IsNullOrEmpty(ht["CourseID"].ToString()))
                {
                    sbSql4org.Append(" and co.ID=@CourseID ");
                    pms.Add(new SqlParameter("@CourseID", ht["CourseID"].ToString()));
                }
                if(ht.ContainsKey("CourseType") && !string.IsNullOrEmpty(ht["CourseType"].ToString()))
                {
                    sbSql4org.Append(" and co.CourceType=@CourseType ");
                    pms.Add(new SqlParameter("@CourseType", ht["CourseType"].ToString()));
                }
                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].ToString()))
                {
                    sbSql4org.Append(" and co.Name like N'%' + @Name + '%' ");
                    pms.Add(new SqlParameter("@Name", ht["Name"].ToString()));
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
        #endregion

        #region 批量添加班级课程
        public int BatchAddClassCourse(ClassCourse entity, string courseids)
        {
            int result = 0;
            SqlParameter[] param = {
                                       new SqlParameter("@ClassID", entity.ClassID),
                                       new SqlParameter("@CourseIDs", courseids),                                       
                                       new SqlParameter("@CreateUID", entity.CreateUID)                                       
                                   };
            object obj = SQLHelp.ExecuteScalar("BatchAddClassCourse", CommandType.StoredProcedure, param);
            result = Convert.ToInt32(obj);
            return result;
        }
        #endregion
    }
}
