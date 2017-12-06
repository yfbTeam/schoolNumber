using SMIDAL;
using SMModel;
using SMSUtility;
using SMUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMDAL
{
    public partial class Base_TeacherDal : BaseDal<Plat_Teacher>, IPlat_TeacherDal
    {
        /// <summary>
        /// 验证账号密码
        /// </summary>
        /// <param name="LoginName">登录账号</param>
        /// <param name="Password">密码</param>
        /// <returns></returns>
        public DataTable ValidationUser(string LoginName, string Password)
        {
            try
            {
                string SQL = @"select *,'教师' as SF from Plat_Teacher where 1=1 ";
                SQL += " and LoginName=@LoginName and Password=@Password and IsDelete=0";
                List<SqlParameter> list = new List<SqlParameter>();
                list.Add(new SqlParameter("@LoginName", LoginName));
                list.Add(new SqlParameter("@Password", Password));
                DataTable dt = SQLHelp.ExecuteDataTable(SQL, CommandType.Text, list.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.ToString());
                throw;
            }
        }

        /// <summary>
        /// 查找数据是否存在
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public int ValidataIsExist(Hashtable ht,ref DataTable dt) 
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                StringBuilder sbSqlreader = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                string sql = "";
                string sqlTable = "";
                sbSql4org.Append("select count(1) from {0} where 1=1 ");
                sbSqlreader.Append("select * from {0} where 1=1");
                if (ht.ContainsKey("LoginName") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["LoginName"])))
                {
                    sbSql4org.Append(" and LoginName=@LoginName");
                    sbSqlreader.Append(" and LoginName=@LoginName");
                    List.Add(new SqlParameter("@LoginName", ht["LoginName"]));
                }
                if (ht.ContainsKey("Name") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["Name"])))
                {
                    sbSql4org.Append(" and [Name]=@Name");
                    sbSqlreader.Append(" and [Name]=@Name");
                    List.Add(new SqlParameter("@Name", ht["Name"]));
                }
                if (ht.ContainsKey("IDCard") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["IDCard"])))
                {
                    sbSql4org.Append(" and IDCard=@IDCard");
                    sbSqlreader.Append(" and IDCard=@IDCard");
                    List.Add(new SqlParameter("@IDCard", ht["IDCard"]));
                }
                if (ht.ContainsKey("UserType") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["UserType"])))
                {
                    if (Convert.ToInt32(ht["UserType"]) == (int)UserType.教师)
                    {
                        sql = string.Format(sbSql4org.ToString(), UserTableType.Plat_Teacher.ToString());
                        sqlTable = string.Format(sbSqlreader.ToString(), UserTableType.Plat_Teacher.ToString());
                    }
                    else
                    {
                        sql=string.Format(sbSql4org.ToString(), UserTableType.Plat_Student.ToString());
                        sqlTable=string.Format(sbSqlreader.ToString(), UserTableType.Plat_Student.ToString());
                    }
                }
                int number = Convert.ToInt32(SQLHelp.ExecuteScalar(sql, CommandType.Text, List.ToArray()));
                if (!string.IsNullOrWhiteSpace(Convert.ToString("reader")))
                {
                    if (number>0)
                    {
                        dt = SQLHelp.ExecuteDataTable(sqlTable, CommandType.Text, List.ToArray());
                    }
                }
                return number;
            }
            catch (Exception)
            {
                return -1;
            }
            
        }

        /// <summary>
        /// 用户注册
        /// </summary>
        /// <param name="ht"></param>
        /// <returns></returns>
        public int Register(Hashtable ht) 
        {

            using (SqlTransaction trans = SQLHelp.BeginTransaction())
            {
                try
                {
                    StringBuilder sbSql4org = new StringBuilder();
                    List<SqlParameter> list = new List<SqlParameter>();
                    if (ht.ContainsKey("UserType") && Convert.ToInt32(ht["UserType"]) == (int)UserType.教师)
                        sbSql4org.Append("insert into Plat_Teacher(IDCard,LoginName,[Password],SchoolID,[State],JobNumber,[Name],Sex,Phone,SystemKey,IsDelete) Values(@IDCard,@LoginName,@Password,@SchoolID,@State,@JobNumber,@Name,@Sex,@Phone,@SystemKey,@IsDelete)");
                    else
                        sbSql4org.Append("insert into Plat_Student(IDCard,SchoolNO,LoginName,[Password],SchoolID,[State],[Name],Sex,GradeID,ClassID,Phone,IsDelete) Values(@IDCard,@SchoolNO,@LoginName,@Password,@SchoolID,@State,@Name,@Sex,@GradeID,@ClassID,@Phone,@IsDelete)");
                    #region 公共部分
                    if (ht.ContainsKey("IDCard") && !string.IsNullOrEmpty(Convert.ToString(ht["IDCard"])))
                    {
                        list.Add(new SqlParameter("@IDCard", ht["IDCard"].ToString()));
                    }
                    if (ht.ContainsKey("LoginName") && !string.IsNullOrEmpty(Convert.ToString(ht["LoginName"])))
                    {
                        list.Add(new SqlParameter("@LoginName", ht["LoginName"].ToString()));
                    }
                    if (ht.ContainsKey("Password") && !string.IsNullOrEmpty(Convert.ToString(ht["Password"])))
                    {
                        //BCrypt.Net.BCrypt.HashPassword(ht["Password"].ToString(), BCrypt.Net.BCrypt.GenerateSalt());
                        string pwd = SMSUtility.EncryptHelper.Md5By32(ht["Password"].ToString());
                        list.Add(new SqlParameter("@Password", pwd));
                    }
                    if (ht.ContainsKey("SchoolID") && !string.IsNullOrEmpty(Convert.ToString(ht["SchoolID"])))
                    {
                        list.Add(new SqlParameter("@SchoolID", Convert.ToInt32(ht["SchoolID"])));
                    }
                    if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(Convert.ToString(ht["Name"])))
                    {
                        list.Add(new SqlParameter("@Name", ht["Name"].ToString()));
                    }
                    if (ht.ContainsKey("Sex") && !string.IsNullOrEmpty(Convert.ToString(ht["Sex"])))
                    {
                        list.Add(new SqlParameter("@Sex", Convert.ToInt32(ht["Sex"])));
                    }
                    if (ht.ContainsKey("SystemKey") && !string.IsNullOrEmpty(Convert.ToString(ht["SystemKey"])))
                    {
                        list.Add(new SqlParameter("@SystemKey", ht["SystemKey"].ToString()));
                    }
                    #endregion

                    if (ht.ContainsKey("Phone"))
                    {
                        if (!string.IsNullOrWhiteSpace(Convert.ToString(ht["Phone"])))
                            list.Add(new SqlParameter("@Phone", Convert.ToString(ht["Phone"])));
                        else
                            list.Add(new SqlParameter("@Phone", null));
                    }
                    if (Convert.ToInt32(ht["UserType"]) == (int)UserType.教师)
                    {
                        if (!string.IsNullOrWhiteSpace(Convert.ToString(ht["JobNumber"])))
                            list.Add(new SqlParameter("@JobNumber", Convert.ToString(ht["JobNumber"])));
                        else
                            list.Add(new SqlParameter("@JobNumber", null));
                        //list.Add(new SqlParameter("@JobNumber", Convert.ToString(ht["JobNumber"])));
                    }
                    else if (Convert.ToInt32(ht["UserType"]) == (int)UserType.学生)
                    {
                        if (ht.ContainsKey("SchoolNO") && !string.IsNullOrEmpty(Convert.ToString(ht["SchoolNO"])))
                        {
                            list.Add(new SqlParameter("@SchoolNO", ht["SchoolNO"].ToString()));
                        }
                        if (ht.ContainsKey("GradeID") && !string.IsNullOrEmpty(Convert.ToString(ht["GradeID"])))
                        {
                            list.Add(new SqlParameter("@GradeID", Convert.ToInt32(ht["GradeID"])));
                        }
                        if (ht.ContainsKey("ClassID") && !string.IsNullOrEmpty(Convert.ToString(ht["ClassID"])))
                        {
                            list.Add(new SqlParameter("@ClassID", Convert.ToInt32(ht["ClassID"])));
                        }
                    }

                    list.Add(new SqlParameter("@IsDelete", Convert.ToInt32((int)Status.正常)));
                    list.Add(new SqlParameter("@UpdateTime", DateTime.Now));
                    list.Add(new SqlParameter("@State", Convert.ToInt32((int)Plat_Teacher_State.待审核)));
                    int number = SQLHelp.ExecuteNonQuery(trans, sbSql4org.ToString(), CommandType.Text, list.ToArray());
                    if (number > 0)
                    {
                        trans.Commit();
                        return number;
                    }
                    else
                        return -1;
                }
                catch (Exception ex)
                {
                    trans.Rollback();
                    return -1;
                }
            }
            
        }

        public DataTable GetGradeAndClassById(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("select ci.*,g.GradeName from Plat_ClassInfo ci inner join Plat_Grade g on ci.GradeID=g.Id where 1=1 ");
                if (ht.ContainsKey("SchoolID") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["SchoolID"])))
                {
                    sbSql4org.Append(" and ci.Id=@Id");
                    List.Add(new SqlParameter("@Id", ht["SchoolID"]));
                }
                if (ht.ContainsKey("GradeID") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["GradeID"])))
                {
                    sbSql4org.Append(" and ci.GradeID=@GradeID");
                    List.Add(new SqlParameter("@GradeID", ht["GradeID"]));
                }
                sbSql4org.Append(" and ci.IsDelete !=@ciDel");
                List.Add(new SqlParameter("@ciDel", (int)Status.删除));
                sbSql4org.Append(" and g.IsDelete !=@gDel");
                List.Add(new SqlParameter("@gDel", (int)Status.删除));
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.ToString());
                return null;
            }
        }

        /// <summary>
        /// 获得教师信息根据身份证号
        /// </summary>
        /// <param name="IDCard"></param>
        /// <returns></returns>
        public DataTable GetTeacherByIDCard(string IDCard)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("select * from Plat_Teacher where IDCard=@IDCard and IsDelete=0");
                List.Add(new SqlParameter("@IDCard", IDCard));
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.ToString());
                return null;
            }
        }

        /// <summary>
        /// 获得班级任课教师信息
        /// </summary>
        /// <param name="IDCard"></param>
        /// <returns></returns>
        public DataTable GetClassTeacher(string ClassID)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("select * from Plat_Teacher where IsDelete=0");
                sbSql4org.Append(" and IDCard in (select TeacherIDCard from Plat_TeacherOfClassOfSubject where ClassID=@ClassID)");
                List.Add(new SqlParameter("@ClassID", ClassID));
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.ToString());
                return null;
            }
        }

        /// <summary>
        /// 获得可分配为班主任的教师
        /// </summary>
        /// <param name="IDCard"></param>
        /// <returns></returns>
        public DataTable GetNotHeadTeacher(string SchoolID, string Columns)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("select " + Columns + " from (");
                sbSql4org.Append("select * from Plat_Teacher where IsDelete=0 and SchoolID=@SchoolID");
                //sbSql4org.Append(" and IDCard not in (select HeadteacherNO from Plat_ClassInfo where SchoolID=@SchoolID and HeadteacherNO is not null)");
                sbSql4org.Append(") Teacher");
                List.Add(new SqlParameter("@SchoolID", SchoolID));
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.ToString());
                return null;
            }
        }

        /// <summary>
        /// 学校里是否存在教师
        /// </summary>
        /// <param name="TeacherIDCard">教师身份证号</param>
        /// <param name="SchoolID">学校ID</param>
        /// <returns></returns>
        public bool IsExistTeacherBySchool(string TeacherIDCard,string SchoolID)
        {
            try
            {
                StringBuilder sb = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sb.Append("select Count(1) from Plat_Teacher where 1=1");
                sb.Append(" and IDCard=@IDCard");
                sb.Append(" and SchoolID=@SchoolID");

                List.Add(new SqlParameter("@IDCard", TeacherIDCard));
                List.Add(new SqlParameter("@SchoolID", SchoolID));
                int number = Convert.ToInt32(SQLHelp.ExecuteScalar(sb.ToString(), CommandType.Text, List.ToArray()));
                if (number == 0)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.ToString());
                return false;
            }
            
        }

        /// <summary>
        /// 修改密码
        /// </summary>
        /// <param name="LoginName">登录账号</param>
        /// <param name="NewPassword">新密码</param>
        /// <returns></returns>
        public bool UpdatePassword(string LoginName, string NewPassword)
        {
            try
            {
                StringBuilder sb = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sb.Append("Update Plat_Teacher set Password=@Password where 1=1");
                sb.Append(" and LoginName=@LoginName");

                List.Add(new SqlParameter("@Password", NewPassword));
                List.Add(new SqlParameter("@LoginName", LoginName));
                int number = Convert.ToInt32(SQLHelp.ExecuteNonQuery(sb.ToString(), CommandType.Text, List.ToArray()));
                if (number == 1)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.ToString());
                return false;
            }
            
        }
    }
}
