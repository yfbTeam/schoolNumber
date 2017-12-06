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
    public partial class ResourceReservationDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            int PageIndex = 0;
            int PageSize = 0;
            RowCount = 0;
            DataTable dt = new DataTable();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                sbSql4org.Append(@"select *  from ResourceReservation rr where 1=1 and rr.IsDelete=0 and rr.UseStatus=0");
                if (ht.ContainsKey("ResourceTypeName") && !string.IsNullOrEmpty(ht["ResourceTypeName"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and rr.ReSourceInfoId in (select rri.Id from ResourceReservationInfo rri where rri.ResourceTypeName='{0}' and rri.IsDelete=0  and rri.UseStatus=0)", ht["ResourceTypeName"].ToString());
                }

                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and rr.Id = '{0}'", ht["ID"].ToString());
                }
                if (ht.ContainsKey("ReservationAppoIntmentTime") && !string.IsNullOrEmpty(ht["ReservationAppoIntmentTime"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and rr.AppoIntmentTime = '{0}'", ht["ReservationAppoIntmentTime"].ToString());
                }else
                {
                    if (ht.ContainsKey("AppoIntmentTime") && !string.IsNullOrEmpty(ht["AppoIntmentTime"].SafeToString()))
                    {
                        sbSql4org.AppendFormat(" and rr.AppoIntmentTime <> '{0}'", ht["AppoIntmentTime"].ToString());
                    }
                }

                if (ht.ContainsKey("ReservationTimeInterval") && !string.IsNullOrEmpty(ht["ReservationTimeInterval"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and rr.TimeInterval  like '%{0}%'", ht["ReservationTimeInterval"].ToString());
                }else
                {
                    if (ht.ContainsKey("TimeInterval") && !string.IsNullOrEmpty(ht["TimeInterval"].SafeToString()))
                    {
                        sbSql4org.AppendFormat(" and rr.TimeInterval not like '%{0}%'", ht["TimeInterval"].ToString());
                    }
                }
                
                if (ht.ContainsKey("ReSourceInfoId") && !string.IsNullOrEmpty(ht["ReSourceInfoId"].SafeToString())) 
                {
                    sbSql4org.AppendFormat(" and rr.ReSourceInfoId = '{0}'", ht["ReSourceInfoId"].ToString()); 
                }

                if (ht.ContainsKey("ReSourceClassId") && !string.IsNullOrEmpty(ht["ReSourceClassId"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and rr.ReSourceClassId = '{0}'", ht["ReSourceClassId"].ToString());
                }

                if (ht.ContainsKey("IDCard") && !string.IsNullOrEmpty(ht["IDCard"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and rr.IDCard = '{0}'", ht["IDCard"].ToString());
                }

                if (ht.ContainsKey("ApprovalStutus") && !string.IsNullOrEmpty(ht["ApprovalStutus"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and rr.ApprovalStutus = '{0}'", ht["ApprovalStutus"].ToString());
                }

                if (IsPage)
                {
                    PageIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    PageSize = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                dt = SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", where, "", PageIndex, PageSize, IsPage, null, out RowCount);
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
