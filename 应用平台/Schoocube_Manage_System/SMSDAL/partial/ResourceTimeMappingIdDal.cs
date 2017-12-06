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
    public partial class ResourceTimeMappingIdDal : HZ_BaseDal<ResourceTimeMappingId>, IResourceTimeMappingIdDal
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
                sbSql4org.Append(@"select *  from ResourceTimeMappingId tm where 1=1 and IsDelete=0");

                //根据资源Id来查询
                if (ht.ContainsKey("ResourceId") && !string.IsNullOrEmpty(ht["ResourceId"].ToString()))
                {
                    sbSql4org.AppendFormat(" and tm.ResourceId in ({0}) ", ht["ResourceId"].ToString());

                }

                //根据时间段来查询
                if (ht.ContainsKey("TimeIntervalId") && !string.IsNullOrEmpty(ht["TimeIntervalId"].ToString()))
                {
                    sbSql4org.AppendFormat(" and tm.TimeIntervalId in ({0}) ", ht["TimeIntervalId"].ToString());
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
