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
    public partial class AdvertisingDal
    {
        public DataTable GetDataInfo(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append("select * from Advertising where 1=1 ");
                if (ht.ContainsKey("MenuIds") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["MenuIds"])))
                {
                    sbSql4org.Append(" and [MenuId] in (" + ht["MenuIds"].ToString() + ")");
                }
                if (ht.ContainsKey("IsDelete") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["IsDelete"])))
                {
                    sbSql4org.Append(" and IsDelete=@IsDelete");
                    List.Add(new SqlParameter("@IsDelete", ht["IsDelete"].ToString()));
                }
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
        }


    }
}
