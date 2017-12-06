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
    public partial class Base_ClassInfoDal : BaseDal<Plat_ClassInfo>, IPlat_ClassInfoDal
    {

        /// <summary>
        /// 获得班级数据
        /// </summary>
        /// <returns></returns>
        public DataTable GetNameList(string GradeID, string SystemKey)
        {
            try
            {
                string SQL = @"select a.* from Plat_ClassInfo a";
                SQL += " left join Plat_Grade b on a.GradeID=b.ID";
                SQL += " left join Plat_SystemInfo c on a.SchoolID=c.SchoolID";
                SQL += " where c.SystemKey=@SystemKey and a.GradeID=@GradeID and a.IsDelete=0";
                List<SqlParameter> list = new List<SqlParameter>();
                list.Add(new SqlParameter("@SystemKey", SystemKey));
                list.Add(new SqlParameter("@GradeID", GradeID));
                DataTable dt = SQLHelp.ExecuteDataTable(SQL, CommandType.Text, list.ToArray());
                return dt;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
