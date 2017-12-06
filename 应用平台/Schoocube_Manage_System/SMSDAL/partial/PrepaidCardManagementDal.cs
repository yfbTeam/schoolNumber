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
    public partial class PrepaidCardManagementDal : HZ_BaseDal<PrepaidCardManagement>, IPrepaidCardManagementDal
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
                sbSql4org.Append(@"select *  from PrepaidCardManagement pcm where 1=1 and pcm.IsDelete=0");

                if (ht.ContainsKey("Id") && !string.IsNullOrEmpty(ht["Id"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and pcm.Id ='{0}' ", ht["Id"].ToString());
                }

                if (ht.ContainsKey("UserName") && !string.IsNullOrEmpty(ht["UserName"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and pcm.UserName like '%{0}%' ", ht["UserName"].ToString());
                }

                if (ht.ContainsKey("CardNo") && !string.IsNullOrEmpty(ht["CardNo"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and pcm.CardNo ='{0}' ", ht["CardNo"].ToString());
                }

                if (ht.ContainsKey("Pwd") && !string.IsNullOrEmpty(ht["Pwd"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and pcm.Pwd ='{0}' ", ht["Pwd"].ToString());
                }

                if (ht.ContainsKey("Price") && !string.IsNullOrEmpty(ht["Price"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and pcm.Price ='{0}' ", ht["Price"].ToString());
                }

                if (ht.ContainsKey("IdCard") && !string.IsNullOrEmpty(ht["IdCard"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and pcm.IdCard ='{0}' ", ht["IdCard"].ToString());
                }

                if (ht.ContainsKey("UseStatus") && !string.IsNullOrEmpty(ht["UseStatus"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and pcm.UseStatus ='{0}' ", ht["UseStatus"].ToString());
                }

                if (ht.ContainsKey("CardStatus") && !string.IsNullOrEmpty(ht["CardStatus"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and pcm.CardStatus ='{0}' ", ht["CardStatus"].ToString());
                }

                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                dt = SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", where, "", StartIndex, EndIndex, IsPage, null, out RowCount);
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
