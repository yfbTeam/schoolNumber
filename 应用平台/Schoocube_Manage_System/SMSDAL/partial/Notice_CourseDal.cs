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
    public partial class Notice_CourseDal : HZ_BaseDal<Notice_Course>, INotice_CourseDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            RowCount = 0;
            List<SqlParameter> pms = new List<SqlParameter>();
            DataTable dt = new DataTable();
            try
            {
                int StartIndex = 0;
                int EndIndex = 0;
                string StuIDCard = ht["StuIDCard"].SafeToString();
                StringBuilder sb = new StringBuilder();
                sb.Append(@"select notice.*,convert(varchar(16),notice.CreateTime,21) as CreateTime_Format ");
                if (!string.IsNullOrEmpty(StuIDCard))
                {
                    sb.Append(@",isnull(rel.Id,0) as RelId,case when rel.Id is null then 0 else 1 end as IsRead,isnull(rel.ClickNum,0) as ClickNum ");
                }
                sb.Append("from Notice_Course notice ");
                if (!string.IsNullOrEmpty(StuIDCard))
                {
                    sb.Append(@" left join Notice_CourseSeeRel rel on notice.Id=rel.NoticeId
                                                     and rel.IsDelete=0 and rel.CreateUID=@StuIDCard ");
                    pms.Add(new SqlParameter("@StuIDCard", StuIDCard));
                }
                sb.Append(" where 1=1 and notice.IsDelete=0 ");                
                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                dt = SQLHelp.GetListByPage("(" + sb.ToString() + ")", where, "IsTop desc,T.Id desc", StartIndex, EndIndex, IsPage, pms.ToArray(), out RowCount);
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
    }
}
