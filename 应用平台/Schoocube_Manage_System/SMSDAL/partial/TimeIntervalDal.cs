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
    public partial class TimeIntervalDal : HZ_BaseDal<TimeInterval>, ITimeIntervalDal
    {
        public override DataTable GetListByPage(Hashtable ht, out int RowCount, bool IsPage, string where)
        {
            int StartIndex = 0;
            int EndIndex = 0;
            RowCount = 0;
            DataTable dt = new DataTable();
            try
            {
                where += " and IsDelete=0";
                        dt = SQLHelp.GetListByPage((string)ht["TableName"], where, "", StartIndex,
                      EndIndex, IsPage, null, out RowCount);                  
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
