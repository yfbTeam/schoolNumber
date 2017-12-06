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
    public partial class ClickDetailDal : HZ_BaseDal<ClickDetail>, IClickDetailDal
    {
        public override DataTable GetListByPage(Hashtable ht,out int RowCount, bool IsPage, string where)
        {
            RowCount = 0;
            DataTable dt = new DataTable();
            try
            {
                int StartIndex = 0;
                int EndIndex = 0;

                if (IsPage)
                {
                    StartIndex = Convert.ToInt32(ht["StartIndex"].ToString());
                    EndIndex = Convert.ToInt32(ht["EndIndex"].ToString());
                }
                dt = SQLHelp.GetListByPage("( select click.ID,re.Name as Name,re.CreateTime,click.CreateUID,DATEDIFF(S,'1970-01-01 00:00:00', ClickTime) - 8 * 3600 as ClickTime,CASE postfix WHEN '' THEN 'file' else right(postfix,LEN(postfix) - 1) end  as postfix1 from ClickDetail click  inner join ResourcesInfo Re on click.ResourcesID=re.ID and click.ClickType=3)", where, " ClickTime desc", StartIndex,
                    EndIndex, IsPage, null,out RowCount);
            }
            catch (Exception ex)
            {
                LogService.WriteErrorLog(ex.Message);
            }
            return dt;
        }
    }
}
