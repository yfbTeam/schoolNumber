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
    public partial class SomeTableClickDal : HZ_BaseDal<SomeTableClick>, ISomeTableClickDal
    {
        public int OperSomeTableClick(SomeTableClick entity, Hashtable ht)
        {
            int result = 0;
            SqlParameter[] param = { 
                                       new SqlParameter("@Id", entity.Id),
                                       new SqlParameter("@RelationId", entity.RelationId),
                                       new SqlParameter("@Type", entity.Type),
                                       new SqlParameter("@WatchTime", entity.WatchTime),
                                       new SqlParameter("@ClickTime", entity.ClickTime),
                                       new SqlParameter("@LastTime", entity.LastTime),
                                       new SqlParameter("@ClickNum", entity.ClickNum),
                                       new SqlParameter("@IsLookEnd",entity.IsLookEnd),
                                       new SqlParameter("@CreateUID", entity.CreateUID),
                                       new SqlParameter("@ClassID",ht["ClassID"].ToString()),
                                       new SqlParameter("@DownTime",ht["DownTime"].ToString()),
                                       new SqlParameter("@TotalTime",Math.Ceiling(Convert.ToDecimal(ht["TotalTime"].ToString())))
                                   };
            object obj = SQLHelp.ExecuteScalar("OperSomeTableClick", CommandType.StoredProcedure, param);
            result = Convert.ToInt32(obj);
            return result;
        }
    }
}
