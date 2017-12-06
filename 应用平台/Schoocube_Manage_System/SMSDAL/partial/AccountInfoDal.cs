using SMSIDAL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSDAL
{
    public partial class AccountInfoDal : HZ_BaseDal<AccountInfo>, IAccountInfoDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            RowCount = 0;
            DataTable dt = new DataTable();
            int StartIndex = 0;
            int EndIndex = 0;

            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select *  from AccountInfo  where 1=1 and IsDelete=0");

                if (ht.ContainsKey("IdCard") && !string.IsNullOrEmpty(ht["IdCard"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and IdCard ='{0}' ", ht["IdCard"].ToString());
                }
                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                dt = SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", where, "Id", StartIndex, EndIndex, IsPage, null, out RowCount);
            }
            catch (Exception ex)
            {
                //写入日志
                //throw 
                return null;
            }

            return dt;

        }
    }
}
