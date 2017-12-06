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
    public partial class MonitorRecordDal
    {
        public DataTable GetNewRecordForOrder(Hashtable ht, ref int rows)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                if (ht.ContainsKey("RequestType") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["RequestType"])) && Convert.ToInt32(ht["RequestType"])==(int)RecordType.登录)
                    sbSql4org.Append("select CONVERT(varchar(100), RequestDate, 23) RequestDate,count(1) 总记录数,RequestType,RequestSourceName 名称,sum(case when RequestUserType=1 then 1 else 0 end)外部学员,sum(case when RequestUserType=0 then 1 else 0 end) 内部学员,RequestSourceID from  [dbo].[MonitorRecord] where 1=1 ");
                else
                sbSql4org.Append("select RequestSourceName 名称,count(1) 总记录数,RequestType,CONVERT(varchar(100), RequestDate, 23) RequestDate,sum(case when RequestUserType=1 then 1 else 0 end)外部学员,sum(case when RequestUserType=0 then 1 else 0 end) 内部学员,RequestSourceID from  [dbo].[MonitorRecord] where 1=1 ");
                
                if (ht.ContainsKey("RequestSourceID") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["RequestSourceID"])))
                {
                    sbSql4org.Append(" and RequestSourceName like N'%@RequestSourceName%'");
                    List.Add(new SqlParameter("@RequestSourceName", ht["RequestSourceName"].ToString()));
                }
                if (ht.ContainsKey("RequestType") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["RequestType"])))
                {
                    sbSql4org.Append(" and RequestType=@RequestType");
                    List.Add(new SqlParameter("@RequestType", ht["RequestType"].ToString()));
                }
                if (ht.ContainsKey("EndDate") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["EndDate"])) && ht.ContainsKey("StarDate") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["StarDate"])))
                {
                    sbSql4org.Append(" and (RequestDate<=@EndDate and RequestDate>=@StarDate)");
                    List.Add(new SqlParameter("@StarDate", ht["StarDate"].ToString() + " 00:00:01"));
                    List.Add(new SqlParameter("@EndDate", ht["EndDate"].ToString() + " 23:59:59"));
                }
                sbSql4org.Append(" group by  CONVERT(varchar(100), RequestDate, 23),RequestSourceName,RequestType,RequestSourceID");
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                rows = dt.Rows.Count;
                return dt;
            }
            catch (Exception ex)
            {
                rows = 0;
                return null;
            }
        }

        public DataTable GetRecordForResouceID(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                sbSql4org.Append(" select [Creator],[RequestUserType],count(1) Counts from [dbo].[MonitorRecord] where 1=1");
                if (ht.ContainsKey("RequestDate") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["RequestDate"])))
                {
                    sbSql4org.Append(" and CONVERT(varchar(100), RequestDate, 23)=@RequestDate");
                    List.Add(new SqlParameter("@RequestDate", ht["RequestDate"].ToString()));
                }
                if (ht.ContainsKey("RequestSourceID") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["RequestSourceID"])))
                {
                    sbSql4org.Append(" and RequestSourceID=@RequestSourceID");
                    List.Add(new SqlParameter("@RequestSourceID", ht["RequestSourceID"].ToString()));
                }
                sbSql4org.Append(" group by Creator,RequestUserType");
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
        }

        public DataTable GetNetworkflowForOrder(Hashtable ht, ref int rows)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                if (ht.ContainsKey("UserName") && !string.IsNullOrWhiteSpace(ht["UserName"].ToString())) 
                {
                    if (Convert.ToInt32(ht["UserName"]) == (int)VisitUserType.普通用户)
                        sbSql4org.Append("select CONVERT(varchar(100), CreateTime, 23) 时间,sum(case when UserName!='-1' then 1 else 0 end)学员 from [dbo].[System_VisitRate] where 1=1");
                    else
                        sbSql4org.Append("select CONVERT(varchar(100), CreateTime, 23) 时间,sum(case when UserName='-1' then 1 else 0 end)游客 from [dbo].[System_VisitRate] where 1=1");
                }
                else
                {
                    sbSql4org.Append("select CONVERT(varchar(100), CreateTime, 23) 时间,sum(case when UserName='-1' then 1 else 0 end)游客,sum(case when UserName!='-1' then 1 else 0 end)学员 from [dbo].[System_VisitRate] where 1=1");
                }
                if (ht.ContainsKey("StarDate") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["StarDate"])) && ht.ContainsKey("EndDate") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["EndDate"])))
                {
                    var star = ht["StarDate"].ToString() + " 00:00:01";
                    var end = ht["EndDate"].ToString() + " 23:59:59";
                    sbSql4org.Append(" and CreateTime>=@starT and @endT>=CreateTime");
                    List.Add(new SqlParameter("starT", star));
                    List.Add(new SqlParameter("endT", end));
                    //switch (Convert.ToInt32(ht["CreateTime"]))
                    //{
                    //    case (int)enumTimeInterval.今日:
                    //        sbSql4org.Append(" and CONVERT(varchar(100), CreateTime, 23)=@CreateTime");
                    //        List.Add(new SqlParameter("@CreateTime",DateTime.Now.ToString("yyyy-MM-dd")));
                    //        break;
                    //    case (int)enumTimeInterval.三天前:
                    //        sbSql4org.Append(" and CreateTime>=@CreateTime");
                    //        List.Add(new SqlParameter("@CreateTime",DateTime.Now.AddDays(-3).ToString("yyyy-MM-dd HH:mm:dd")));
                    //        break;
                    //    case (int)enumTimeInterval.一个月之内: 
                    //         sbSql4org.Append(" and CreateTime>=@CreateTime");
                    //        List.Add(new SqlParameter("@CreateTime",DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd HH:mm:dd")));
                    //        break;
                    //    case (int)enumTimeInterval.一周之内: 
                    //          sbSql4org.Append(" and CreateTime>=@CreateTime");
                    //        List.Add(new SqlParameter("@CreateTime",DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd HH:mm:dd")));
                    //        break;
                    //}
                }
                else
                {
                    sbSql4org.Append(" and CreateTime>=@CreateTime");
                    List.Add(new SqlParameter("@CreateTime", DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd") + " 00:00:01"));
                }
                if (ht.ContainsKey("UserName") && !string.IsNullOrWhiteSpace(ht["UserName"].ToString()))
                {
                    if (Convert.ToInt32(ht["UserName"]) == (int)VisitUserType.普通用户)
                        sbSql4org.Append(" and UserName!='-1'");
                    else
                        sbSql4org.Append(" and UserName='-1'");
                }
                sbSql4org.Append(" group by  CONVERT(varchar(100), CreateTime, 23)");
                DataTable dt = SQLHelp.ExecuteDataTable(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                if (dt != null) rows = dt.Rows.Count;
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
        }

        public int RemoveUserOnLine(Hashtable ht)
        {
            try
            {
                StringBuilder sbSql4org = new StringBuilder();
                List<SqlParameter> List = new List<SqlParameter>();
                
                if (ht.ContainsKey("logOut") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["logOut"])))
                {
                    sbSql4org.Append("update System_UserOnLine set UserName='游客'  where ICookie=@ICookie ");
                    if (ht.ContainsKey("ICookie") && !string.IsNullOrWhiteSpace(Convert.ToString(ht["ICookie"])))
                    {
                        sbSql4org.Append(" and ICookie=@ICookie");
                        List.Add(new SqlParameter("@ICookie", ht["ICookie"].ToString()));
                    }
                }
                else
                {
                    sbSql4org.Append("delete from System_UserOnLine where CONVERT(INT,DATEDIFF(Minute, CreateDate, getDate()))>6 ");
                }
                int number = SQLHelp.ExecuteNonQuery(sbSql4org.ToString(), CommandType.Text, List.ToArray());
                return number;
            }
            catch (Exception)
            {
                return -1;
            }
        }
    }
}
