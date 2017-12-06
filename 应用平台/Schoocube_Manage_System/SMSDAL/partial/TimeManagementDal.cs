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
    public partial class TimeManagementDal : HZ_BaseDal<TimeManagement>, ITimeManagementDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string Where)
        {

            int PageIndex = 0;
            int PageSize = 0;
            RowCount = 0;
            DataTable dt = new DataTable();
            try
            {
                //获取车辆、会议室、专业会议室的时间列表数据，其他的不需要调用
                if (ht.ContainsKey("GetTime") && !string.IsNullOrEmpty(ht["GetTime"].SafeToString()))
                {
                    if (ht.ContainsKey("Name") && !string.IsNullOrEmpty(ht["Name"].SafeToString()))
                    {
                        StringBuilder sbSql4org = new StringBuilder();
                        sbSql4org.AppendFormat(@"select * from TimeManagement where TimeIntervalId in (
                        select rtm.TimeIntervalId from ResourceTimeMappingId rtm 
                        inner join ResourceReservationCla rrc on  
                        rtm.ResourceId =rrc.Id where rrc.name='{0}'and rrc.IsDelete=0", ht["Name"].SafeToString());
                        if (ht.ContainsKey("ResourceId") && !string.IsNullOrEmpty(ht["ResourceId"].SafeToString()))
                        {
                            sbSql4org.AppendFormat(" and rtm.ResourceId='{0}'", ht["ResourceId"].SafeToString());

                        }
                        sbSql4org.Append(" )  and IsDelete=0 order by BeginTime");
                        dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, null);
                        //dt = SQLHelp.GetListByPage("(" + sbSql4org.ToString() + ")", Where, "", PageIndex, PageSize, IsPage, null, out RowCount);
                    }

                }
                else if (ht.ContainsKey("ValidateTime") && !string.IsNullOrEmpty(ht["ValidateTime"].SafeToString()))
                {
                    //解决bug319在会议室预约时间段冲突
                    StringBuilder sbSql4org = new StringBuilder();
                    sbSql4org.AppendFormat(@"select max(EndTime) as EndTime from TimeManagement where TimeIntervalId in (
                        select rtm.TimeIntervalId from ResourceTimeMappingId rtm 
                        inner join ResourceReservationCla rrc on  
                        rtm.ResourceId =rrc.Id where rrc.name='{0}'and rrc.IsDelete=0", ht["Name"].SafeToString());
                    if (ht.ContainsKey("ResourceId") && !string.IsNullOrEmpty(ht["ResourceId"].SafeToString()))
                    {
                        sbSql4org.AppendFormat(" and rtm.ResourceId='{0}'", ht["ResourceId"].SafeToString());

                    }
                    sbSql4org.Append(" )  and IsDelete=0 group by TimeIntervalId");
                    dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, null);

                }
                else
                {
                    string TimeIntervalId = ht["TimeIntervalId"].SafeToString();

                    if (TimeIntervalId.Length > 0)
                    {
                        Where += " and TimeIntervalId in (" + TimeIntervalId + ")";

                    }
                    Where += " and IsDelete=0";
                    if (IsPage)
                    {
                        PageIndex = Convert.ToInt32(ht["PageIndex"].ToString());
                        PageSize = Convert.ToInt32(ht["PageSize"].ToString());
                    }
                    dt = SQLHelp.GetListByPage((string)ht["TableName"], Where, "", PageIndex, PageSize, IsPage, null, out RowCount);
                }
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
