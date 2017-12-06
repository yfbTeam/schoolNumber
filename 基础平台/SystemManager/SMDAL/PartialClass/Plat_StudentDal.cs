using SMIDAL;
using SMModel;
using SMUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SMSUtility;

namespace SMDAL
{
    public partial class Plat_StudentDal : BaseDal<Plat_Student>, IPlat_StudentDal
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
                string SQL = @"select *,'学生' as SF from Plat_Student where 1=1 ";
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
                return null;
            }
        }
        /// <summary>
        /// 加入班级
        /// </summary>
        /// <param name="LoginName">登录账号</param>
        /// <param name="Password">密码</param>
        /// <returns></returns>
        public int JoinClass(string ClassID, string IDCards)
        {
            try
            {
                string SQL = @"update Plat_Student set ClassID=@ClassID where 1=1";
                List<SqlParameter> list = new List<SqlParameter>();
                list.Add(new SqlParameter("@ClassID", ClassID));

                string[] sdf = IDCards.Split(',');
                string IDCardsPara = "";
                for (int i = 0; i < sdf.Length; i++)
			    {
                    IDCardsPara += ",@IDCards" + i;
                    list.Add(new SqlParameter("@IDCards" + i, sdf[i]));
			    }

                IDCardsPara = IDCardsPara.Substring(1);
                SQL += " and IDCard in (" + IDCardsPara + ")";
                int count = SQLHelp.ExecuteNonQuery(SQL,CommandType.Text,  list.ToArray());
                return count;
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.ToString());
                return 0;
            }
        }

        /// <summary>
        /// 获得学生信息--根据班级
        /// </summary>
        /// <param name="ClassID">班级ID</param>
        /// <returns></returns>
        public DataTable GetStudentByClass(string ClassID)
        {
            try
            {
                string SQL = @"select * from Plat_Student where ClassID=@ClassID and IsDelete=0";
                List<SqlParameter> list = new List<SqlParameter>();
                list.Add(new SqlParameter("@ClassID", ClassID));
                DataTable dt = SQLHelp.ExecuteDataTable(SQL, CommandType.Text, list.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.ToString());
                return null;
            }
        }
        /// <summary>
        /// 获得同班同学信息--根据学生
        /// </summary>
        /// <param name="StuIDCrad">学生身份证号</param>
        /// <returns></returns>
        public DataTable GetClassStudent(string StuIDCrad)
        {
            try
            {
                string SQL = @"select * from Plat_Student where IsDelete=0 and ClassID=(select ClassID from Plat_Student where IDCard=@IDCard)";
                List<SqlParameter> list = new List<SqlParameter>();
                list.Add(new SqlParameter("@IDCard", StuIDCrad));
                DataTable dt = SQLHelp.ExecuteDataTable(SQL, CommandType.Text, list.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.ToString());
                return null;
            }
        }
        /// <summary>
        /// 获得教师所教的所有学生
        /// </summary>
        /// <param name="TeaIDCrad">教师身份证号</param>
        /// <returns></returns>
        public DataTable GetStudentByTeacher(string TeacherIDCard)
        {
            try
            {
                string SQL = @"select * from Plat_Student where IsDelete=0 and ClassID=(select ClassID from Plat_TeacherOfClassOfSubject where TeacherIDCard=@TeacherIDCard)";
                List<SqlParameter> list = new List<SqlParameter>();
                list.Add(new SqlParameter("@TeacherIDCard", TeacherIDCard));
                DataTable dt = SQLHelp.ExecuteDataTable(SQL, CommandType.Text, list.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.ToString());
                return null;
            }
        }
        /// <summary>
        /// 学校里是否存在学生
        /// </summary>
        /// <param name="TeacherIDCard">学生身份证号</param>
        /// <param name="SchoolID">学校ID</param>
        /// <returns></returns>
        public bool IsExistStudentBySchool(string StudentIDCard, string SchoolID)
        {
            StringBuilder sb = new StringBuilder();
            List<SqlParameter> List = new List<SqlParameter>();
            sb.Append("select Count(1) from Plat_Student where 1=1");
            sb.Append(" and IDCard=@IDCard");
            sb.Append(" and SchoolID=@SchoolID");

            List.Add(new SqlParameter("@IDCard", StudentIDCard));
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
                sb.Append("Update Plat_Student set Password=@Password where 1=1");
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
