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
    public partial class Couse_SelsettingDal : HZ_BaseDal<Couse_Selsetting>, ICouse_SelsettingDal
    {
        /// <summary>
        /// 添加设置信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public override int Add(Couse_Selsetting entity)
        {
            int result = 0;
            SqlParameter[] param = { 
                                       new SqlParameter("@TermID", entity.TermID),
                                       new SqlParameter("@SelType",entity.SelType),
                                       new SqlParameter("@SelMaxNum",entity.SelMaxNum),
                                       new SqlParameter("@SelMinNum",entity.SelMinNum),
                                       new SqlParameter("@TermName",entity.TermName),
                                       new SqlParameter("@Status", entity.Status),
                                       new SqlParameter("@CreateUID", entity.CreateUID),
                                       new SqlParameter("@WeekSet", entity.WeekSet),

                                   };
            object obj = SQLHelp.ExecuteScalar("AddCourceSet", CommandType.StoredProcedure, param);
            if (obj != null)
            {
                result = Convert.ToInt32(obj);
            }
            return result;
        }
    }
}
