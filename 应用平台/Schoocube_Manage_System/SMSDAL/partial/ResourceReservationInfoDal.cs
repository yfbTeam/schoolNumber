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
    public partial class ResourceReservationInfoDal : HZ_BaseDal<ResourceReservationInfo>, IResourceReservationInfoDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            string level = ht["Level"].SafeToString();
            int PageIndex = 0;
            int PageSize = 0;
            RowCount = 0;
            DataTable dt = new DataTable();
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                
                //获取资源信息表里关联预定信息
                if (ht.ContainsKey("ResourceReservation") && !string.IsNullOrEmpty(ht["ResourceReservation"].SafeToString()))
                {
                    sbSql4org.Append(@"select rri.*  from ResourceReservationInfo rri where rri.Id not in (select info.Id  from ResourceReservationInfo info inner join ResourceReservation rr on info.Id = rr.ReSourceInfoId and info.IsDelete=0  and info.UseStatus=0 and rr.IsDelete=0");
                    if (ht.ContainsKey("TimeInterval") && !string.IsNullOrEmpty(ht["TimeInterval"].SafeToString()))
                    {
                        sbSql4org.AppendFormat(@" and rr.TimeInterval like '%{0}%'", ht["TimeInterval"].ToString());

                    }
                    if (ht.ContainsKey("AppoIntmentTime") && !string.IsNullOrEmpty(ht["AppoIntmentTime"].SafeToString()))
                    {
                        sbSql4org.AppendFormat(@" and rr.AppoIntmentTime ='{0}'", ht["AppoIntmentTime"].ToString());

                    }
                    sbSql4org.Append(")");
                    sbSql4org.Append(@"  and rri.UseStatus=0 ");
                }
                else
                {
                    sbSql4org.Append(@"select *  from ResourceReservationInfo rri where 1=1 and rri.IsDelete=0");
                    if (ht.ContainsKey("BookCar") && !string.IsNullOrEmpty(ht["BookCar"].SafeToString()))
                    {
                        sbSql4org.Append(@"  and rri.UseStatus=0 ");
                    }
                }
                
                
                if (ht.ContainsKey("PID") && !string.IsNullOrEmpty(ht["PID"].SafeToString()))
                {
                    if (("1").Equals(level))
                    {
                        sbSql4org.AppendFormat(" and rri.ResourceId in ({0}) ", ht["PID"].ToString());
                    }
                    else
                    {
                        sbSql4org.AppendFormat(" and rri.ResourceId ={0}", ht["PID"].ToString());
                    }

                }

                if (ht.ContainsKey("ID") && !string.IsNullOrEmpty(ht["ID"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and rri.Id ={0} ", ht["ID"].ToString());
                }

                if (ht.ContainsKey("LikeName") && !string.IsNullOrEmpty(ht["LikeName"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and rri.Name like '%{0}%' ", ht["LikeName"].ToString());
                }

                if (ht.ContainsKey("ResourceTypeName") && !string.IsNullOrEmpty(ht["ResourceTypeName"].SafeToString()))
                {
                    sbSql4org.AppendFormat(" and rri.ResourceTypeName ='{0}'", ht["ResourceTypeName"].ToString());
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
