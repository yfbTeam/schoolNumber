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
    public partial class Plat_InterfaceDal : BaseDal<Plat_Interface>, IPlat_InterfaceDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int rowCount, bool IsPage)
        {
            List<SqlParameter> pms = new List<SqlParameter>();
            rowCount = 0;
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select inf.* from Plat_Interface inf
                                    where inf.IsDelete=0  ");
                if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].ToString()))
                {
                    sbSql4org.Append(" and inf.Name like N'%'+@Name+'%' ");
                    pms.Add(new SqlParameter("@Name", ht["Name"].ToString()));
                }
                DataTable dt = SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", "", "", Convert.ToInt32(ht["StartIndex"].ToString()), Convert.ToInt32(ht["EndIndex"].ToString()), pms.ToArray(),out rowCount, IsPage);
                return dt;
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
