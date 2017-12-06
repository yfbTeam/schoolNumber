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
   public partial class UserCardInfoDal : HZ_BaseDal<UserCardInfo>, IUserCardInfoDal
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
                sbSql4org.Append(@"select pcm.CardNo,pcm.Price,uci.UserName,uci.PayTime  from UserCardInfo uci left join PrepaidCardManagement pcm on uci.CardId =pcm.Id where 1=1 and pcm.IsDelete=0 and uci.IsDelete=0");
                
                if (ht.ContainsKey("UserName") && !string.IsNullOrEmpty(ht["UserName"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and uci.UserName like %{0}% ", ht["UserName"].ToString());
                }

                if (ht.ContainsKey("Id") && !string.IsNullOrEmpty(ht["Id"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and uci.Id ='{0}' ", ht["Id"].ToString());
                }

                if (ht.ContainsKey("Price") && !string.IsNullOrEmpty(ht["Price"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and pcm.Price ='{0}' ", ht["Price"].ToString());
                }

                if (ht.ContainsKey("IdCard") && !string.IsNullOrEmpty(ht["IdCard"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and uci.IdCard ='{0}' ", ht["IdCard"].ToString());
                }

                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                dt = SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", where, "CardNo", StartIndex, EndIndex, IsPage, null, out RowCount);
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
