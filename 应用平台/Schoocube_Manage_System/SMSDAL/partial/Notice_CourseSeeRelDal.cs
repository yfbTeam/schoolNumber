using SMSIDAL;
using SMSModel;
using SMSUtility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSDAL
{
    public partial class Notice_CourseSeeRelDal : HZ_BaseDal<Notice_CourseSeeRel>, INotice_CourseSeeRelDal
    {
        public int OperNotice_CourseSeeRel(Notice_CourseSeeRel entity)
        {
            int result = 0;
            SqlParameter[] param = { 
                                       new SqlParameter("@Id", entity.Id),
                                       new SqlParameter("@NoticeId", entity.NoticeId),                                     
                                       new SqlParameter("@CreateUID", entity.CreateUID)
                                   };
            object obj = SQLHelp.ExecuteScalar("OperNotice_CourseSeeRel", CommandType.StoredProcedure, param);
            result = Convert.ToInt32(obj);
            return result;
        }
    }
}
