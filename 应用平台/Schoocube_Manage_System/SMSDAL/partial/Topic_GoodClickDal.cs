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
    public partial class Topic_GoodClickDal : HZ_BaseDal<Topic_GoodClick>, ITopic_GoodClickDal
    {
        public int AddGoodClick(Topic_GoodClick entity, Hashtable ht)
        {
            int result = 0;
            SqlParameter[] param = { 
                                       new SqlParameter("@RelationId", entity.RelationId),
                                       new SqlParameter("@Type", entity.Type),
                                       new SqlParameter("@GoodType",ht["GoodType"].ToString()),
                                       new SqlParameter("@CreateUID", entity.CreateUID)
                                   };
            object obj = SQLHelp.ExecuteScalar("AddGoodClick", CommandType.StoredProcedure, param);
            result= Convert.ToInt32(obj);
            return result;
        }
    }
}
