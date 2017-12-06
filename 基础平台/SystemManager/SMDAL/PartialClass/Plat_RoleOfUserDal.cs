using SMIDAL;
using SMModel;
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
    public partial class Plat_RoleOfUserDal : BaseDal<Plat_RoleOfUser>, IPlat_RoleOfUserDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int rowCount, bool IsPage)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            rowCount = 0;
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select distinct U.* from(
                                    select uinfo.Id,uinfo.LoginName,uinfo.Name,uinfo.Sex,uinfo.IDCard,uinfo.SystemKey,'教师' as UserType from Plat_Teacher uinfo	
                                    union
                                    select uinfo.Id,uinfo.LoginName,uinfo.Name,uinfo.Sex,uinfo.IDCard,uinfo.SystemKey,'学生' as UserType from Plat_Student uinfo
                                     ) U
                                    where U.SystemKey=@SystemKey and U.IDCard != '00000000000000000X' ");
                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].ToString()))
                {
                    sbSql4org.Append(" and U.Name like N'%'+@Name+'%' ");
                    pms.Add(new SqlParameter("@Name", ht["Name"].ToString()));
                }
                if (ht.ContainsKey("RoleId") && !string.IsNullOrEmpty(ht["RoleId"].ToString()))
                {
                    sbSql4org.Append(" and U.IDCard ");
                    if (ht.ContainsKey("JoinStr") && !string.IsNullOrEmpty(ht["JoinStr"].ToString()))
                    {
                        sbSql4org.Append(ht["JoinStr"].ToString());
                    }
                    else
                    {
                        sbSql4org.Append(" in ");

                    }
                    sbSql4org.Append(" (select UserIDCard from Plat_RoleOfUser where RoleId=@RoleId) ");
                    pms.Add(new SqlParameter("@RoleId", ht["RoleId"].ToString()));
                }               
                pms.Add(new SqlParameter("@SystemKey", ht["SystemKey"].ToString()));
                DataTable dt = SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", "", "", Convert.ToInt32(ht["StartIndex"].ToString()), Convert.ToInt32(ht["EndIndex"].ToString()), pms.ToArray(), out rowCount, IsPage);
                return dt;
            }
            catch (Exception ex)
            {
                //写入日志
                //throw;                
                return null;
            }

        }

        #region 删除关系数据， 删单条
        /// <summary>
        /// 删除关系数据， 删单条
        /// </summary>
        public bool DeleteUserRelation(Plat_RoleOfUser roleu)
        {
            try
            {
                StringBuilder sbSql;
                List<SqlParameter> pms = new List<SqlParameter>();

                sbSql = new StringBuilder();
                sbSql.Append("DELETE FROM Plat_RoleOfUser");
                sbSql.Append(" WHERE RoleId=@RoleId and UserIDCard=@UserIDCard");

                pms.Add(new SqlParameter("@RoleId", roleu.RoleId));
                pms.Add(new SqlParameter("@UserIDCard", roleu.UserIDCard));
                return SQLHelp.ExecuteNonQuery(sbSql.ToString(), CommandType.Text, pms.ToArray()) > 0;
            }
            catch (Exception)
            {
                //写入日志
                //throw;
                return false;
            }
        }
        #endregion
    }
}
