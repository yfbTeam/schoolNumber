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
    public partial class SBTQ_AssoActivityDal : HZ_BaseDal<SBTQ_AssoActivity>, ISBTQ_AssoActivityDal
    {
        #region 班级动态查询
        /// <summary>
        /// 动态查询
        /// </summary>
        /// <param name="ht"></param>
        /// <param name="RowCount"></param>
        /// <param name="IsPage"></param>
        /// <param name="Where"></param>
        /// <returns></returns>
        public DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string Where)
        {
            RowCount = 0;
            DataTable dt = new DataTable();
            List<SqlParameter> pms = new List<SqlParameter>();
            try
            {
                int StartIndex = 1;
                int EndIndex = 1;
                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append("select Id,'" + ht["ImageURL"].ToString() + "' + ActivityImg as ActivityImg,ActivityTitle,CreateTime,ActivityContent from SBTQ_AssoActivity where 1=1");

                if (ht.Contains("ClassID"))
                {
                    sbSql4org.Append(" and ClassID=@ClassID");
                    pms.Add(new SqlParameter("@ClassID", ht["ClassID"].ToString()));
                }
                if (ht.Contains("ID"))
                {
                    sbSql4org.Append(" and ID=@ID");
                    pms.Add(new SqlParameter("@ID", ht["ID"].ToString()));
                }

                dt = SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", Where, "", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
        #endregion
    }
}
