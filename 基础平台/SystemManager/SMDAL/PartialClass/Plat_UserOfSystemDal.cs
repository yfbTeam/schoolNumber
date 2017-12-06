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

namespace SMDAL
{
    public partial class Plat_UserOfSystemDal : BaseDal<Plat_UserOfSystem>, IPlat_UserOfSystemDal
    {
        /// <summary>
        /// 获得用户系统数据
        /// </summary>
        /// <param name="LoginName">登录账号</param>
        /// <param name="Password">密码</param>
        /// <returns></returns>
        public DataTable GetSystemUser(string LoginName, string SystemKey)
        {
            try
            {
                string SQL = @"select * from Plat_UserOfSystem a left join Plat_SystemInfo b on a.SystemID=b.Id where 1=1 ";
                SQL += " and a.LoginName=@LoginName and b.SystemKey=@SystemKey";
                List<SqlParameter> list = new List<SqlParameter>();
                list.Add(new SqlParameter("@LoginName", LoginName));
                list.Add(new SqlParameter("@SystemKey", SystemKey));
                DataTable dt = SQLHelp.ExecuteDataTable(SQL, CommandType.Text, list.ToArray());
                return dt;
            }
            catch (Exception)
            {

                throw;
            }
        }

        ///// <summary>
        ///// 获得用户系统数据
        ///// </summary>
        ///// <param name="IDCard">身份证号</param>
        ///// <param name="SystemKey">系统key</param>
        ///// <returns></returns>
        //public DataTable GetSystemUser(string IDCard, string SystemKey)
        //{
        //    try
        //    {
        //        string SQL = @"select * from Plat_UserOfSystem where 1=1 ";
        //        SQL += " and IDCard=@IDCard and SystemKey=@SystemKey";
        //        List<SqlParameter> list = new List<SqlParameter>();
        //        list.Add(new SqlParameter("@IDCard", IDCard));
        //        list.Add(new SqlParameter("@SystemKey", SystemKey));
        //        DataTable dt = SQLHelp.ExecuteDataTable(SQL, CommandType.Text, list.ToArray());
        //        return dt;
        //    }
        //    catch (Exception)
        //    {

        //        throw;
        //    }
        //}
    }
}
