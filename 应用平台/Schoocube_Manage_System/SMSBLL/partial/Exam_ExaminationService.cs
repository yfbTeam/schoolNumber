using SMSDAL;
using SMSIBLL;
using SMSModel;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SMSBLL
{
    public partial class Exam_ExaminationService : BaseService_HZ<Exam_Examination>, IExam_ExaminationService
    {
        Exam_ExaminationDal dal = new Exam_ExaminationDal();
        #region 统计考试成绩
        public DataTable GetStuScore(Hashtable ht, out int RowCount, bool IsPage = true, string Where = "")
        {
            if (IsPage)
            {
                BLLCommon common = new BLLCommon();
                ht = common.AddStartEndIndex(ht);

            }
            return dal.GetStuScore(ht, out RowCount);
        }
        #endregion
        public DataTable GetRecordForStatisc(Hashtable ht, ref int rows)
        {
            return dal.GetNewRecordForOrder(ht, ref rows);
        }
    }
}
